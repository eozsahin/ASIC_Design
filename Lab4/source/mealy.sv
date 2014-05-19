// $Id: $
// File name:   mealy.sv
// Created:     2/15/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Mealy Machine 1101 Detector 

module mealy
(
	input wire clk,n_rst,i,
	output reg o	
);

typedef enum bit[1:0]{ST1,ST11,ST110,ST1101} state_type;
state_type state,next_state;

always @(posedge clk, negedge n_rst) begin 
  if(n_rst == 0)begin
      state <= ST1;
  end else begin
      state <= next_state;
  end
end

always @(state,i) begin  
  next_state = ST1;
  o <= 1'b0;

  case(state)
       ST1: begin
          if(i) begin
            o <= 1'b0;
              next_state = ST11;
          end else begin
            o <= 1'b0;
              next_state = ST1;
          end
        end
       ST11: begin
          if(i) begin
            o <= 1'b0;
              next_state = ST110;             
          end else begin
            o <= 1'b0;
              next_state = ST1;
          end
         end 
        ST110: begin
          if(i)begin
            o <= 1'b0;
              next_state =  ST1;
          end else begin 
            o <= 1'b0;
              next_state = ST1101;        
          end
        end
        ST1101: begin
          if(i)begin
            o <= 1'b1;
              next_state =  ST11;
          end else begin 
            o <= 1'b0;
              next_state = ST1;          
          end
        end

  endcase
   
  
end
endmodule