// $Id: $
// File name:   test1.sv
// Created:     4/29/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test1


module test1(
  input wire signed [4:0] i1,
  input wire signed [4:0] i2,
  input wire signed [7:0] i3,
  input wire signed [7:0] i4,
  output reg signed [11:0] x1,
  output reg signed [11:0] x2,
  output reg signed [12:0] out
  );
  
  
  
  always_comb begin
    x1 = i1 * i3;
    x2 = i2 * i4;
    out = x1 + x2;
  end
  
endmodule