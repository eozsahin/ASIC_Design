// $Id: $
// File name:   tb_ped_counter.sv
// Created:     5/1/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for the ped counter

module tb_ped_counter();
  reg n_rst, clk, count_enable, r_flag;
  reg[5:0] count_out;
  
  ped_counter PC(
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
      n_rst = 0 ;
      count_enable = 0;
      
      #10
      n_rst =1;
      
      #5
      count_enable = 1;
      
      #1000
      
      $stop;
    end
  endmodule