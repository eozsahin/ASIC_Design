// $Id: $
// File name:   tb_Logic.sv
// Created:     4/13/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for the  logic
`timescale 1ns/10ps

module tb_outputLogic();
  reg clk, n_rst, dir, emergency;
  reg [7:0] countVal;
  reg[1:0] trafficN; // 00 RED
  reg[1:0] trafficS; // 01 YELLOW
  reg[1:0] trafficE; // 10 GREEN
  reg[1:0] trafficW;
  reg[1:0] pedN;
  reg[1:0] pedS;
  reg[1:0] pedE;
  reg[1:0] pedW;
  
  outputLogic logicTest(clk, n_rst, emergency, dir, countVal, trafficN, trafficS, trafficE, trafficW, pedN, pedS, pedE, pedW);
  
  always begin 
    #5
    clk = ~clk;
  end
  
  
  initial begin
    clk = 1;
    n_rst = 0;
    emergency = 0;
    countVal = 0;
    #97
    n_rst = 1;
    emergency = 1;
    countVal = 60;
    #40
    emergency = 0;
    countVal = 56;
    #10
    countVal = 40;
    #10
    countVal = 25;
    #10
    countVal = 19;
    #10
    countVal = 10;
    #10
    countVal = 4;
    #10
    countVal = 0;
    
    
    #500
    $stop;
  end
  
  
endmodule