// $Id: $
// File name:   tb_prioritize.sv
// Created:     3/28/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench for prioritize block 

`timescale 1ns / 10ps

module tb_prioritize();
  
  parameter CLK_PERIOD			= 10;  
  localparam	CHECK_DELAY = 20; // Check 1ns after the rising edge to allow for propagation delay
  
  //input
  reg tb_test_num;
  reg tb_clk;
  reg tb_n_rst;
  reg [6:0] tb_ws; //weather score out of 100
  reg [6:0] tb_ps; //pedestrian score out of 100
 // reg [6:0] tb_es; // emergency score out of 100
  reg [6:0] tb_cs; // car score out of 100
  
  //output
  reg [8:0] tb_t_score; // total score out of 300
  reg [5:0] tb_rank; // rank of the score
  
  //description of rank 
  //00 - ws
  //01 - ps
  //10 - cs
  
  
  prioritize DUT
  (
    //input
    .ws(tb_ws),
    .ps(tb_ps),
   // .es(tb_es),
    .cs(tb_cs),
    //output
    .rank(tb_rank),
    .t_score(tb_t_score)
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
	  tb_ws = 7'b0000000;
	  tb_cs = 7'b0000000;
	  //tb_es = 7'b0000000;
	  tb_ps = 7'b0000000;
	 
	  
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
    tb_ws = 7'b0110010; //50
    //tb_es = 7'b0111100; //60
    tb_ps = 7'b1000110; //70
    tb_cs = 7'b1010000; //80
    
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    if(tb_t_score == 200) 
      $info("Default Test Case %0d: t_score : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: t_score : FAILED", tb_test_num);
		
		if(tb_rank == 6'b100100)//order => cs, ps , ws  
		   $info("Default Test Case %0d: rank : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: rank : FAILED", tb_test_num);
		     
     
    // TEST CASE 2
		@(negedge tb_clk);
    tb_n_rst = 1;
    tb_test_num = tb_test_num + 1;  
    tb_ws = 90; 
    //tb_es = 55; 
    tb_ps = 75; 
    tb_cs = 40; 
    
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    if(tb_t_score == 205) //expected total score 260
      $info("Default Test Case %0d: t_score : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: t_score : FAILED", tb_test_num);
		
		if(tb_rank == 6'b000110)//order => ws, ps , es, cs  
		   $info("Default Test Case %0d: rank : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: rank : FAILED", tb_test_num);
		   
	    
    // TEST CASE 3
		@(negedge tb_clk);
    tb_n_rst = 1;
    tb_test_num = tb_test_num + 1;  
    tb_ws = 60; 
    //tb_es = 75; 
    tb_ps = 85; 
    tb_cs = 80; 
    
    @(posedge tb_clk);
    #(CHECK_DELAY);
    
    if(tb_t_score == 225) //expected total score 300
      $info("Default Test Case %0d: t_score : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: t_score : FAILED", tb_test_num);
		
		if(tb_rank == 6'b011000)//order => ps, cs,ws 
		   $info("Default Test Case %0d: rank : PASSED", tb_test_num);
	  else // Test case failed
		  $error("Default Test Case %0d: rank : FAILED", tb_test_num);
	  
	  
	end
  
endmodule