// $Id: $
// File name:   tb_sneuron.sv
// Created:     4/25/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for single 

`timescale 1ns/10ps

module tb_sneuron();
  reg signed [13:0] zInput;
  reg signed [4:0] zWeight;
  reg signed [16:0] zOut;
  
  sneuron single(zInput, zWeight, zOut);
  
  initial begin
    #10
    zInput = 14'd3000;
    zWeight = 5'd0;
    
    #50
    zInput = 14'd3000;
    zWeight = 5'd1;
    
    #50
    zInput = -14'd3000;
    zWeight = 5'd1;
    
    #50
    zInput = -14'd3000;
    zWeight = -5'd1;
    
    #50
    zInput = 14'd1;
    zWeight = 5'd15;
    
    #50
    zInput = 14'd3000;
    zWeight = 5'd15;
    
    #50
    zInput = -14'd3000;
    zWeight = 5'd15;
    
    #50
    zInput = -14'd1;
    zWeight = -5'd15;
    
    #100
    $stop;
  end
  
endmodule
