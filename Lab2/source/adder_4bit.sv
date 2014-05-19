// $Id: $
// File name:   adder_4bit.sv
// Created:     2/3/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: 4 bit adder


module adder_4bit
(
  input wire a[3:0],
  input wire b[3:0],
  input wire carry_in,
  output wire sum[3:0],
  output wire overflow
  
);

wire [4:0] carrys;
genvar i;

assign carrys[0] = carry_in;
generate
    for(i=0; i<=3; i=i+1)
    begin
        adder_1bit XI(.a(a[i]), .b(b[i]), .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i+1]));
    end
endgenerate

assign overflow = carrys[4];

endmodule  