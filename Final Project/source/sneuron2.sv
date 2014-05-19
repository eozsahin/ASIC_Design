// $Id: $
// File name:   sneuron2.sv
// Created:     5/1/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Second neuron with enable
module sneuron2(
  input wire clk,
  input wire n_rst,
  input wire enable,
  input wire signed [13:0] zInput,
  input wire signed [4:0] zWeight, 
  output reg signed [16:0] zOut
  );

  
  always @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      zOut <= 0;
    end else begin
      if(enable == 1'b1) begin
        zOut <= zInput * zWeight;
      end else begin
        zOut <= 0;
      end
    end
  end
  
endmodule