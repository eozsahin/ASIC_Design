// $Id: $
// File name:   i2c_slave.sv
// Created:     3/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: i2c 
module i2c_slave(
  input wire clk,
  input wire n_rst,
  input wire scl,
  input wire sda_in,
  input wire write_enable,
  input wire [7:0] write_data,
  output wire sda_out,
  output wire fifo_empty,
  output wire fifo_full
  );
  
  
  reg [7:0] rx_data,read_data;
  reg [1:0] sda_mode;
  reg rising_edge_found,falling_edge_found,rx_enable;
  reg load_data,byte_received,ack_prep,check_ack,ack_done;
  reg rw_mode,address_match,stop_found;
  reg start_found,tx_out,tx_enable,read_enable;
  
  
   
  timer tim (
  .clk(clk),
  .n_rst(n_rst),
  .rising_edge_found(rising_edge_found),
  .falling_edge_found(falling_edge_found),
  .stop_found(stop_found),
  .start_found(start_found),
  .check_ack(check_ack),
  .byte_received(byte_received),
  .ack_prep(ack_prep),
  .ack_done(ack_done)
  );
  
  controller cont (
  .clk(clk),
  .n_rst(n_rst),
  .stop_found(stop_found),
  .start_found(start_found),
  .byte_received(byte_received),
  .ack_prep(ack_prep),
  .check_ack(check_ack),
  .ack_done(ack_done),
  .rw_mode(rw_mode),
  .address_match(address_match),
  .sda_in(sda_in),
  .rx_enable(rx_enable),
  .tx_enable(tx_enable),
  .read_enable(read_enable),
  .sda_mode(sda_mode),
  .load_data(load_data)
  );
  
  tx_fifo fifo (
  .clk(clk),
  .n_rst(n_rst),
  .read_enable(read_enable),
  .read_data(read_data),
  .fifo_empty(fifo_empty),
  .fifo_full(fifo_full),
  .write_enable(write_enable),
  .write_data(write_data)
  );
  
  
  decode dec (
  .clk(clk),
  .n_rst(n_rst),
  .sda_in(sda_in),
  .scl(scl),
  .starting_byte(rx_data),
  .rw_mode(rw_mode),
  .address_match(address_match),
  .stop_found(stop_found),
  .start_found(start_found)
  );
  

  sda_sel sdasel(
  .tx_out(tx_out),
  .sda_mode(sda_mode),
  .sda_out(sda_out)
  );
  
  tx_sr tx_sr (
  .clk(clk),
  .n_rst(n_rst),
  .falling_edge_found(falling_edge_found),
  .tx_enable(tx_enable),
  .tx_data(read_data),
  .load_data(load_data),
  .tx_out(tx_out)
  );
 
   rx_sr sr_xr (
  .clk(clk),
  .n_rst(n_rst),
  .sda_in(sda_in),
  .rising_edge_found(rising_edge_found),
  .rx_enable(rx_enable),
  .rx_data(rx_data)
  );
   
  scl_edge scl_edge_det (
  .clk(clk),
  .n_rst(n_rst),
  .scl(scl),
  .rising_edge_found(rising_edge_found),
  .falling_edge_found(falling_edge_found)
  );
  
  
  
  
endmodule