// $Id: $
// File name:   ped_counter.sv
// Created:     3/28/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: pedestrian counter

module ped_counter
(
  input wire n_rst,clk,
  input wire count_enable,
  input wire clear,
  output wire [5:0] count_out,
  output wire r_flag
);

flex_counter
#(
  .NUM_CNT_BITS(6)
) p_count
(
  .clk(clk),
  .n_rst(n_rst),
  .clear(clear),
  .count_enable(count_enable),
  .rollover_val(6'd50),
  .count_out(count_out),
  .rollover_flag(r_flag)
);

endmodule