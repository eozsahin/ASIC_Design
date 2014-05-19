// $Id: $
// File name:   tb_carcounter.sv
// Created:     5/1/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for car counter
`timescale 1ns/10ps

module tb_car_counter();
  reg clk, n_rst, count_enable, r_flag;
  reg[5:0] count_out;
  
  car_counter CC(
    n_rst,
    clk,
    count_enable,
    count_out,
    r_flag
    );
    
    always begin 
      #5 clk = ~clk;
    end
    
    initial begin
      clk = 1;
      n_rst = 0;
      count_enable = 0;
      
      #10
      n_rst =1;
      
      #5
      count_enable = 1;
      
      #1000
      
      $stop;
    end
  endmodule