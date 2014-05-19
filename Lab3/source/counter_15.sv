// $Id: $
// File name:   counter_15.sv
// Created:     2/13/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Counter up to 15

module counter_15
(
  input wire n_rst,clk,count_enable,clear,
  input wire [3:0] rollover_val,
  output wire [3:0] count_out,
  output wire rollover_flag
);

flex_counter
#(
 .NUM_CNT_BITS(4)
)
CORE(
  .clk(clk),
  .n_rst(n_rst),
  .count_enable(count_enable),
  .rollover_val(rollover_val),
  .count_out(count_out),
  .rollover_flag(rollover_flag),
  .clear(clear)
);

endmodule