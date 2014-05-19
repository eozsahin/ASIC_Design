// $Id: $
// File name:   scl_edge.sv
// Created:     3/11/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: SCL Edge Detector 

module scl_edge
(
  input wire clk,
  input wire n_rst,
  input wire scl,
  output wire rising_edge_found,
  output wire falling_edge_found    
);

reg new_val;
reg old_val;

always_ff @ (posedge clk,negedge n_rst) begin
  if(n_rst == 1'b0) begin
    new_val <= 1'b1;
  end else begin
    new_val <= scl;
  end
end

always_ff @ (posedge clk,negedge n_rst) begin
  if(n_rst == 1'b0) begin
    old_val <= 1'b1;
  end else begin
    old_val <= new_val;
  end
end

assign rising_edge_found = (new_val == 1'b1 && old_val == 1'b0)? 1:0;
assign falling_edge_found = (new_val == 1'b0 && old_val == 1'b1)? 1:0;


endmodule