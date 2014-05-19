// $Id: $
// File name:   tb_scl_edge.sv
// Created:     3/11/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: test bench for scl edge detection

`timescale 1ns / 10ps

module tb_scl_edge();
  
    parameter CLK_PERIOD = 10; //100 MHz clock  
    localparam	CHECK_DELAY = 20; // Check 1ns after the rising edge to allow for propagation delay
    
    int i;
   	reg [15:0] seq;
    reg tb_clk;
    reg tb_n_rst;
    reg tb_scl;
    reg tb_rising_edge_found;
    reg tb_falling_edge_found;
    reg tb_test_num;
    
    scl_edge DUT
    (
      .clk(tb_clk),
      .n_rst(tb_n_rst),
      .scl(tb_scl),
      .rising_edge_found(tb_rising_edge_found),
      .falling_edge_found(tb_falling_edge_found)
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
	  tb_test_num = 0; 
	  
	  // Power-on Reset of the DUT
	  #(0.1);
		tb_n_rst	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		#(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
		
			// Wait for a while to see normal operation
		#(CLK_PERIOD);
	
	//whole test for no reset and scl input sequence	
	seq = 16'b0101011101101101;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_scl = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
  //test 1 with reset 1
   @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_scl = 1;
  
  @(posedge tb_clk);
  #(CHECK_DELAY);
  
  //test 2 with reset 0
  @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 0;
  tb_scl = 1;
  
  @(posedge tb_clk);
  #(CHECK_DELAY);
  
  
  //test 3 with reset 1
  @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_scl = 1;
  
  @(posedge tb_clk);
  #(CHECK_DELAY);
  
  //test 4 with reset 0
  @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 0;
  tb_scl = 1;
  
  @(posedge tb_clk);
  #(CHECK_DELAY);
  
    
end 
endmodule    
	  
	  
	  