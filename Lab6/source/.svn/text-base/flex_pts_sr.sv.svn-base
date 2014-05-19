// $Id: $
// File name:   flex_pts_sr.sv
// Created:     2/12/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: N-bit parallel to serial shift register design

module flex_pts_sr
#(
  parameter NUM_BITS = 4,
  parameter SHIFT_MSB = 1
)
(
  input wire clk,n_rst,shift_enable,load_enable,
  input reg [NUM_BITS-1:0] parallel_in,
  output wire serial_out
);

reg[NUM_BITS - 1:0] temp;

if(SHIFT_MSB)begin
	 assign serial_out = temp[NUM_BITS-1];
end else begin	
	 assign serial_out = temp[0];
end	

always @ (negedge n_rst,posedge clk) begin
  if (n_rst ==  1'b0)begin
        temp <= '1;
  end else if(load_enable)begin
		  temp <= parallel_in;
	end else if(shift_enable) begin 
		  if(SHIFT_MSB)begin
				  temp <= {temp[NUM_BITS-2:0],1'b0};
			end else begin	
				  temp <= {1'b0,temp[NUM_BITS-1:1]};
			end	
	end
end

endmodule
