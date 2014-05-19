// $Id: $
// File name:   10bit_counter.sv
// Created:     2/20/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: 10 bit counter wrapper file

module counter
(
  input wire n_reset,clk,
  input wire cnt_up,
  output wire one_k_samples
);



flex_counter #(10) ko( 
    .n_rst(n_reset), 
    .clear(1'b0), 
    .clk(clk),
    .count_enable(cnt_up), 
    .rollover_val(10'd1000), 
    .count_out() , 
    .rollover_flag(one_k_samples) 
);

endmodule