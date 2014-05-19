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

//1 bit adder equations
xor pre(out1,a,b);
xor s(sum,carry_in,out1);
assign carry_out = ((~carry_in)&b&a)|(carry_in&(b|a));

always @ *
begin
	
	//first assertion for out1
	assert((out1 == 1'b1) || (out1 == 1'b0))
		$info("first xor gate is functions correctly");
	else
		$error("first xor gate! ");

	//second assertion for sum
	assert((sum == 1'b1) || (sum == 1'b0))
		$info("second xor gate is functions correctly");
	else
		$error("second xor gate! ");
	//assertion for carry_out
	assert((carry_out == 1'b1) || (carry_out == 1'b0))
		$info("carry_out bit functions correctly");
	else
		$error("carry_out! ");

end

endmodule
