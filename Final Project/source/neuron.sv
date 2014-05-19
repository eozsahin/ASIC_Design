// $Id: $
// File name:   neuron.sv
// Created:     4/24/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: each individual neuron

module neuron(
  input wire clk,
  input wire n_rst,
  input wire [6:0] input1, //unsigned 7bit input
  input wire [6:0] input2, //unsigned 7bit input
  input wire signed [4:0] weight1, //signed 4 bit input
  input wire signed [4:0] weight2, //signed 4 bit input
  output reg signed [13:0] addout //signed 13bit output
);

//Max value of input1 and inpu2:
//0 to 100 (0 to 127)

//Max values of weight1 and weight2:
//-15 to 15

//Max values of addout:
//-3810 to 3810 (-4096 to -4096)

reg signed [7:0] signed1;
reg signed [7:0] signed2;

reg signed [11:0] x1;
reg signed [11:0] x2;

reg signed [13:0] nextaddout;

always_comb begin
  signed1 = {0, input1};
  signed2 = {0, input2};
  x1 = signed1 * weight1;
  x2 = signed2 * weight2;
  nextaddout = x1 + x2;
end

always @ (posedge clk, negedge n_rst) begin
  if(n_rst == 0) begin
    addout <= 0;
  end else begin
    addout <= nextaddout;
  end
end

endmodule