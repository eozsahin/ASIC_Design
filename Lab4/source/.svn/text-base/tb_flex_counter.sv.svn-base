// $Id: $
// File name:   tb_flex_counter.sv
// Created:     2/13/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Flexible Counter

`timescale 1ns / 10ps

module tb_flex_counter();
  
    localparam CLK_PERIOD = 2.5;
    localparam CHECK_DELAY = 5;
    
    reg tb_clk;
    
    //default case
    localparam DEFAULT_SIZE = 4;
    localparam DEFAULT_MAX_BIT = (DEFAULT_SIZE - 1);
    
    integer tb_def_test_num;
    integer tb_def_i;
    integer tb_def_fail_cnt;
    reg tb_def_n_reset;
    reg tb_def_count_enable;
    reg [DEFAULT_MAX_BIT:0] tb_def_rollover_val;
    reg [DEFAULT_MAX_BIT:0] tb_def_count_out;
    reg tb_def_rollover_flag;
    
    // configuration1: counting up to 64
    localparam CONFIG1_SIZE = 6;
    localparam CONFIG1_MAX_BIT = (CONFIG1_SIZE - 1);
    
    integer tb_c1_test_num;
    integer tb_c1_i;
    reg tb_c1_n_reset;
    reg tb_def_clear;
    reg tb_c1_count_enable;
    reg [CONFIG1_MAX_BIT:0] tb_c1_rollover_val;
    reg [CONFIG1_MAX_BIT:0] tb_c1_count_out;
    reg tb_c1_rollover_flag;
    
    // configuration1: counting up to 15
    localparam CONFIG2_SIZE = 4;
    localparam CONFIG2_MAX_BIT = (CONFIG2_SIZE - 1);
    
    integer tb_c2_test_num;
    integer tb_c2_i;
    reg tb_c2_n_reset;
    reg tb_c2_count_enable;
    reg [CONFIG2_MAX_BIT:0] tb_c2_rollover_val;
    reg [CONFIG2_MAX_BIT:0] tb_c2_count_out;
    reg tb_c2_rollover_flag;
    
    //DUT portmaps
    
    flex_counter DEFAULT
    (
      .clk(tb_clk),
      .n_rst(tb_def_n_reset),
      .count_enable(tb_def_count_enable),
      .rollover_val(tb_def_rollover_val),
      .count_out(tb_def_count_out),
      .rollover_flag(tb_def_rollover_flag),
      .clear(tb_clear)
    );
    
    counter_64 CONFIG1
    (
      .clk(tb_clk),
      .n_rst(tb_c1_n_reset),
      .count_enable(tb_c1_count_enable),
      .rollover_val(tb_c1_rollover_val),
      .count_out(tb_c1_count_out),
      .rollover_flag(tb_c1_rollover_flag)
    );
    
    counter_15 CONFIG2
    (
      .clk(tb_clk),
      .n_rst(tb_c2_n_reset),
      .count_enable(tb_c2_count_enable),
      .rollover_val(tb_c2_rollover_val),
      .count_out(tb_c2_count_out),
      .rollover_flag(tb_c2_rollover_flag)
    );
    
    
    always
    begin
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
    end
    
    initial 
    begin
        tb_def_clear = 1'b0;
        tb_def_n_reset = 1'b1;
        tb_def_rollover_val = '0;
        tb_def_count_enable = 1'b0;
        tb_def_test_num = 0;
        
        #(0.1);
		    tb_def_n_reset	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		    #(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
		    tb_def_n_reset	= 1'b1; 	// Deactivate the chip reset
      
        // Wait for a while to see normal operation
		    #(CLK_PERIOD);
		    
		    //Test 1:check n_rst functionality
		    @(negedge tb_clk); 
		    tb_def_test_num = tb_def_test_num + 1;
		    tb_def_n_reset = 1'b0;
		    tb_def_rollover_val = '1;
		    tb_def_count_enable = 1'b1; 
		    
		    #(CHECK_DELAY);
		    
		    if(tb_def_count_out == 4'b0000)
		        $info("Default Test Case %0d:: PASSED", tb_def_test_num);
		    else // Test case failed
			      $error("Default Test Case %0d:: FAILED", tb_def_test_num);		    
        
        //test 2 : check count enable
        
        @(negedge tb_clk); 
		    tb_def_test_num = tb_def_test_num + 1;
		    tb_def_n_reset = 1'b0;
		    tb_def_count_enable = 1'b0;
		    tb_def_rollover_val = '1;
		     
		    @(posedge tb_clk);
		    @(posedge tb_clk);
		    #(CHECK_DELAY);
		    
		    if(tb_def_count_out == 4'b0000)
		        $info("Default Test Case %0d:: PASSED", tb_def_test_num);
		    else // Test case failed
			      $error("Default Test Case %0d:: FAILED", tb_def_test_num);	
        
        
         
         
        
		    
  end  
  endmodule
  
  
  
  
  
