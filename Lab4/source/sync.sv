// $Id: $
// File name:   sync.sv
// Created:     2/6/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Synchronizer

module sync
(
  input wire clk,
  input wire n_rst,
  input wire async_in,
  output wire sync_out
);

reg sig_in,sig_match;

always_ff @ (posedge clk, negedge n_rst)
begin : SYNC1 
  
  if(1'b0 == n_rst)
  begin 
      sig_in <= 0;
  end else
  begin 
      sig_in <= async_in; 
  end
end  

always_ff @ (posedge clk, negedge n_rst)
begin : SYNC2 
  
  if(1'b0 == n_rst)
  begin 
      sig_match <= 0;
  end else
  begin 
      sig_match <= sig_in; 
  end
end  

assign sync_out = sig_match;




endmodule
