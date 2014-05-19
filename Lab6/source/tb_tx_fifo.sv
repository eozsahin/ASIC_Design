// $Id: $
// File name:   tb_tx_fifo.sv
// Created:     3/12/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench for tx_fifo

`timescale 1ns / 10ps

module tb_tx_fifo();
    parameter CLK_PERIOD				= 10;  
    localparam	CHECK_DELAY = 20; // Check 1ns after the rising edge to allow for propagation delay
    
    //sequences to be used in test
    int i;

    reg tb_clk;
    reg tb_n_rst;
    reg tb_read_enable;
    reg tb_write_enable;
    reg [7:0] tb_write_data;
    reg [7:0] tb_read_data;
    reg tb_fifo_empty;
    reg tb_fifo_full;
    
    
    tx_fifo DUT
    (
      .clk(tb_clk),
      .n_rst(tb_n_rst),
      .read_enable(tb_read_enable),
      .write_enable(tb_write_enable),
      .write_data(tb_write_data),
      .read_data(tb_read_data),
      .fifo_empty(tb_fifo_empty),
      .fifo_full(tb_fifo_full)
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
	  tb_read_enable = 1'b1;
	  tb_write_enable = 1'b1;
	  tb_write_data = 8'b11111111;
	  
	  // Power-on Reset of the DUT
	  #(0.1);
		tb_n_rst	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		#(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
	  #(CLK_PERIOD);
	  tb_n_rst = 1'b0;
	  
	  //test 1 reset
	  @(negedge tb_clk);
      tb_n_rst = 0;
      tb_read_enable = 1;
      tb_write_enable = 1;
      tb_write_data = 8'b11111111;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    
    // test 2 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 1;
      tb_write_enable = 1;
      tb_write_data = 8'b11111111;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    // test 3 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 0;
      tb_write_enable = 1;
      tb_write_data = 8'b11111111;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    // test 4 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 1;
      tb_write_enable = 0;
      tb_write_data = 8'b11111111;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
	  
	  
	  // test 5 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 0;
      tb_write_enable = 0;
      tb_write_data = 8'b11111111;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
	  
	  
	  // test 6 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 1;
      tb_write_enable = 0;
      tb_write_data = 8'b00000000;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    
    // test 7 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 0;
      tb_write_enable = 1;
      tb_write_data = 8'b00000000;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    
    // test 8 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 1;
      tb_write_enable = 1;
      tb_write_data = 8'b00000000;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    // test 9 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 0;
      tb_write_enable = 0;
      tb_write_data = 8'b00000000;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    
    // test 10 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 0;
      tb_write_enable = 1;
      tb_write_data = 8'b11101101;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    // test 10 no reset
    @(negedge tb_clk);
      tb_n_rst = 1;
      tb_read_enable = 1;
      tb_write_enable = 1;
      tb_write_data = 8'b11111111;
      
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
     @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
     @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
     @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
     @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    ////read
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    
    
     @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
     @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
     @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
     @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 1;
     tb_read_enable = 0;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    ////read
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    @(negedge tb_clk);
     tb_write_enable = 0;
     tb_read_enable = 1;
     @(posedge tb_clk);
    #(CHECK_DELAY);
    
    
    
   
	end
endmodule