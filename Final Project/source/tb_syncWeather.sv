// $Id: $
// File name:   tb_syncWeather.sv
// Created:     4/8/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for the weather input synchronizer

`timescale 1ns / 10ps

module tb_syncWeather();
  reg clk;
  reg n_rst;
  reg[3:0] w_async_in;
  reg[3:0] w_sync_out;
  
  syncWeather wSync(clk, n_rst, w_async_in, w_sync_out);
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    clk = 1;
    n_rst = 0;
    w_async_in = 0;
    
    #10
    n_rst = 1;
    w_async_in = 4'hA;
    
    #20
    w_async_in = 4'hF;
    #5
    n_rst = 0;
    
    #20
    n_rst = 1;
    
    #20
    w_async_in = 4'h02;
    
    #100
    $stop;
  end
endmodule