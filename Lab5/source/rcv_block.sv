// $Id: $
// File name:   rcv_block.sv
// Created:     2/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Reciever Block

module rcv_block
(
  input wire clk,
  input wire n_rst,
  input wire serial_in,
  input wire data_read,
  output wire [7:0] rx_data,
  output wire data_ready,
  output wire overrun_error,
  output wire framing_error
); 

reg stop_bit;

reg sbc_clear;
reg sbc_enable;
reg enable_timer;
reg packet_done;
reg start_bit_detected;
reg load_buffer;
reg shift_strobe;
reg [7:0] packet_data;




rcu rc
(
  .clk(clk),
  .n_rst(n_rst),
  .start_bit_detected(start_bit_detected),
  .packet_done(packet_done),
  .framing_error(framing_error),
  .sbc_clear(sbc_clear),
  .sbc_enable(sbc_enable),
  .load_buffer(load_buffer),
  .enable_timer(enable_timer)
);

timer tm
(
  .clk(clk),
  .n_rst(n_rst),
  .enable_timer(enable_timer),
  .shift_strobe(shift_strobe),
  .packet_done(packet_done)
);

sr_9bit sb
( 
  .clk(clk),
  .n_rst(n_rst),
  .shift_strobe(shift_strobe),
  .serial_in(serial_in),
  .packet_data(packet_data),
  .stop_bit(stop_bit)
);

start_bit_det sbd
(
  .clk(clk),
  .n_rst(n_rst),
  .serial_in(serial_in),
  .start_bit_detected(start_bit_detected)
);

stop_bit_chk sbc
(
  .clk(clk),
  .n_rst(n_rst),
  .sbc_clear(sbc_clear),
  .sbc_enable(sbc_enable),
  .stop_bit(stop_bit),
  .framing_error(framing_error)
);

rx_data_buff rdb
(
  .clk(clk),
  .n_rst(n_rst),
  .load_buffer(load_buffer),
  .packet_data(packet_data),
  .data_read(data_read),
  .rx_data(rx_data),
  .data_ready(data_ready),
  .overrun_error(overrun_error)
);


endmodule