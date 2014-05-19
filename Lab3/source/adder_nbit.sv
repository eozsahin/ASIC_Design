// $Id: $
// File name:   adder_nbit.sv
// Created:     2/4/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: nbit adder 

module adder_nbit
#(
  parameter BIT_WIDTH = 4
)
( 
  input wire [(BIT_WIDTH-1):0] a,
  input wire [(BIT_WIDTH-1):0] b,
  input wire carry_in,
  output wire [(BIT_WIDTH-1):0] sum,
  output wire overflow
);

wire [(BIT_WIDTH):0] carrys;
genvar i;

assign carrys[0] = carry_in;
generate
    for(i=0; i<=BIT_WIDTH-1; i=i+1)
    begin

	always @ *
	begin
	
	//first assertion for out1
	assert((a[i] == 1'b1) || (a[i] == 1'b0))
		$info("a[%d] acceptable input",i);
	else
		$error("a[%d] not acceptable! ",i);

	//second assertion for sum
	assert((b[i] == 1'b1) || (b[i] == 1'b0))
		$info("b[%d] acceptable input",i);
	else
		$error("b[%d] not acceptable! ",i);
	//assertion for carry_out
	assert((carrys[i+1] == 1'b1) || (carrys[i+1] == 1'b0))
		$info("carry_out bit functions correctly");
	else
		$error("carry_out! ");
	//assertion for sum
	assert((sum[i] == 1'b1) || (sum[i] == 1'b0))
		$info("sum functions correctly");
	else
		$error("sum! ");

	end
        adder_1bit XI(.a(a[i]), .b(b[i]), .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i+1]));
    end
endgenerate

assign overflow = carrys[BIT_WIDTH];




endmodule
