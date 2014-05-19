// $Id: $
// File name:   tb_neuron.sv
// Created:     4/27/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: test bench for neuron

`timescale 1ns / 10ps

module tb_neuron();
  
  parameter CLK_PERIOD			= 10;  
  localparam	CHECK_DELAY = 20; // Check 1ns after the rising edge to allow for propagation delay
  
  reg tb_test_num;
  reg tb_clk;
  reg [6:0] tb_input1,tb_input2;
  reg signed [4:0] tb_weight1,tb_weight2;
  reg signed [13:0] tb_addout;
  
  neuron DUT(
    .input1(tb_input1),
    .input2(tb_input2),
    .weight1(tb_weight1),
    .weight2(tb_weight2),
    .addout(tb_addout)
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
	  
	  // TEST CASE 1 w1 low w2 low
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_input1 = 65;
    tb_input2 = 45;
    tb_weight1 = 1;
    tb_weight2 = 1;
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
		//check the score  
		if(tb_addout == 110 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		
		
		// TEST CASE 2 w1 low w2 high
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_input1 = 65;
    tb_input2 = 45;
    tb_weight1 = 1;
    tb_weight2 = 14;
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
		//check the score  
		if(tb_addout == 695 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		  
		  
		// TEST CASE 3 w1 neg w2 high
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_input1 = 50;
    tb_input2 = 30;
    tb_weight1 = -5;
    tb_weight2 = 5;
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
		//check the score  
		if(tb_addout == -100 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		
		
		
		// TEST CASE 4 w1 high w2 high
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_input1 = 20;
    tb_input2 = 35;
    tb_weight1 = 12;
    tb_weight2 = 13;
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
		//check the score  
		if(tb_addout == 695 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		  
		// TEST CASE 5 w1 neg low w2 neg low
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_input1 = 20;
    tb_input2 = 35;
    tb_weight1 = -12;
    tb_weight2 = -13;
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
		//check the score  
		if(tb_addout == -695 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		  
		// TEST CASE 6 w1 high low w2 neg low
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_input1 = 40;
    tb_input2 = 35;
    tb_weight1 = 14;
    tb_weight2 = -13;
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
		//check the score  
		if(tb_addout == 105 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		  
		  
		// TEST CASE 7
	  @(negedge tb_clk);
    tb_test_num = tb_test_num + 1;  
    tb_input1 = 40;
    tb_input2 = 50;
    tb_weight1 = 2;
    tb_weight2 = -9;
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
		//check the score  
		if(tb_addout == -370 ) 
      $info("Default Test Case %0d: c_out : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: c_out : FAILED", tb_test_num);
		
	$stop;	  
  end
  
endmodule