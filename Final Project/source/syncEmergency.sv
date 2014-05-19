// $Id: $
// File name:   syncEmergency.sv
// Created:     4/8/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: the synchronizer for the emergency block

module syncEmergency(
  input wire clk,
  input wire n_rst, 
  input wire e_async_in,
  output reg e_sync_out
);
  
   reg 	     Q;
   
  
  always @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      Q <= 0;
      e_sync_out <= 0;
    end
    else begin
      Q <= e_async_in;
      e_sync_out <= Q;
    end
  end
endmodule