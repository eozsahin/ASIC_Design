// $Id: $
// File name:   syncWeather.sv
// Created:     4/8/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: the synchronizer for the weather input

module syncWeather(
  input wire clk,
  input wire n_rst, 
  input wire[3:0] w_async_in,
  output reg[3:0] w_sync_out
  );
  
  reg[3:0] Q;
  
  always @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      Q <= 0;
      w_sync_out <= 0;
    end
  else begin
    Q <= w_async_in;
    w_sync_out <= Q;
  end
end

endmodule
