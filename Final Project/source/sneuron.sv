// $Id: $
// File name:   sneuron.sv
// Created:     4/25/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: single neuron with 14bit input

module sneuron(
  input wire clk,
  input wire n_rst,
  input wire signed [13:0] zInput,
  input wire signed [4:0] zWeight, 
  output reg signed [16:0] zOut
  );
  
  wire signed [16:0] nextzOut;
  
  assign nextzOut = zInput * zWeight;
  
  always @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      zOut <= 0;
    end else begin
      zOut <= nextzOut;
    end
  end
  
endmodule