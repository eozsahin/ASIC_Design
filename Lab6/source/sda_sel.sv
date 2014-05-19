// $Id: $
// File name:   sda_sel.sv
// Created:     3/11/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: SDA_Out Select Block Description

module sda_sel
(
  input wire tx_out,
  input wire [1:0] sda_mode,
  output reg sda_out
);

always @ * begin
  if(sda_mode == 2'b00)begin
     sda_out <= 1'b1; //IDLE
  end else if(sda_mode == 2'b01) begin
     sda_out <= 1'b0; //ACK
  end else if(sda_mode == 2'b10) begin
     sda_out <= 1'b1; //NACK
  end else if(sda_mode == 2'b11) begin
     sda_out <= tx_out; //tx_out
  end  
    
end


endmodule