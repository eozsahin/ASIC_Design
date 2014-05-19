// $Id: $
// File name:   sr_9bit.sv
// Created:     2/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: 9 bit shift register 

module sr_9bit
(
  input wire clk,n_rst,serial_in,shift_strobe,
  output wire [7:0] packet_data,
  output wire stop_bit 
  
);

reg [8:0] temp;

flex_stp_sr
#(
  .NUM_BITS(9),
  .SHIFT_MSB(0)
)
tk
(
  .clk(clk),
  .n_rst(n_rst),
  .shift_enable(shift_strobe),//(shift_enable)
  .serial_in(serial_in),
  .parallel_out(temp)//stop_bit,parallel_out
);

assign packet_data = temp[7:0];
assign stop_bit = temp[8];

endmodule
