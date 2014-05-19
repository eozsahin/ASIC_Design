// $Id: $
// File name:   moore.sv
// Created:     2/14/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Moore Machine 1101 Detector 

module moore
(
	input wire clk,n_rst,i,
	output wire o	
);

typedef enum bit[2:0]{WAIT,ST1,ST11,ST110,ST1101} state_type;
state_type state,next_state;

always @(posedge clk, negedge n_rst) begin 
  if(n_rst == 0)begin
      state <= WAIT;
  end else begin
      state <= next_state;
  end
end

always @(state,i) begin 
  next_state = WAIT;
  case(state)
      WAIT: begin
          if(i) begin
              next_state = ST1;
          end else begin
              next_state = WAIT;
          end
        end
       ST1: begin
          if(i) begin
              next_state = ST11;
          end else begin
              next_state = WAIT;
          end
        end
       ST11: begin
          if(i) begin
              next_state = ST11;
          end else begin
              next_state = ST110;
          end
         end 
        ST110: begin
          if(i)begin
              next_state =  ST1101;
          end else begin 
              next_state = WAIT;           
          end
        end
        ST1101: begin
          if(i)begin
              next_state =  ST11;
          end else begin 
              next_state = WAIT;           
          end
        end
  endcase
end
 assign o = (state == ST1101)? 1 : 0;
endmodule