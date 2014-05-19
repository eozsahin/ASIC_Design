// $Id: $
// File name:   tb_score_car.sv
// Created:     4/08/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench for prioritize block 

`timescale 1ns / 10ps

module tb_score_car();
  
  parameter CLK_PERIOD			= 10;  
  localparam	CHECK_DELAY = 20; // Check 1ns after the rising edge to allow for propagation delay
  
  //input
  reg tb_clk;
  reg tb_n_rst;
  reg tb_test_num;
  reg [5:0] tb_n_count; //only upto 50 
  reg [5:0] tb_s_count; //only upto 50 
  reg [5:0] tb_e_count; //only upto 50 
  reg [5:0] tb_w_count; //only upto 50 
  
  //output
  // dir: 1 = NS, 0 = EW
  reg tb_c_dir;
  reg [6:0] tb_c_out;
  
  score_car DUT
  (
    //input
    .n_count(tb_n_count),
    .s_count(tb_s_count),
    .e_count(tb_e_count),
    .w_count(tb_w_count),
    .c_out(tb_c_out),
    .c_dir(tb_c_dir)
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
	  tb_test_num = 0;
	  tb_n_rst = 1'b1;
	  tb_n_count = 0;
    tb_s_count = 0;
    tb_w_count = 0;
    tb_e_count = 0; 
	  
	  // Power-on Reset of the DUT
	  #(0.1);
		tb_n_rst	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		#(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
	  #(CLK_PERIOD);
	  tb_n_rst = 1'b0;  
	  
	  // TEST CASE 1
	  @(negedge tb_clk);
    tb_n_rst = 1;
    tb_test_num = tb_test_num + 1;  
    tb_n_count = 25; 
    tb_s_count = 30; 
    tb_e_count = 45; 
    tb_w_count = 35; 
    
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    //check the direction
    if(tb_c_dir == 1'b0 ) //NS: 55, EW: 80
      $info("Default Test Case %0d: c_dir : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_dir : FAILED", tb_test_num);
		
		//check the score  
		if(tb_c_out == 80 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		  
		  
		// TEST CASE 2
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_n_count = 40; 
    tb_s_count = 10; 
    tb_e_count = 25; 
    tb_w_count = 50; 
    
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    //check the direction
    if(tb_c_dir == 1'b0 ) //NS: 50, EW: 75
      $info("Default Test Case %0d: c_dir : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_dir : FAILED", tb_test_num);
		
		//check the score  
		if(tb_c_out == 75 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		
    
      
		// TEST CASE 3
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_n_count = 40; 
    tb_s_count = 45; 
    tb_e_count = 25; 
    tb_w_count = 20; 
    
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    //check the direction
    if(tb_c_dir == 1'b1 ) //NS: 85, EW: 45
      $info("Default Test Case %0d: c_dir : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_dir : FAILED", tb_test_num);
		
		//check the score  
		if(tb_c_out == 85 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
  
    
        
		// TEST CASE 4
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_n_count = 31; 
    tb_s_count = 43; 
    tb_e_count = 27; 
    tb_w_count = 36; 
    
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    //check the direction
    if(tb_c_dir == 1'b1 ) //NS: 74, EW: 63
      $info("Default Test Case %0d: c_dir : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_dir : FAILED", tb_test_num);
		
		//check the score  
		if(tb_c_out == 74 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
  
end
    
    
endmodule