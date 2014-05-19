// $Id: $
// File name:   tb__sram_module.sv
// Created:     4/8/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for sram
// 

`timescale 1ns/10ps

module tb_sram_module();
  reg [7:0] inData;
  reg outputEnable;
  reg writeEnable;
  reg reset;
  reg [7:0] outData; 
  
  sram_module ram_mod(inData, outputEnable, writeEnable, reset, outData);
  
  initial begin
    #5;
    inData = 0;
    outputEnable = 0;
    writeEnable = 0;
    reset = 0;
    #50
    inData = 8'h2A;
    #5
    writeEnable = 1;
    #5 
    writeEnable = 0;
    #10
    outputEnable = 1;
    #20
    outputEnable = 0;
    
    #100
    $stop;
    
  end
  
endmodule