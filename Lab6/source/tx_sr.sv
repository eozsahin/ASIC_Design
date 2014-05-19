// $Id: $
// File name:   tx_sr.sv
// Created:     3/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Shift reg

module tx_sr(
  input wire clk,
  input wire n_rst,
  input wire falling_edge_found,
  input wire tx_enable,
  input wire [7:0] tx_data,
  input wire load_data,
  output wire tx_out
);
wire tmp_en;
assign tmp_en = falling_edge_found & tx_enable;

flex_pts_sr #(
.NUM_BITS (8),
.SHIFT_MSB (1)
)
tx_stp_sr(
  .clk(clk),
  .n_rst(n_rst),
  .shift_enable(tmp_en),
  .load_enable(load_data),
  .parallel_in(tx_data),
  .serial_out(tx_out)
);
endmodule