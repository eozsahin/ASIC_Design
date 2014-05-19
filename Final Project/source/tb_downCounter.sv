// $Id: $
// File name:   tb_downCounter.sv
// Created:     4/9/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for the down counter
`timescale 1ns/10ps

module tb_downCounter();
  reg clk;
  reg n_rst;
  reg start;
  reg delta;
  reg[7:0] startVal;
  reg signed [7:0] deltaVal;
  reg[7:0] outVal;
  reg pulse;
  
  downCounter downCount(clk, n_rst, start, delta, startVal, deltaVal, outVal, pulse);
 
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    clk = 1;
    n_rst = 0;
    reset = 0;
    start = 0;
    delta = 0;
    startVal = 8'd100;
    deltaVal = 8'd10;
    #8
    n_rst = 1;
    
    #20
    start = 1;
    #7;
    start = 0;
    #3

    #1000
    
    #50
    startVal = 8'd40;
    #27
    start = 1;
    #7
    start = 0;
    #303
    delta = 1;
    #7
    delta = 0;
    #3
    
    #1000
    
    #50
    startVal = 8'd80;
    deltaVal = -8'd10;
    #30
    start = 1;
    #7
    start = 0;
    #303
    delta = 1;
    #7
    delta = 0;
    #3
    
    #1000
    
    $stop;
  end
  
  
endmodule