// $Id: $
// File name:   addrControl.sv
// Created:     5/1/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: address controller

module addrControl(
  input wire clk,
  input wire n_rst,
  output reg goRead,
  output reg goWrite, 
  output reg [11:0]addr
  );          
  
  reg[11:0] writePtr;
  
  always @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      addr <= 0;
    end else begin
      addr <= (addr == 1023) ? 0 : ( (addr == writePtr) ? 0 : addr + 1);
    end
  end
  
  always @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      writePtr = 500;
    end else begin
      writePtr = (writePtr == 1023) ? 0 :((addr == writePtr) ? writePtr + 1 : writePtr);
    end
  end
  
  always_comb begin
    if(addr == writePtr) begin
      goRead = 0;
      goWrite = 1;
    end else begin
      goRead = 1;
      goWrite = 0;
    end
  end
  
  
endmodule
