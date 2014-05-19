// $Id: $
// File name:   sram_module.sv
// Created:     4/8/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: sram_module

module sram_module(
  input wire [7:0] inData,
  input wire outputEnable, //enable ouput on outData
  input wire writeEnable, //enable writing of data
  input wire reset, //resets all internal memory
  output wire [7:0] outData
  );

reg [7:0] mem;

assign outData = (outputEnable == 1) ? mem : 8'bz;

always_comb begin
  if(reset == 1) begin
    mem = 0;
  end else begin
    if(writeEnable == 1 && outputEnable == 1) begin
      mem = 8'bz;
    end else if(writeEnable == 1) begin
      mem = inData;
    end
  end
end

endmodule