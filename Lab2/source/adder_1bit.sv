// $Id: $
// File name:   adder_1bit.sv
// Created:     2/3/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: emre


module adder_1bit
(
  input wire a,
  input wire b,
  input wire carry_in,
  output wire sum,
  output wire carry_out
);

wire out1;

xor pre(out1,a,b);
xor s(sum,carry_in,out1);
 
assign carry_out = ((~carry_in)&b&a)|(carry_in&(b|a));

endmodule