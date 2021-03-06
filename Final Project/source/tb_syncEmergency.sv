// $Id: $
// File name:   tb_syncEmergency.sv
// Created:     4/8/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for emergency input synchronizer
`timescale 1ns / 10ps

module tb_syncEmergency();
  reg clk;
  reg n_rst;
  reg e_async_in;
  reg e_sync_out;
  
  syncEmergency wSync(clk, n_rst, e_async_in, e_sync_out);
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    clk = 1;
    n_rst = 0;
    e_async_in = 0;
    
    #10
    n_rst = 1;
    e_async_in = 0;
    
    #20
    e_async_in = 1;
    #5
    n_rst = 0;
    
    #20
    n_rst = 1;
    
    #20
    e_async_in = 1;
    
    #100
    $stop;
  end
endmodule