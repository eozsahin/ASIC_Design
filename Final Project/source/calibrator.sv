// $Id: $
// File name:   calibrator.sv
// Created:     4/25/2014
// Author:      Shreyas Ganesh Sundararaman
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Calibrates the weights of the neural network

module calibrator (
  input wire clk,
  input wire n_rst,
  input reg enable,
  input wire SRAM_ready,
  //current weight inputs
  input wire signed [4:0] curr_tr_ns_weight, curr_tr_ew_weight, curr_ped_ns_weight, curr_ped_ew_weight, curr_time_weight,
  //sram inputs
  input wire [6:0] tns, tew, pns, pew,
  input wire signed [13:0] sram_NS_out,sram_EW_out,
  input wire sram_dir_out,
  input wire signed [7:0] sram_time_change,
  //outputs to sram control
  output reg ready,
  output reg [9:0] Address,
  output reg SRAM_enable,
  //output to NN
  output reg signed [4:0] new_tr_ns_weight,new_tr_ew_weight,new_ped_ns_weight,new_ped_ew_weight,new_time_weight
);
//$display ("traffic_ns is %d",curr_tr_ns_weight)
int i,j,k,z;
reg [9:0] next_Address;
wire signed [7:0] sram_traffic_ns, sram_traffic_ew,sram_ped_ns,sram_ped_ew;
reg signed [16:0] guess_time_out;
reg signed [13:0] guess_NS_out,guess_EW_out,error_NS_out,error_EW_out,higher,guess_time_in;
reg signed [7:0] guess_time_change,error_time_change;
reg signed [20:0] error_calc_NS,error_calc_EW;
typedef enum bit[3:0] {CHILL,GetData,Calculate,Done} state_type;

assign sram_traffic_ns = {0, tns};
assign sram_traffic_ew = {0, tew};
assign sram_ped_ns = {0, pns}; 
assign sram_ped_ew = {0, pew};

reg [18:0] error_notscaled_ew;
reg [18:0] error_notscaled_ns;
reg [3:0] bin_ns;
reg [3:0] bin_ew;
reg [4:0] new_bin_ns;
reg [4:0] new_bin_ew;
neuron trial_NS (
        .input1(tns),
        .input2(pns),
        .weight1(curr_tr_ns_weight),
        .weight2(curr_ped_ns_weight),
        .addout(guess_NS_out)
        );

neuron trial_EW (
        .input1(tew),
        .input2(pew),
        .weight1(curr_tr_ew_weight),
        .weight2(curr_ped_ew_weight),
        .addout(guess_EW_out)
        );
        
sneuron trial_time (
      .zInput(guess_time_in),
      .zWeight(curr_time_weight),
      .zOut(guess_time_out)
      );
        
                

state_type state,nextstate;
always @(posedge clk,negedge n_rst)
  begin:StateReg
  if(n_rst == '0) begin
     state <= CHILL;
     Address <= 1'b0;
  end else begin
      state <= nextstate;
      Address <= next_Address;
  end
end

always_comb begin
  nextstate = state;
  next_Address = next_Address + 1;
  ready = 1'b0;
  //enable = 1'b0;
  SRAM_enable = 1'b0;
  //guess_NS_out = '0;
  //guess_EW_out = '0;
  case(state)
    CHILL : begin
     if (enable == 1'b1) begin
         nextstate = GetData;
      end else begin
        nextstate = CHILL;
      end 
    end
    
    GetData : begin
      SRAM_enable = 1'b1;
      if (SRAM_ready == 1'b1) begin
        nextstate = Calculate;
      end else begin
        nextstate = GetData;
      end
    end
    
    Calculate : begin
      // NS CORRECTIONS
      
      if(guess_NS_out > sram_NS_out + 20 || guess_NS_out < sram_NS_out - 20) begin
        error_NS_out = sram_NS_out - guess_NS_out;
        error_calc_NS = curr_tr_ns_weight + error_NS_out*(sram_traffic_ns);
        for(z=19;z>=0;z=z-1) begin
          if(error_calc_NS[z] == 1'b1) begin
            break;
          end
        end
        new_tr_ns_weight = z/2;
        
        /*
        error_notscaled_ns = error_NS_out*sram_traffic_ns;
        for(z = 1;z < 15;z = z+1) begin
          if(error_notscaled_ns < 34953 * z) begin
            bin_ns = z - 1;
            z = 15;
          end else begin
            bin_ns = 0;
          end
        end
        
        new_bin_ns = error_notscaled_ns + curr_tr_ns_weight;
        
        for(z = 1;z <15;z=z+1 ) begin
          if(new_bin_ns < 2*z) begin
            new_tr_ns_weight = z - 1;
            z = 15;
          end else begin
            new_tr_ns_weight = 0;
          end
        end
        */
        new_ped_ns_weight = ((sram_NS_out - (new_tr_ns_weight*sram_traffic_ns))/sram_ped_ns);
      end else begin
        error_NS_out = 0;
        new_tr_ns_weight = curr_tr_ns_weight;
        new_ped_ns_weight = curr_ped_ns_weight;
      end
      
      //EW CORRECTIONS
      
      //0-15
      
     
      
      if(guess_EW_out > sram_EW_out + 20 || guess_EW_out < sram_EW_out - 20) begin
        error_EW_out = sram_EW_out - guess_EW_out;
        //$display ("error =  %d", error_EW_out);
        
        //new_tr_ew_weight = curr_tr_ew_weight + error_EW_out*(sram_traffic_ew);
        error_calc_EW =  curr_tr_ew_weight + error_EW_out*(sram_traffic_ew);
        for(z=19;z>=0;z=z-1) begin
          if(error_calc_EW[z] == 1'b1) begin
            break;
          end
        end
        new_tr_ew_weight = z/2;
        
        /*
        error_notscaled_ew = error_EW_out*sram_traffic_ew;
        for(z = 1;z < 15;z = z+1) begin
          if(error_notscaled_ew < 34953 * z) begin
            bin_ew = z - 1;
            z = 15;
          end else begin
            bin_ew = 0;
          end
        end
        
        new_bin_ew = error_notscaled_ew + curr_tr_ew_weight;
        
        for(z = 1;z <15;z=z+1 ) begin
          if(new_bin_ew < 2*z) begin
            new_tr_ew_weight = z - 1;
            z = 15;
          end else begin
            new_tr_ew_weight = 0;
          end
        end
        
        */
        
           
        new_ped_ew_weight = ((sram_EW_out - (new_tr_ew_weight*sram_traffic_ew))/sram_ped_ew);
        /*
        $display(" curr_tr_ew_weight = %d, error_EW_out = %d , sram_traffic_ew = %d",curr_tr_ew_weight,error_EW_out,sram_traffic_ew); 
        $display("n EW traffic weight is %d",new_tr_ew_weight);
        $display ("the product of error_EW_out on sram_traffic_ew is %d",error_EW_out*sram_traffic_ew);
        $display("n EW ped weight is %d", new_ped_ew_weight);
        */      
      end else begin
        error_EW_out = 0;
        new_tr_ew_weight = curr_tr_ew_weight;
        new_ped_ew_weight = curr_ped_ew_weight;
      end
        
       
       
      //TIME CORRECIONS
      if (sram_EW_out > sram_NS_out) begin
        higher = sram_EW_out;
        guess_time_in = sram_EW_out - sram_NS_out;
      end else begin
        higher = sram_NS_out;
        guess_time_in = sram_NS_out - sram_EW_out;
      end
      
      for (i=15;i>=0;i=i-1) begin
          if(guess_time_out == 1'b1) begin
               break;
          end
      end
      guess_time_change[6:0] = i*8;  //HIGH VAL = 8*15 = 120 seconds
                                     //LOW VAL  = 8*0 = 0 seconds
      guess_time_change[7] = (guess_time_out[16])? 1'b1:1'b0;                          
      if(guess_time_change > sram_time_change + 20 || guess_time_change < sram_time_change - 20) begin
        error_time_change = sram_time_change - guess_time_change;
        new_time_weight = curr_time_weight + error_time_change*(sram_time_change);
      end
      
    nextstate = Done;   
    end //ends the Calculate State
    
    Done : begin
      ready = 1'b1;
      //enable = 1'b1;
      nextstate = CHILL;
    end
  endcase

end
endmodule