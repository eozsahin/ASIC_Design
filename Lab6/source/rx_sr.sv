// $Id: $
// File name:   rx_sr.sv
// Created:     3/21/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Shift register
module rx_sr
(
  input wire clk,
  input wire n_rst,
  input wire sda_in,
  input wire rising_edge_found,
  input wire rx_enable,
  output wire [7:0] rx_data
);

wire tmp_en;
assign tmp_en = rising_edge_found & rx_enable;

flex_stp_sr #(
  .NUM_BITS(8),
  .SHIFT_MSB(1)
)
rx_stp_sr (
  .clk(clk),
  .n_rst(n_rst),
  .shift_enable(tmp_en),
  .serial_in(sda_in),
  .parallel_out(rx_data)
);


endmodule