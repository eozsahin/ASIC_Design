// $Id: $
// File name:   prioritize.sv
// Created:     3/19/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Prioritizing block

module prioritize
(
  input wire [6:0] ws, //weather score
  input wire [6:0] ps, //pedestrian score
 // input wire [6:0] es, //emergency score (note: not existing anymore!)
  input wire [6:0] cs, //car score
  output reg [8:0] t_score, //total score
  output reg [5:0] rank // 6 bit rank with decreasing order
  
  //00 - ws
  //01 - ps
  //10 - cs
);


always_comb begin
  t_score = ws + ps + cs; //calculate total score
  
  if((ws > ps) && (ws > cs)) begin // if ws is the greatest
      if(ps > cs) begin
        rank = 6'b000110; //order: ws, ps ,cs
      end else begin
        rank = 6'b001001; //order: ws, cs ,ps
      end
  end else if( (ps > ws ) && (ps > cs)) begin // if ps is the greatest
      if( ws > cs) begin
        rank = 6'b010010; //order: ps,ws,cs
      end else begin
        rank = 6'b011000; //order: ps,cs,ws
      end
  end else begin // if cs is the greatest 
      if(ps > ws) begin
        rank = 6'b100100; //order: cs,ps,ws
      end else begin
        rank = 6'b100001; //order: cs,ws,ps
      end
  end
 
   
end 

endmodule