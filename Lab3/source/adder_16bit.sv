// $Id: $
// File name:   adder_16bit.sv
// Created:     2/7/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: 16 bit adder 

module adder_16bit
(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire carry_in,
	output wire [15:0] sum,
	output wire overflow
);

genvar i;
generate
    for(i=0; i<=15; i=i+1)
    begin

	always @ *
	begin
	
	//first assertion for out1
	assert((a[i] == 1'b1) || (a[i] == 1'b0))
		$info("inside 16 bit -> a[%d] acceptable input",i);
	else
		$error("inside 16 bit -> a[%d] not acceptable! ",i);

	//second assertion for sum
	assert((b[i] == 1'b1) || (b[i] == 1'b0))
		$info("inside 16 bit -> b[%d] acceptable input",i);
	else
		$error("inside 16 bit -> b[%d] not acceptable! ",i);
	
	//assertion for sum
	assert((sum[i] == 1'b1) || (sum[i] == 1'b0))
		$info("inside 16 bit -> sum functions correctly");
	else
		$error("inside 16 bit -> sum! ");

	end
    end
endgenerate

always @ *
begin
	//assertion for carry_out
	assert((carry_in == 1'b1) || (carry_in == 1'b0))
		$info("inside 16 bit ->carry_out bit functions correctly");
	else
		$error("carry_out! ");
	//assertion for overflow
	assert((overflow == 1'b1) || (overflow == 1'b0))
		$info("inside 16 bit ->overflow bit functions correctly");
	else
		$error("overflow! ");
end



adder_nbit #(16) tk(.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));



endmodule
