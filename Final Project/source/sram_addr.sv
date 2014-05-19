// $Id: $
// File name:   sram_addr.sv
// Created:     4/8/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: sram with addresses

module sram_addr(
  input wire [7:0] inData,
  input wire [9:0] addr,
  input wire outputEnable, 
  input wire writeEnable, 
  input wire reset, 
  output wire [7:0] outData
  );
  
  reg [7:0] mem[0:1023];
  integer i;
  
  assign outData = (outputEnable == 1) ? mem[addr] : 8'bz;
  
  always_comb begin
    if(reset == 1) begin
      for(i=0; i < 1024; i = i + 1) begin
        mem[i] = 0;
      end
    end else if(writeEnable == 1) begin
      mem[addr] = inData;
    end
  end
  
  
endmodule
