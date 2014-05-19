// $Id: $
// File name:   pedestrian.sv
// Created:     3/19/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Pedestrian score
module score_pedestrian
(
  input wire n_rst,
  input wire [5:0] n_count,s_count,e_count,w_count, // it can only reach a value of 50 in each direction
  //input wire [15:0] p_in, // N S E W
  output wire [6:0] p_out, //score out of 100
  output wire p_dir //direction which has more pedestrians
  //pdir:
  // 1 - NS
  // 0 - EW
);

reg [6:0] score;
reg tmp_dir;
reg [6:0] ns,ew;

always @ (negedge n_rst) begin
  if(n_rst == 1'b0) begin
    score <= 0;
    tmp_dir <= 0;
  end else begin
    ns <= n_count + s_count; //combined score on north and south
    ew <= e_count + w_count; //combined score on east and west
    
    if(ns > ew)begin
      tmp_dir <= 1'b1;
      score <= ns; //score is the highest count between the two directions
    end else begin
      tmp_dir <= 1'b0;
      score <
      = ew; //same
    end

  end
  
end

assign p_out = score;
assign p_dir = tmp_dir;




endmodule
 
