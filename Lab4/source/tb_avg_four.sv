// $Id: $
// File name:   tb_avg_four.sv
// Created:     2/15/2014
// Author:      Brad Warrum
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test bench for overall 4 sample window averager

`timescale 1ns / 100ps
module tb_avg_four ();
  
  // PARAMETER DECLARATIONS
  localparam CLOCKPERIOD = 5; //Clock runs at 200 MHz
  localparam MAXDELAY = 20; //Maximum number of clock cycles before output data must be present
  localparam PROC_PERIOD = MAXDELAY * CLOCKPERIOD; //Max length of time before output data must be present
  
  // IGNORE THESE, THIS IS FOR REPORT HANDLING
  localparam NUMTESTSB1 = 999;
  localparam NUMTESTSB2 = 1;
  localparam NUMTESTSB3 = 1;
  localparam NUMTESTSB4 = 1;
  localparam NUMTESTSB5 = 1;
  localparam NUMTESTSB6 = 1;
  localparam NUMTESTSB7 = 500;
  
  
  // TB VARIABLE DECLARATIONS
  // DUT
  reg tb_clk;
  reg tb_n_reset;
  reg [15:0] tb_sample_data;
  reg tb_data_ready;
  reg tb_one_k_samples;
  reg tb_modwait;
  reg [15:0] tb_avg_out;
  reg tb_err;
  // INTERNAL, IGNORE THESE
  integer i;
  integer k;
  integer num_failed_b1 = 0;
  integer num_failed_b2 = 0;
  integer num_failed_b3 = 0;
  integer num_failed_b4 = 0;
  integer num_failed_b5 = 0;
  integer num_failed_b6 = 0;
  integer num_failed_b7 = 0;
  reg [15:0] rand_test_data;
  reg [15:0] sample1;
  reg [15:0] sample2;
  reg [15:0] sample3;
  reg [15:0] sample4;
  reg [15:0] expected_out; // Expected output from the gold model
  reg expected_v; // Overflow value expected from the addition
  
  // DUT PORTMAP
  avg_four DUT (.clk(tb_clk),
                .n_reset(tb_n_reset),
                .sample_data(tb_sample_data),
                .data_ready(tb_data_ready),
                .one_k_samples(tb_one_k_samples),
                .modwait(tb_modwait),
                .avg_out(tb_avg_out),
                .err(tb_err));
     
  // GOLD PORTMAP            
  gold_avg_four GOLD (.clk(tb_clk),
                      .n_reset(tb_n_reset),
                      .sample_data(tb_sample_data),
                      .data_ready(tb_data_ready),
                      .one_k_samples(),
                      .modwait(),
                      .avg_out(expected_out),
                      .err(expected_v));
  
  // CLOCK GENERATION
  always begin
    tb_clk = 1'b0;
    #(CLOCKPERIOD);
    tb_clk = 1'b1;
    #(CLOCKPERIOD);
  end
  
  // MAIN PROCESS
  initial
  begin
    
    #(0.1);
    // Initialize all input values to a known state
    tb_n_reset = 1'b1; //Inactive
    tb_sample_data = 16'h0000;
    tb_data_ready = 1'b0; // Inactive
    
    // Perform reset
    #(CLOCKPERIOD * 2.5);
    tb_n_reset = 1'b0;
    @(negedge tb_clk);
    tb_n_reset = 1'b1;
    
    // Main Test: Large Sample Test for Maximal Code Coverage
    // This will loop over a large amount of random test data and check the outputs
    #(CLOCKPERIOD * 2);
    //Initialize all the sample points to 0 so we don't have erratic behavior
    sample1 = 16'h0000;
    sample2 = 16'h0000;
    sample3 = 16'h0000;
    sample4 = 16'h0000;
    //Make sure to actually set the sample data
    tb_sample_data = 16'h0000;
    #(CLOCKPERIOD);
    num_failed_b1 = 0;
    $display("BLOCK 1: TESTS CASES OF STATIC SEED RANDOMLY GENERATED 8-BIT VALUES");
    // Clock the 4 samples in over 4 * 20 = 80 clock cycles, approximately
    for (i = 0; i < 4; i++) begin
      @(negedge tb_clk);
      tb_data_ready = 1'b1;
      for (k = 0; k< 3; k++) begin
        // Hold tb_data_ready high for 3 clock cycles
        @(negedge tb_clk);
      end
      tb_data_ready = 1'b0;
      for (k = 0; k<17; k++) begin
        //Wait for the total 20 clock cycles for data
        @(posedge tb_clk);
      end
    end
    // The output should be zero at this point
    assert (tb_avg_out == 16'h0000)
    else begin
      $error("FAILED - ALL ZERO INPUTS - AVG OUT IS %d", tb_avg_out); 
      num_failed_b1 ++;  
    end
    
    // Now, run until we have 999 samples so we can easily check the one_k_sample output
    for (i = 4; i < 999; i++) begin
      #(1);
      @(negedge tb_clk);
      tb_data_ready = 1'b0;
      sample1 = sample2;
      sample2 = sample3;
      sample3 = sample4;
      sample4 = $urandom_range(32'h000000FF, 32'h00000000);
      tb_sample_data = sample4;
      #(CLOCKPERIOD);
      @(negedge tb_clk);
      tb_data_ready = 1'b1;
      for (k = 0; k< 3; k++) begin
        // Hold tb_data_ready high for 3 clock cycles
        @(negedge tb_clk);
      end
      tb_data_ready = 1'b0;
      for (k = 0; k<17; k++) begin
        //Wait for the total 20 clock cycles for data
        @(posedge tb_clk);
      end
      assert(tb_avg_out == expected_out & ~tb_one_k_samples & ~tb_modwait)
      else begin
        num_failed_b1++;
        if (tb_avg_out != expected_out) begin
          $error("FAILED BLOCK 1 TEST %d: FAILURE REASON - AVG OUT DID NOT MATCH EXPECTED OUTPUT", i);
        end 
        if (tb_one_k_samples) begin
          $error("FAILED BLOCK 1 TEST %d: FAILURE REASON - UNEXPECTED 1000 SAMPLE ASSERTION",i);
        end 
        if (tb_modwait) begin
          $error("FAILED BLOCK 1 TEST %d: FAILURE REASON - MODWAIT IS STILL ASSERTED AFTER 20 CYCLES", i);
        end
        $info("BLOCK 1 TEST %d: INPUTS ARE %d, %d, %d, %d, EXPECTED %d, GOT %d", i, sample1, sample2, sample3, sample4, expected_out, tb_avg_out);
      end
        
    end
    
    // TEST 2 - ONE K SAMPLES CHECK
    $display("BLOCK 2: CHECKS FOR ONE_K_SAMPLES ACTIVE AFTER 1000 SAMPLES");
    #(1);
    num_failed_b2 = 0;
    @(negedge tb_clk);
    tb_data_ready = 1'b0;
    sample1 = sample2;
    sample2 = sample3;
    sample3 = sample4;
    sample4 = $urandom_range(32'h000000FF, 32'h00000000);
    tb_sample_data = sample4;
    #(CLOCKPERIOD);
    @(negedge tb_clk);
    tb_data_ready = 1'b1;
    for (k = 0; k< 3; k++) begin
      // Hold tb_data_ready high for 3 clock cycles
      @(negedge tb_clk);
    end
    tb_data_ready = 1'b0;
    for (k = 0; k<17; k++) begin
      //Wait for the total 20 clock cycles for data
      @(posedge tb_clk);
    end
    assert(tb_avg_out == expected_out & tb_one_k_samples)
    else begin
      num_failed_b2 ++;
      if (tb_avg_out != expected_out & ~tb_modwait) begin
        $error("FAILED BLOCK 2 TEST 1: FAILURE REASON - AVG OUT DID NOT MATCH EXPECTED OUTPUT");
      end 
      if (~tb_one_k_samples) begin
        $error("FAILED BLOCK 2 TEST 1: FAILURE REASON - ONE_K_SAMPLES WAS NOT ASSERTED AFTER 1000 SAMPLES", i);
      end
      if (tb_modwait) begin
        $error("FAILED BLOCK 2 TEST 1: FAILURE REASON - MODWAIT STILL ASSERTED AFTER 20 CLOCK CYCLES");
      end 
      $info("BLOCK 2 TEST 1: INPUTS ARE %d, %d, %d, %d, EXPECTED %d, GOT %d", sample1, sample2, sample3, sample4, expected_out, tb_avg_out);
    end
    
    // TEST 3 - POST-ONE K SAMPLES CHECK
    $display("BLOCK 3: CHECKS FOR ONE_K_SAMPLES INACTIVE AFTER 1001 SAMPLES");
    #(1);
    num_failed_b3 = 0;
    @(negedge tb_clk);
    tb_data_ready = 1'b0;
    sample1 = sample2;
    sample2 = sample3;
    sample3 = sample4;
    sample4 = $urandom_range(32'h000000FF, 32'h00000000);
    tb_sample_data = sample4;
    #(CLOCKPERIOD);
    @(negedge tb_clk);
    tb_data_ready = 1'b1;
    for (k = 0; k< 3; k++) begin
      // Hold tb_data_ready high for 3 clock cycles
      @(negedge tb_clk);
    end
    tb_data_ready = 1'b0;
    for (k = 0; k<17; k++) begin
      //Wait for the total 20 clock cycles for data
      @(posedge tb_clk);
    end
    assert(tb_avg_out == expected_out & ~tb_one_k_samples & ~tb_modwait)
    else begin
      num_failed_b3 ++;
      if (tb_avg_out != expected_out) begin
        $error("FAILED BLOCK 3 TEST 1: FAILURE REASON - AVG OUT DID NOT MATCH EXPECTED OUTPUT");
      end
      if (tb_one_k_samples) begin
        $error("FAILED BLOCK 3 TEST 1: FAILURE REASON - ONE_K_SAMPLES WAS NOT RESET AFTER 1000 SAMPLES");
      end
      if (tb_modwait) begin
        $error("FAILED BLOCK 3 TEST 1: FAILURE REASON - MODWAIT STILL ASSERTED AFTER 20 CLOCK CYCLES");
      end
      $info("BLOCK 3 TEST 1: INPUTS ARE %d, %d, %d, %d, EXPECTED %d, GOT %d", sample1, sample2, sample3, sample4, expected_out, tb_avg_out);
    end
    
    // TEST BLOCK 4 - OVERFLOW ON PRELIMINARY ADDITION 1
    // This will make the state of the registers as follows:
    // DATA REG 1 = 0x0000;
    // DATA REG 2 = 0x0000;
    // DATA REG 3 = 0xFFFF;
    // DATA REG 4 = 0xFFFF;
    // You are guaranteed an overflow from this addition, but it should happen on the
    // an intermediate addition.  These next 3 test cases check for overflow generation
    // from the 3 different addition states of the FSM.
    // NOTE that this might not fail on a preliminary addition if you did your additions in a strange way.
    #(CLOCKPERIOD / 2.0);
    num_failed_b4 = 0;
    tb_sample_data = 16'h0000;
    $display("BLOCK 1: TESTS CASES OF STATIC SEED RANDOMLY GENERATED 8-BIT VALUES");
    for (i = 0; i < 2; i++) begin
      @(negedge tb_clk);
      tb_data_ready = 1'b1;
      for (k = 0; k< 3; k++) begin
        // Hold tb_data_ready high for 3 clock cycles
        @(negedge tb_clk);
      end
      tb_data_ready = 1'b0;
      for (k = 0; k<17; k++) begin
        //Wait for the total 20 clock cycles for data
        @(posedge tb_clk);
      end
    end
    // Clock in the FFFF values
    #(CLOCKPERIOD / 2.0);
    tb_sample_data = 16'hFFFF;
    $display("BLOCK 1: TESTS CASES OF STATIC SEED RANDOMLY GENERATED 8-BIT VALUES");
    for (i = 0; i < 2; i++) begin
      @(negedge tb_clk);
      tb_data_ready = 1'b1;
      for (k = 0; k< 3; k++) begin
        // Hold tb_data_ready high for 3 clock cycles
        @(negedge tb_clk);
      end
      tb_data_ready = 1'b0;
      for (k = 0; k<17; k++) begin
        //Wait for the total 20 clock cycles for data
        @(posedge tb_clk);
      end
    end
    // The output should be an overflow error at this point, from the first preliminary addition
    assert (tb_err)
    else begin
      $error("FAILED BLOCK 4 TEST 1: FAILURE REASON - ERROR IS NOT ASSERTED ON 1st PRELIMINARY ADDITION"); 
      num_failed_b4 ++;  
    end
    
    // TEST BLOCK 5 - OVERFLOW ON PRELIMINARY ADDITION 2
    // Same logic follows as the last test block, but now we are reversing the data.
    // AGAIN NOTE that if your additions were processed differently, you should still receive
    // an error but it may not be due to a preliminary addition.
    #(CLOCKPERIOD / 2.0);
    num_failed_b5  = 0;
    tb_sample_data = 16'h0000;
    $display("BLOCK 1: TESTS CASES OF STATIC SEED RANDOMLY GENERATED 8-BIT VALUES");
    for (i = 0; i < 2; i++) begin
      @(negedge tb_clk);
      tb_data_ready = 1'b1;
      for (k = 0; k< 3; k++) begin
        // Hold tb_data_ready high for 3 clock cycles
        @(negedge tb_clk);
      end
      tb_data_ready = 1'b0;
      for (k = 0; k<17; k++) begin
        //Wait for the total 20 clock cycles for data
        @(posedge tb_clk);
      end
    end
    // The output should be an overflow error at this point
    assert (tb_err)
    else begin
      $error("FAILED BLOCK 5 TEST 1: FAILURE REASON - ERROR IS NOT ASSERTED ON 2nd PRELIMINARY ADDITION"); 
      num_failed_b5 ++;  
    end
    // TEST BLOCK 6 - OVERFLOW ON TOTAL ADDITION
    // Inputting all register values as 0x4000 will ensure that only the final addition produces an error
    // state. This rounds out the overflow error checking.
    #(CLOCKPERIOD / 2.0);
    tb_sample_data = 16'h4000;
    num_failed_b6 = 0;
    $display("BLOCK 1: TESTS CASES OF STATIC SEED RANDOMLY GENERATED 8-BIT VALUES");
    for (i = 0; i < 4; i++) begin
      @(negedge tb_clk);
      tb_data_ready = 1'b1;
      for (k = 0; k< 3; k++) begin
        // Hold tb_data_ready high for 3 clock cycles
        @(negedge tb_clk);
      end
      tb_data_ready = 1'b0;
      for (k = 0; k<17; k++) begin
        //Wait for the total 20 clock cycles for data
        @(posedge tb_clk);
      end
    end
    // The output should be an overflow error at this point
    assert (tb_err)
    else begin
      $error("FAILED BLOCK 6 TEST 1: FAILURE REASON - ERROR IS NOT ASSERTED ON FINAL ADDITION"); 
      num_failed_b6 ++;  
    end
    
    //TEST BLOCK 7 - 16 BIT RANDOM GENERATION WITH OVERFLOW CHECKING
    //This test block should seek maximal coverage.  It generates 500 different 16-bit input values and
    //checks the output.  This will require err generation and proper avg_out generation, as some values
    //will produce overflows.
    num_failed_b7 = 0;
    for (i = 1; i < 501; i++) begin
      #(1);
      @(negedge tb_clk);
      tb_data_ready = 1'b0;
      sample1 = sample2;
      sample2 = sample3;
      sample3 = sample4;
      sample4 = $urandom_range(32'h0000FFFF, 32'h00000000);
      tb_sample_data = sample4;
      #(CLOCKPERIOD);
      @(negedge tb_clk);
      tb_data_ready = 1'b1;
      for (k = 0; k< 3; k++) begin
        // Hold tb_data_ready high for 3 clock cycles
        @(negedge tb_clk);
      end
      tb_data_ready = 1'b0;
      for (k = 0; k<17; k++) begin
        //Wait for the total 20 clock cycles for data
        @(posedge tb_clk);
      end
      assert(tb_avg_out == expected_out & ~tb_one_k_samples & tb_err == expected_v & ~tb_modwait)
      else begin
        num_failed_b7++;
        if (tb_avg_out != expected_out) begin
          $error("FAILED BLOCK 7 TEST %d: FAILURE REASON - AVG OUT DID NOT MATCH EXPECTED OUTPUT", i);
        end
        if (tb_one_k_samples) begin
          $error("FAILED BLOCK 7 TEST %d: FAILURE REASON - UNEXPECTED 1000 SAMPLE ASSERTION",i);
        end
        if (tb_err != expected_v) begin
          $error("FAILED BLOCK 7 TEST %d: FAILURE REASON - ERROR VALUE DOES NOT MATCH EXPECTED ERROR OUTPUT", i);
        end
        if (tb_modwait) begin
          $error("FAILED BLOCK 7 TEST %d: FAILURE REASON - MODWAIT STILL ASSERTED AFTER 20 CLOCK CYCLES", i);
        end
        $info("BLOCK 7 TEST %d: INPUTS ARE %d, %d, %d, %d, EXPECTED %d, GOT %d", i, sample1, sample2, sample3, sample4, expected_out, tb_avg_out);
      end
        
    end
    
    // SUMMARY
    $display("\n\n\n\n--------------------------REPORT SUMMARY--------------------------");
    $display("TEST BLOCK 1: RANDOM 8 BIT INPUTS");
    $display("        TEST CASES PASSED: %d OUT OF %d", NUMTESTSB1 - num_failed_b1, NUMTESTSB1);
    $display("\n\nTEST BLOCK 2: ONE K SAMPLES ACTIVATION");
    $display("        TEST CASES PASSED: %d OUT OF %d", NUMTESTSB2 - num_failed_b2, NUMTESTSB2);
    $display("\n\nTEST BLOCK 3: ONE K SAMPLES DEACTIVATION");
    $display("        TEST CASES PASSED: %d OUT OF %d", NUMTESTSB3 - num_failed_b3, NUMTESTSB3);
    $display("\n\nTEST BLOCK 4: PRELIMINARY ADDITION 1 OVERFLOW HANDLING");
    $display("        TEST CASES PASSED: %d OUT OF %d", NUMTESTSB4 - num_failed_b4, NUMTESTSB4);
    $display("\n\nTEST BLOCK 5: PRELIMINARY ADDITION 2 OVERFLOW HANDLING");
    $display("        TEST CASES PASSED: %d OUT OF %d", NUMTESTSB5 - num_failed_b5, NUMTESTSB5);
    $display("\n\nTEST BLOCK 6: TOTAL ADDITION OVERFLOW HANDLING");
    $display("        TEST CASES PASSED: %d OUT OF %d", NUMTESTSB6 - num_failed_b6, NUMTESTSB6);
    $display("\n\nTEST BLOCK 7: RANDOM 16 BIT INPUTS WITH OVERFLOW POSSIBILITY");
    $display("        TEST CASES PASSED: %d OUT OF %d", NUMTESTSB7 - num_failed_b7, NUMTESTSB7);
    $display("------------------------------------------------------------------");
    $display("TOTAL CASES PASSED: %d OUT OF %d", 
      (NUMTESTSB1 + NUMTESTSB2+ NUMTESTSB3+ NUMTESTSB4+ NUMTESTSB5+ NUMTESTSB6+ NUMTESTSB7) - 
      (num_failed_b1 + num_failed_b2 + num_failed_b3 + num_failed_b4 + num_failed_b5 + num_failed_b6 + num_failed_b7), 
      (NUMTESTSB1 + NUMTESTSB2+ NUMTESTSB3+ NUMTESTSB4+ NUMTESTSB5+ NUMTESTSB6+ NUMTESTSB7));
    $display("------------------------------------------------------------------");
  end
      
      
  
endmodule