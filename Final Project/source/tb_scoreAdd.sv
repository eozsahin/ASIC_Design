// $Id: $
// File name:   tb_addScore.sv
// Created:     5/1/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for score adder
`timescale 1ns / 10ps

module tb_scoreAdd();
  reg [5:0] score1;
  reg [5:0] score2;
  reg [6:0] outScore;
  
  scoreAdd adder(
    score1,
    score2,
    outScore
    );
    
    initial begin
      score1 = 0;
      score2 = 0;
      
      #5
      score1 = 25;
      score2 = 25;
      
      #15
      score1 = 40;
      score2 = 45;
      
      #15
      
      score1 = 50;
      score2 = 50;
      
      
      #50
      $stop;
    end
    
  endmodule