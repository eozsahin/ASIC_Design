// $Id: $
// File name:   emergency.sv
// Created:     3/19/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Emergency score

module emergency
(
  input wire [2:0] e_in,
  input wire n_rst,
  output wire [6:0] e_out,
  output wire [2:0] dir
  //000 - IDLE
  //001 - N
  //010 - W
  //011 - S
  //100 - E
  
);

reg [6:0] score;
reg [2:0] tmp_dir;

always @ (negedge n_rst) begin
  if(n_rst == 1'b0) begin
    score <= '0;
    tmp_dir <= '0;
  end else begin
    if(e_in == 3'b000)begin
      score <= 0;
      tmp_dir <= 0;
    end else begin
        if(e_in < 3'b101)begin
          tmp_dir <= e_in;
        end
        
        if(e_in == 3'b101) begin
          score = 80;
        end else if(e_in == 3'b110) begin
          score = 90;
        end else begin
          score = 100;
        end
    end
  end
  
end

assign e_out = score;
assign dir = tmp_dir;



endmodule