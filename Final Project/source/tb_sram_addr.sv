// $Id: $
// File name:   tb_sram_addr.sv
// Created:     4/8/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for address sram

`timescale 1ns/10ps

module tb_sram_addr();
  reg[7:0] inData;
  reg[2:0] addr;
  reg outputEnable;
  reg writeEnable;
  reg reset;
  reg[7:0] outData;
  reg [7:0] addr0;
  
  sram_addr ram_mod(inData, addr, outputEnable, writeEnable, reset, outData, addr0);
  
  //this code stores values in memory blocks then retreives them
  //Addr - val
  //0     0xAF
  //1     0x12
  //2     0x09
  //3     0x69
  //4     0xFF
  //5     0x00
  //6     0x2A
  //7     0xA7
  
  initial begin
    #5
    inData = 0;
    addr = 0;
    outputEnable = 0;
    writeEnable = 0;
    reset = 0;
    //write AF to addr 0
    #10
    inData = 8'hAF;
    addr = 8'h0;
    #5
    writeEnable = 1;
    #5
    writeEnable = 0;
    //write 12 to addr 1
    #10
    inData = 8'h12;
    addr = 8'h1;
    #5 
    writeEnable = 1;
    #5
    writeEnable = 0;
    //write 09 to addr 2
    #10
    inData = 8'h09;
    addr = 8'h2;
    #5 
    writeEnable = 1;
    #5
    writeEnable = 0;
    //write 69 to addr 3
    #10
    inData = 8'h69;
    addr = 8'h3;
    #5 
    writeEnable = 1;
    #5
    writeEnable = 0;
    //write FF to addr 4
    #10
    inData = 8'hFF;
    addr = 8'h4;
    #5 
    writeEnable = 1;
    #5
    writeEnable = 0;
    //write 00 to addr 5
    #10
    inData = 8'h00;
    addr = 8'h5;
    #5 
    writeEnable = 1;
    #5
    writeEnable = 0;
    //write 2A to addr 6
    #10
    inData = 8'h2A;
    addr = 8'h6;
    #5 
    writeEnable = 1;
    #5
    writeEnable = 0;
    //write A7 to addr 7
    #10
    inData = 8'hA7;
    addr = 8'h7;
    #5 
    writeEnable = 1;
    #5
    writeEnable = 0;
    #100
    
    //read values from addresses
    #10
    addr = 8'h0;
    #5
    outputEnable = 1;
    #1
    if(outData == 8'hAf)
      $info("Addr 0 : AF");
    else
      $error("Addr 0: FAILED");
    #5
    outputEnable = 0;
    
    #10
    addr = 8'h1;
    #5
    outputEnable = 1;
    #1
    if(outData == 8'h12)
      $info("Addr 1 : 12");
    else
      $error("Addr 1: FAILED");
    #5
    outputEnable = 0;
    
    #10
    addr = 8'h2;
    #5
    outputEnable = 1;
    #1
    if(outData == 8'h09)
      $info("Addr 2 : 09");
    else
      $error("Addr 2: FAILED");
    #5
    outputEnable = 0;
    
    #10
    addr = 8'h3;
    #5
    outputEnable = 1;
    #1
    if(outData == 8'h69)
      $info("Addr 3 : 69");
    else
      $error("Addr 3: FAILED");
    #5
    outputEnable = 0;
    
    #10
    addr = 8'h4;
    #5
    outputEnable = 1;
    #1
    if(outData == 8'hFF)
      $info("Addr 4 : FF");
    else
      $error("Addr 4: FAILED");
    #5
    outputEnable = 0;
    
    #10
    addr = 8'h5;
    #5
    outputEnable = 1;
    #1
    if(outData == 8'h00)
      $info("Addr 5 : 00");
    else
      $error("Addr 5: FAILED");
    #5
    outputEnable = 0;
    
    #10
    addr = 8'h6;
    #5
    outputEnable = 1;
    #1
    if(outData == 8'h2A)
      $info("Addr 6 : 2A");
    else
      $error("Addr 6: FAILED");
    #5
    outputEnable = 0;
    
    #10
    addr = 8'h7;
    #5
    outputEnable = 1;
    #1
    if(outData == 8'hA7)
      $info("Addr 7 : A7");
    else
      $error("Addr 7: FAILED");
    #5
    outputEnable = 0;
    
    
    #50
    $stop;
    
  end
  
endmodule