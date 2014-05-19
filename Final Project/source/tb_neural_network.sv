// $Id: $
// File name:   tb_neural_network.sv
// Created:     5/1/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: test bench for neural network.

`timescale 1ns/10ps
module tb_neural_network();
  
  parameter CLK_PERIOD			= 5;  
  localparam	CHECK_DELAY = 5; // Check 1ns after the rising edge to allow for propagation delay
  
  reg tb_clk; 
  reg tb_n_rst;
  reg [6:0] tb_traffic_score_ns;
  reg [6:0] tb_traffic_score_ew;
  reg [6:0] tb_ped_score_ns;
  reg [6:0] tb_ped_score_ew;
  reg signed [4:0] tb_traffic_ns_weight,tb_traffic_ew_weight,tb_ped_ns_weight,tb_ped_ew_weight,tb_time_weight;
  reg tb_enable;
  reg tb_calib_enable;
  reg tb_dir_out;
  reg signed [7:0] tb_time_change;
  reg tb_write_enable;
  reg [4:0] tb_TNS,tb_TEW,tb_PNS,tb_PEW;
  reg signed [13:0] tb_NS_OUT, tb_EW_OUT;
  reg signed [4:0] tb_old_tns_weight,tb_old_tew_weight,tb_old_pns_weight,tb_old_pew_weight,tb_old_time_weight;

  neural_network DUT
  (
  
    //inputs
    .clk(tb_clk),
    .n_rst(tb_n_rst),
    .traffic_score_ns(tb_traffic_score_ns),
    .traffic_score_ew(tb_traffic_score_ew),
    .ped_score_ns(tb_ped_score_ns),
    .ped_score_ew(tb_ped_score_ew),
   // .enable(tb_enable),
    .traffic_ns_weight(tb_traffic_ns_weight),
    .traffic_ew_weight(tb_traffic_ew_weight),
    .ped_ns_weight(tb_ped_ns_weight),
    .ped_ew_weight(tb_ped_ew_weight),
    .time_weight(tb_time_weight),
    //outputs
    .dir_out(tb_dir_out),
    .time_change(tb_time_change),
    .write_enable(tb_write_enable),
    .TNS(tb_TNS),
    .TEW(tb_TEW),
    .PNS(tb_PNS),
    .PEW(tb_PEW),
    .NS_OUT(tb_NS_OUT),
    .EW_OUT(tb_EW_OUT),
    .old_tns_weight(tb_old_tns_weight),
    .old_pns_weight(tb_old_pns_weight),
    .old_tew_weight(tb_old_tew_weight),
    .old_pew_weight(tb_old_pew_weight),
    .calib_enable(tb_calib_enable),
    .old_time_weight(tb_old_time_weight)
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
	  
	  //test case 1
	  tb_enable = 1;
	  tb_n_rst = 1;
	  tb_traffic_score_ns = 25;
	  tb_traffic_score_ew = 8;
	  tb_ped_score_ns = 81;
	  tb_ped_score_ew = 90;
	  
	  tb_traffic_ns_weight = 10;
	  tb_traffic_ew_weight= 10;
	  tb_ped_ns_weight= 10;
	  tb_ped_ew_weight = 10;
	  tb_time_weight = 5;
	  
	  
	  @(negedge tb_clk);
	  tb_enable = 0;
  
	  
	  //test case 2
	  @(negedge tb_clk);
	  tb_enable = 1;
	  tb_traffic_score_ns = 22;
	  tb_traffic_score_ew = 81;
	  tb_ped_score_ns = 67;
	  tb_ped_score_ew = 55;
	  
	  tb_traffic_ns_weight = 2;
	  tb_traffic_ew_weight= 3;
	  tb_ped_ns_weight= 5;
	  tb_ped_ew_weight = 1;
	  
	  
	  @(negedge tb_clk);
	  tb_enable = 0;
	  
	 
	  //test case 3
	  @(negedge tb_clk);
	  tb_enable = 1;
	  tb_traffic_score_ns = 35;
	  tb_traffic_score_ew = 95;
	  tb_ped_score_ns = 30;
	  tb_ped_score_ew = 75;
	  
	  tb_traffic_ns_weight = 6;
	  tb_traffic_ew_weight= 7;
	  tb_ped_ns_weight= 3;
	  tb_ped_ew_weight = 2;
	  
	  
	  @(negedge tb_clk);
	  tb_enable = 0;
	  

	  //test case 4
	  @(negedge tb_clk);
	  tb_enable = 1;
	  tb_traffic_score_ns = 45;
	  tb_traffic_score_ew = 65;
	  tb_ped_score_ns = 47;
	  tb_ped_score_ew = 58;
	  
	  tb_traffic_ns_weight = 2;
	  tb_traffic_ew_weight= 1;
	  tb_ped_ns_weight= 8;
	  tb_ped_ew_weight = 5;
	  
	  
	  @(negedge tb_clk);
	  tb_enable = 0;
	  
	 
	  

	  //test case 5
	  @(negedge tb_clk);
	  tb_enable = 1;
	  tb_traffic_score_ns = 20;
	  tb_traffic_score_ew = 50;
	  tb_ped_score_ns = 35;
	  tb_ped_score_ew = 60;
	  
	  tb_traffic_ns_weight = 1;
	  tb_traffic_ew_weight= 2;
	  tb_ped_ns_weight= 3;
	  tb_ped_ew_weight = 4;
	  
	  
	  @(negedge tb_clk);
	  tb_enable = 0;
	  

	  //test case 6
	  @(negedge tb_clk);
	  tb_enable = 1;
	  tb_traffic_score_ns = 45;
	  tb_traffic_score_ew = 35;
	  tb_ped_score_ns = 90;
	  tb_ped_score_ew = 75;
	  
	  tb_traffic_ns_weight = 3;
	  tb_traffic_ew_weight= 2;
	  tb_ped_ns_weight= 4;
	  tb_ped_ew_weight = 7;
	  
	  @(negedge tb_clk);
	  tb_enable = 0;
	  
	  
	  //test case 7
	  @(negedge tb_clk);
	  tb_enable = 1;
	  tb_traffic_score_ns = 45;
	  tb_traffic_score_ew = 65;
	  tb_ped_score_ns = 47;
	  tb_ped_score_ew = 58;
	  
	  tb_traffic_ns_weight = 1;
	  tb_traffic_ew_weight= 1;
	  tb_ped_ns_weight= 5;
	  tb_ped_ew_weight = 6;
	  
	  
	  @(negedge tb_clk);
	  tb_enable = 0;
	  
	  //test case 8
	  @(negedge tb_clk);
	  tb_enable = 1;
	  tb_traffic_score_ns = 30;
	  tb_traffic_score_ew = 40;
	  tb_ped_score_ns = 50;
	  tb_ped_score_ew = 60;
	  
	  tb_traffic_ns_weight = 1;
	  tb_traffic_ew_weight= -1;
	  tb_ped_ns_weight= 2;
	  tb_ped_ew_weight = -2;
	  
	  
	  @(negedge tb_clk);
	  tb_enable = 0;
    
	  
	   
    $stop; 	  
	  
	end
	
	
endmodule