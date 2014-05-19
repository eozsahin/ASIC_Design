// $Id: $
// File name:   tb_sda_sel.sv
// Created:     3/11/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench for SDA OUT select

`timescale 1ns / 10ps

module tb_sda_sel();
  
    parameter CLK_PERIOD				= 10;  
    localparam	CHECK_DELAY = 20; // Check 1ns after the rising edge to allow for propagation delay
    
    reg tb_tx_out;
    reg [1:0] tb_sda_mode;
    reg tb_sda_out;
    
    sda_sel DUT
    (
      .tx_out(tb_tx_out),
      .sda_mode(tb_sda_mode),
      .sda_out(tb_sda_out)
    );
    
    initial begin
      
    tb_tx_out = 1;
    tb_sda_mode = 2'b00;
    
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b01;
    tb_tx_out = 1;
      
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b01;
    tb_tx_out = 1;
    
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b11;
    tb_tx_out = 0;
    
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b10;
    tb_tx_out = 1;
    
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b11;
    tb_tx_out = 0;
    
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b00;
    tb_tx_out = 1;
    
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b10;
    tb_tx_out = 1;
    
    
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b00;
    tb_tx_out = 1;
    
    #(CLK_PERIOD*2)
    
    tb_sda_mode = 2'b11;
    tb_tx_out = 1;
    
    
    
    
    
    
  end
endmodule
  
  