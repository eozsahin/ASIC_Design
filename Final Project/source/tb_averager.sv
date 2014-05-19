// $Id: $
// File name:   tb_averager.sv
// Created:     4/4/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for averager block

module tb_averager();
  
  reg [8:0] prior_in;
  reg [6:0] decision_out;
  
  averager tb_avg(prior_in, decision_out);
  
  initial begin
    prior_in = 9'd100;
    #50
    prior_in = 9'd50;
    #50
    prior_in = 9'd200;
    #100
    $stop;
  end
  
endmodule