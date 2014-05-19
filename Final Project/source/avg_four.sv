// $Id: $
// File name:   avg_four.sv
// Created:     2/20/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: upper design wrapper file for averager

module avg_four
(
  input wire clk,
  input wire n_reset,
  input wire [15:0] sample_data,
  input wire data_ready,
  output wire one_k_samples,
  output wire modwait,
  output wire [15:0] avg_out,
  output wire err
);

reg [3:0] dest;
reg data_r;
reg [15:0] reg_out;
reg overflow;
reg cnt_up;
reg [3:0] src1;
reg [3:0] src2;
reg [1:0] op;

controller cn(
    .clk(clk) , 
    .dr(data_r), 
    .n_reset(n_reset), 
    .src1(src1), 
    .src2(src2), 
    .overflow(overflow), 
    .err(err) ,
    .cnt_up(cnt_up), 
    .op(op) ,
    .dest(dest), 
    .modwait(modwait)
);

sync sy(
    .clk(clk), 
    .n_rst(n_reset), 
    .async_in(data_ready) , 
    .sync_out(data_r)
);
counter co(
    .clk(clk),
    .n_reset(n_reset) ,
    .one_k_samples(one_k_samples),
    .cnt_up(cnt_up) 
);
datapath dp(
    .clk(clk), 
    .n_reset(n_reset), 
    .outreg_data(reg_out), 
    .op(op) ,
    .src1(src1) ,
    .src2(src2) ,
    .dest(dest) , 
    .ext_data(sample_data),
    .overflow(overflow)
);

assign avg_out = reg_out >> 2;

endmodule