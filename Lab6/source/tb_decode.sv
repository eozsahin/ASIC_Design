// $Id: $
// File name:   tb_decode.sv
// Created:     3/11/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: test bench for decode

`timescale 1ns / 10ps

module tb_decode();
    parameter CLK_PERIOD				= 10;  
    localparam	CHECK_DELAY = 20; // Check 1ns after the rising edge to allow for propagation delay
    
    //sequences to be used in test
    int i;
    reg [15:0] seq_scl;
    reg [15:0] seq_sda;

    reg tb_clk;
    reg tb_n_rst;
    reg tb_scl;
    reg tb_sda_in;
    reg [7:0] tb_starting_byte;
    reg tb_rw_mode;
    reg tb_address_match;
    reg tb_stop_found;
    reg tb_start_found;
    
    decode DUT
    (
      .clk(tb_clk),
      .n_rst(tb_n_rst),
      .scl(tb_scl),
      .sda_in(tb_sda_in),
      .starting_byte(tb_starting_byte),
      .rw_mode(tb_rw_mode),
      .address_match(tb_address_match),
      .stop_found(tb_stop_found),
      .start_found(tb_start_found)
    );
  
  always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	// Default Configuration Test bench main process
	initial
	begin
	  
	  tb_n_rst = 1'b1;
	  tb_scl = 1'b1;
	  tb_starting_byte = 8'b11111111;
	  tb_sda_in = 1'b1;
	  
	  // Power-on Reset of the DUT
	  #(0.1);
		tb_n_rst	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		#(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
	  #(CLK_PERIOD);
	  tb_n_rst = 1'b0;
	  
	  seq_scl = 16'b1111011111110011;
	  seq_sda = 16'b0010010110111111;
	  
	  for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_n_rst = 1;
      tb_sda_in = seq_sda[i];
      tb_scl = seq_scl[i];
      
      //work with two different addressess for a byte
      if (i < 8) begin
        tb_starting_byte = 8'b10110101;
      end else begin
        tb_starting_byte = 8'b11110000;//matched address for slave
      end
      
      @(posedge tb_clk);
      #(CHECK_DELAY);
      
    end
    
    seq_scl = 16'b1111111011111011;
	  seq_sda = 16'b0110101110101110;
	  
	  for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_n_rst = 1;
      tb_sda_in = seq_sda[i];
      tb_scl = seq_scl[i];
      
      //work with two different addressess for a byte
      if (i < 8) begin
        tb_starting_byte = 8'b01011101;
      end else begin
        tb_starting_byte = 8'b11110000;//matched address for slave
      end
      
      @(posedge tb_clk);
      #(CHECK_DELAY);
      
    end
	  
	  
	  
	end
endmodule
	  
	  