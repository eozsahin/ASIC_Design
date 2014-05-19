// $Id: $
// File name:   averager.sv
// Created:     4/4/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: averager block
// takes a score out of 400 from the prioritizing block and converts it to a 
// score out of 100


module averager(
  input wire [8:0] prior_in, 
  output wire [6:0] decision_out
  );
  
  
  assign decision_out = prior_in / 4;
  
endmodule