// $Id: $
// File name:   new_calibrator.sv
// Created:     4/25/2014
// Author:      Shreyas Ganesh Sundararaman
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Calibrates the weights of the neural network

module new_calibrator (
  input wire clk,
  input wire n_rst,
  input reg enable,
  //current weight inputs
  input wire signed [4:0] curr_tr_ns_weight, curr_tr_ew_weight, curr_ped_ns_weight, curr_ped_ew_weight, curr_time_weight,
  //sram inputs
  input wire [6:0] tns, tew, pns, pew,
  input wire signed [13:0] sram_NS_out,sram_EW_out,
  input wire sram_dir_out,
  input wire signed [7:0] sram_time_change,
  //outputs to sram control
  output reg ready,
  //output reg [9:0] Address,
  output reg SRAM_enable,
  //output to NN
  output reg signed [4:0] new_tr_ns_weight,new_tr_ew_weight,new_ped_ns_weight,new_ped_ew_weight,new_time_weight,
  output reg dir_out
);
int i,j,k,z,emre_var;
//reg [9:0] next_Address;
wire signed [7:0] sram_traffic_ns, sram_traffic_ew,sram_ped_ns,sram_ped_ew;
reg signed [16:0] guess_time_out;
reg signed [13:0] guess_NS_out,guess_EW_out,error_NS_out,error_EW_out,higher,guess_time_in;
reg signed [7:0] guess_time_change,error_time_change;
reg signed [20:0] error_calc_NS,error_calc_EW,error_calc_time;
reg signed [4:0] curr_tr_ns_w, curr_tr_ew_w, curr_ped_ns_w, curr_ped_ew_w, curr_time_w;
typedef enum bit[1:0] {CHILL,Calculate,Done} state_type;

assign sram_traffic_ns = {0, tns};
assign sram_traffic_ew = {0, tew};
assign sram_ped_ns = {0, pns}; 
assign sram_ped_ew = {0, pew};


state_type state,nextstate;
always @(posedge clk,negedge n_rst)
  begin:StateReg
  if(n_rst == '0) begin
     state <= CHILL;
     //Address <= 0;
  end else begin
      state <= nextstate;
      //Address <= next_Address;
  end
end

always_comb begin
  
  new_time_weight = curr_time_weight;
  new_tr_ns_weight = curr_tr_ns_weight;
  new_tr_ew_weight = curr_tr_ew_weight;
  new_ped_ns_weight = curr_ped_ns_weight;
  new_ped_ew_weight = curr_ped_ew_weight;
  guess_time_in = 0;
  dir_out = 0;
  ready = enable;
  nextstate = state;
  //next_Address = Address + 1;
  case(state)
    CHILL : begin
     if (enable == 1'b1) begin
         nextstate = Calculate;
      end else begin
        nextstate = CHILL;
      end 
    end
    Calculate : begin
      
      // NS CORRECTIONS
      emre_var = 0;
      i=0;
      z=0;
      if(guess_NS_out > (sram_NS_out + 20) || guess_NS_out < (sram_NS_out - 20) ) begin
        error_NS_out = sram_NS_out - guess_NS_out;
        error_calc_NS = error_NS_out*(sram_traffic_ns);
        for(z=19;z>=0;z=z-1) begin
          if(error_calc_NS[z] == 1'b1) begin
            emre_var = z;
          end else begin
            i=i+1; //FILLER STATEMENT
          end
        end
        new_tr_ns_weight = curr_tr_ns_weight + (emre_var/2);
       
        new_ped_ns_weight = ((sram_NS_out - (new_tr_ns_weight*sram_traffic_ns))/sram_ped_ns);
        
      end else begin
        error_NS_out = 0;
        new_tr_ns_weight = curr_tr_ns_weight;
        new_ped_ns_weight = curr_ped_ns_weight;
      end
      
    
      
      //EW CORRECTIONS
     
      
      if(guess_EW_out > sram_EW_out + 20 || guess_EW_out < sram_EW_out - 20) begin
        error_EW_out = sram_EW_out - guess_EW_out;
        error_calc_EW = error_EW_out*(sram_traffic_ew);
        emre_var = 0;
        z=0;
        for(z=19;z>=0;z=z-1) begin
          if(error_calc_EW[z] == 1'b1) begin
            emre_var = z;
          end else begin
            i=i+1; //FILLER STATEMENT
          end
        end
        new_tr_ew_weight = curr_tr_ew_weight + (emre_var/2);
        new_ped_ew_weight = ((sram_EW_out - (new_tr_ew_weight*sram_traffic_ew))/sram_ped_ew);
      
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
               emre_var = i;
          end
      end
      guess_time_change[6:0] = emre_var*8;  //HIGH VAL = 8*15 = 120 seconds
                                     //LOW VAL  = 8*0 = 0 seconds
      guess_time_change[7] = (guess_time_out[16])? 1'b1:1'b0;  
                              
      if(guess_time_change > sram_time_change + 20 || guess_time_change < sram_time_change - 20) begin
        error_time_change = sram_time_change - guess_time_change;
        error_calc_time = error_time_change*(sram_time_change);
        for(z = 13;z >= 0; z = z-1) begin
          if(error_calc_time[z] == 1'b1) begin
            emre_var = z;
          end else begin
            i=i+1; //WASTE OPERATION
          end
        end
        // 13/2 = 6
        //0/2 = 0
        
        new_time_weight = curr_time_weight + (emre_var/2);
        
        dir_out = (sram_EW_out > sram_NS_out)? 1'b0 : 1'b1;
      end
      
    nextstate = Done;   

    
    end //ends the Calculate State
    
    Done : begin
      nextstate = CHILL;
    end
  endcase

end


    
neuron trial_NS (
        .clk(clk),
        .n_rst(n_rst),
        .input1(tns),
        .input2(pns),
        .weight1(curr_tr_ns_weight),
        .weight2(curr_ped_ns_weight),
        .addout(guess_NS_out)
        );
        

neuron trial_EW (
        .clk(clk),
        .n_rst(n_rst),
        .input1(tew),
        .input2(pew),
        .weight1(curr_tr_ew_weight),
        .weight2(curr_ped_ew_weight),
        .addout(guess_EW_out)
        );
        
sneuron trial_time (
      .clk(clk),
      .n_rst(n_rst),
      .zInput(guess_time_in),
      .zWeight(curr_time_weight),
      .zOut(guess_time_out)
      );
         


endmodule