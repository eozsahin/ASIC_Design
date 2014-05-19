// $Id: $
// File name:   timer.sv
// Created:     2/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: timing controller 

module timer
(
  input wire clk,
  input wire n_rst,
  input wire enable_timer,
  output wire shift_strobe,
  output reg packet_done
);

typedef enum bit[3:0] {WAIT1,WAIT2,EN,CNT,OK} state_type;
state_type state,next_state;


reg en_counter;
reg clr;
reg [3:0] out_val;
reg [3:0] cnt_val;
reg [6:0] ind = 7'b0000000;
reg [6:0] next_ind;


always @(posedge clk,negedge n_rst)
  begin:StateReg
  if(n_rst == 1'b0) begin
     clr <= 1'b1;
     state <= WAIT1;
     ind <= '0;
  end else begin
      clr <= 1'b0;
      state <= next_state;
      ind <= next_ind;
  end
end
  
always_comb begin
    next_state = state;
    en_counter = 1'b0;
    packet_done = 1'b0;
    next_ind = ind;
    
    case(state)
        WAIT1: begin
          if(enable_timer == 1'b1) begin
            next_state = WAIT2;
          end else begin
            next_state = WAIT1;
          end
        end
        
        WAIT2: begin
            next_state = EN;
        end
        
        EN : begin
          en_counter = 1'b1;
          next_state = CNT;
        end
        
        CNT: begin
          en_counter = 1'b1;
          next_ind = ind + 7'b0000001;
          if(next_ind >= 7'b01011111) begin
              next_ind = '0;
              packet_done = 1'b1;
              next_state = OK;
          end else begin
              next_state = CNT;
          end
        end
        
        OK: begin
          next_state = WAIT1;
        end 
    endcase
end

flex_counter #(
  .NUM_CNT_BITS(4)
)
cnt10cyc
(
  .clk(clk),
  .n_rst(n_rst),
  .count_enable(en_counter),
  .rollover_val(4'b1010),
  .rollover_flag(shift_strobe),
  .count_out(out_val),
  .clear()
);
          
endmodule