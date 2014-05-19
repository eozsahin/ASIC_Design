// $Id: $
// File name:   decode.sv
// Created:     3/11/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Decode

module decode
(
  input wire clk,
  input wire n_rst,
  input wire scl,
  input wire sda_in,
  input wire [7:0] starting_byte,
  output wire rw_mode,
  output wire address_match,
  output wire stop_found,
  output wire start_found
);

//reg [7:0] temp_addr;
reg new_sda_in;
reg new_scl; 
reg old_sda_in;
reg old_scl;

always_ff @ (posedge clk,negedge n_rst) begin
  if(n_rst == 1'b0) begin
    new_sda_in <= 1'b1;
    old_sda_in <= 1'b1;
    new_scl <= 1'b1;
    old_scl <= 1'b1;
    //temp_addr <= 8'b11111111;
  end else begin
    // 2 flip flops for scl
    old_scl <= new_scl;
    new_scl <= scl;
    // 2 flip flops for sda_in
    old_sda_in <= new_sda_in;
    new_sda_in <= sda_in;
    //set addr
    //temp_addr <= starting_byte;
  end
end

//assign outputs
assign rw_mode = starting_byte[0];//temp_addr[0];
assign address_match = (starting_byte[7:1] == 7'b1111000);
assign stop_found = ((new_scl & old_scl ) & (new_sda_in  & (~old_sda_in)));
assign start_found = ((new_scl & old_scl ) & ((~new_sda_in)  & old_sda_in));

endmodule