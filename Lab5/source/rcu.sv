// $Id: $
// File name:   rcu.sv
// Created:     2/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Reciever Control Unit 

module rcu
(
  input wire clk,
  input wire n_rst,
  input wire start_bit_detected,
  input wire packet_done,
  input wire framing_error,
  output reg sbc_clear,
  output reg sbc_enable,
  output reg load_buffer,
  output reg enable_timer

);

typedef enum bit[2:0]{WAIT,START,RECIEVE,LAST_BIT_CHECK,IF_ERROR,LOAD} state_type;
state_type state,next_state;

always @(posedge clk, negedge n_rst) begin
  if(n_rst == 1'b0)begin
    state <= WAIT;
  end else begin
    state <= next_state;
  end
  
end

always_comb begin
    next_state = state;
    enable_timer = 1'b0;
    sbc_clear = 1'b0;
    sbc_enable = 1'b0;
    load_buffer = 1'b0; 
  case(state)  
      WAIT: begin
        if(start_bit_detected == 1'b1) begin
            next_state = START;
        end else begin
            next_state = WAIT;
        end      
      end
      
      START: begin
         enable_timer = 1'b1;
         sbc_clear = 1'b1;
         next_state = RECIEVE;
       end
       
       RECIEVE: begin
          enable_timer = 1'b1;
         if(packet_done == 1'b1) begin
           next_state = LAST_BIT_CHECK;
         end else begin
            next_state = RECIEVE;
         end
       end
       
       LAST_BIT_CHECK: begin
         sbc_enable = 1'b1;
         next_state = IF_ERROR;
       end
       
       IF_ERROR: begin
          sbc_enable = 1'b1;
          if(framing_error == 1'b1) begin
            next_state = WAIT;
          end else begin
            next_state = LOAD;
          end 
       end
       
       LOAD: begin
          load_buffer = 1'b1;
          next_state = WAIT; 
       end
       
  endcase
end

endmodule