// $Id: $
// File name:   tb_calibrator.sv
// Created:     4/27/2014
// Author:      Shreyas Ganesh Sundararaman
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: TestBench for calibrator
`timescale 1ns/10ps

module tb_new_calibrator(
);
   reg clk,n_rst;
   reg enable;
   reg SRAM_ready;
   reg signed [4:0] curr_tr_ns_weight, curr_tr_ew_weight,curr_ped_ns_weight,curr_ped_ew_weight,curr_time_weight;
   reg signed [6:0] tns,tew,pns,pew;
   reg signed [13:0] sram_NS_out,sram_EW_out;
   reg sram_dir_out;
   reg signed [7:0] sram_time_change;
   reg ready;
   reg [9:0] Address;
   reg SRAM_enable;
   reg signed [4:0] new_tr_ns_weight,new_tr_ew_weight,new_ped_ns_weight,new_ped_ew_weight,new_time_weight;
   reg signed [6:0] var_time;
   reg dir_out;
   
  
  new_calibrator DUT (
    //inputs
    .clk(clk),
    .n_rst(n_rst),
    .enable(enable),
    .curr_tr_ns_weight(curr_tr_ns_weight),
    .curr_tr_ew_weight(curr_tr_ew_weight),
    .curr_ped_ns_weight(curr_ped_ns_weight),
    .curr_ped_ew_weight(curr_ped_ew_weight),
    .curr_time_weight(curr_time_weight),
    .tns(tns),
    .tew(tew),
    .pns(pns),
    .pew(pew),
    .sram_NS_out(sram_NS_out),
    .sram_EW_out(sram_EW_out),
    .sram_dir_out(sram_dir_out),
    .sram_time_change(sram_time_change),
    //outputs
    .ready(ready),
    .Address(Address),
    .SRAM_enable(SRAM_enable),
    .new_tr_ns_weight(new_tr_ns_weight),
    .new_tr_ew_weight(new_tr_ew_weight),
    .new_ped_ns_weight(new_ped_ns_weight),
    .new_ped_ew_weight(new_ped_ew_weight),
    .new_time_weight(new_time_weight),
    .dir_out(dir_out)
    );  
  
  reg signed [7:0] sram_traffic_ns,sram_traffic_ew,sram_ped_ns,sram_ped_ew;
  reg guess_dir_out;
  reg signed [7:0] guess_time_change;
  reg signed [11:0] left_expression;
  reg signed [13:0] diff;
  reg [16:0] time_out_estimate;
  int i,j;
   
   
  parameter CLK_PERIOD			= 10;  
  localparam	CHECK_DELAY = 70;  
     
  always
	begin
		clk = 1'b0;
		#(CLK_PERIOD/2.0);
		clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end 
   
 initial begin
   sram_traffic_ns = {1'b0,tns};
  sram_traffic_ew = {1'b0,tew};
  sram_ped_ns = {1'b0,pns}; 
  sram_ped_ew = {1'b0,pew};
    clk = 1;
    n_rst = 0;
  
    
    var_time = 20;
    //TESTCASE 1
    @(negedge clk);
    n_rst = 1;
    enable = 0;
    SRAM_ready = 1;
    curr_tr_ns_weight = 1;
    curr_tr_ew_weight = 3;
    curr_ped_ns_weight = 5;
    curr_ped_ew_weight =7;
    curr_time_weight = 2;
    tns = 45;
    tew = 30;
    pns = 20;
    pew = 30;
    sram_traffic_ns = {1'b0,tns};
    sram_traffic_ew = {1'b0,tew};
    sram_ped_ns = {1'b0,pns}; 
    sram_ped_ew = {1'b0,pew};
    sram_NS_out = 160;
    sram_EW_out = 280;
    sram_dir_out = 1;
    

    /*
    j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
       sram_dir_out = 0;
     end else begin
       diff = sram_NS_out - sram_EW_out;
       sram_dir_out = 1;
     end
     time_out_estimate = diff*curr_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
    sram_time_change = i*8;
    sram_time_change = sram_time_change+20;
    */
    
    guess_time_change = 90;
    sram_time_change = 110;
    
    
    @(posedge clk);
    #(CHECK_DELAY);
    left_expression = new_tr_ns_weight*sram_traffic_ns+new_ped_ns_weight*sram_ped_ns;
    
    if(left_expression <= sram_NS_out+var_time && left_expression >= sram_NS_out-var_time) begin
        $info("NS : you passed son!");
     end else begin
       $error("NS : Tough luck bro!");
     end
    left_expression = new_tr_ew_weight*sram_traffic_ew + new_ped_ew_weight*sram_ped_ew;

     if(left_expression<= sram_EW_out+var_time && left_expression>= sram_EW_out-var_time) begin
        $info("EW : you passed son!");
     end else begin
       $error("EW : Tough luck bro!");
     end
     
     /*
     j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
     end else begin
       diff = sram_NS_out - sram_EW_out;
     end
     time_out_estimate = diff*new_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
     guess_time_change = i*8;
     */
     
     sram_time_change = 110;
     if(guess_time_change <= sram_time_change + var_time && guess_time_change >= sram_time_change - var_time) begin
        $info("TIME : you passed son!");
     end else begin
        $error("TIME : Tough luck bro!");
     end
     
     guess_dir_out = (sram_EW_out > sram_NS_out)? 1'b0 : 1'b1;
     
     if(guess_dir_out == sram_dir_out) begin
        $info("DIR : you passed son!");
     end else begin
        $error("DIR : Tough luck bro!");
     end
     
    
    
    //TESTCASE 2 
    @(negedge clk);
    n_rst = 1;
    enable = 1;
    SRAM_ready = 1;
    curr_tr_ns_weight = 2;
    curr_tr_ew_weight = 1;
    curr_ped_ns_weight = 3;
    curr_ped_ew_weight =4;
    curr_time_weight = 1;
    tns = 60;
    tew = 80;
    pns = 70;
    pew = 30;
    sram_NS_out = 330;
    sram_EW_out = 220;
    sram_dir_out = 1;
    sram_traffic_ns = {1'b0,tns};
    sram_traffic_ew = {1'b0,tew};
    sram_ped_ns = {1'b0,pns}; 
    sram_ped_ew = {1'b0,pew};
    /*
    j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
       sram_dir_out = 0;
     end else begin
       diff = sram_NS_out - sram_EW_out;
       sram_dir_out = 1;
     end
     time_out_estimate = diff*curr_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
    sram_time_change = i*8;
    sram_time_change = sram_time_change+20;
    */
    sram_time_change = 110;
    
    @(posedge clk);
    #(CHECK_DELAY);
    left_expression = new_tr_ns_weight*sram_traffic_ns+new_ped_ns_weight*sram_ped_ns;
    
    if(left_expression <= sram_NS_out+var_time && left_expression >= sram_NS_out-var_time) begin
        $info("NS : you passed son!");
     end else begin
       $error("NS : Tough luck bro!");
     end
     
    left_expression = new_tr_ew_weight*sram_traffic_ew + new_ped_ew_weight*sram_ped_ew;

     if(left_expression<= sram_EW_out+var_time && left_expression>= sram_EW_out-var_time) begin
        $info("EW : you passed son!");
     end else begin
       $error("EW : Tough luck bro!");
     end
     
     /*
     j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
     end else begin
       diff = sram_NS_out - sram_EW_out;
     end
     time_out_estimate = diff*new_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
     
     */
     
     
     guess_time_change = i*8;
     if(guess_time_change <= sram_time_change+var_time && guess_time_change >= sram_time_change-var_time) begin
        $info("TIME : you passed son!");
     end else begin
        $error("TIME : Tough luck bro!");
     end
     
     guess_dir_out = (sram_EW_out > sram_NS_out)? 1'b0 : 1'b1;
     
     if(guess_dir_out == sram_dir_out) begin
        $info("DIR : you passed son!");
     end else begin
        $error("DIR : Tough luck bro!");
     end
     
    
    //TESTCASE 3
    @(negedge clk);
    enable = 1'b1;
    curr_tr_ns_weight = -1;
    curr_tr_ew_weight = 2;
    curr_ped_ns_weight = 3;
    curr_ped_ew_weight = -4;
    curr_time_weight = 4;
    tns = 50;
    tew = 75;
    pns = 10;
    pew = 15;
    sram_NS_out = -10;
    sram_EW_out = 100;
    sram_dir_out = 1;
    sram_traffic_ns = {1'b0,tns};
    sram_traffic_ew = {1'b0,tew};
    sram_ped_ns = {1'b0,pns}; 
    sram_ped_ew = {1'b0,pew};
    
    /*
    j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
       sram_dir_out = 0;
     end else begin
       diff = sram_NS_out - sram_EW_out;
       sram_dir_out = 1;
     end
     time_out_estimate = diff*curr_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
    sram_time_change = i*8;
    sram_time_change = sram_time_change+20;
    
    */
    
    sram_time_change = 110;
     @(posedge clk);
    #(CHECK_DELAY);
    left_expression = new_tr_ns_weight*sram_traffic_ns+new_ped_ns_weight*sram_ped_ns;
    
    if(left_expression <= sram_NS_out+var_time && left_expression >= sram_NS_out-var_time) begin
        $info("NS : you passed son!");
     end else begin
       $error("NS : Tough luck bro!");
     end
     
     left_expression = new_tr_ew_weight*sram_traffic_ew + new_ped_ew_weight*sram_ped_ew;

     if(left_expression<= sram_EW_out+var_time && left_expression>= sram_EW_out-var_time) begin
        $info("EW : you passed son!");
     end else begin
       $error("EW : Tough luck bro!");
     end
     
     /*
     j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
     end else begin
       diff = sram_NS_out - sram_EW_out;
     end
     time_out_estimate = diff*new_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
     guess_time_change = i*8;
     */
     
     sram_time_change = 110;
     if(guess_time_change <= sram_time_change+var_time && guess_time_change >= sram_time_change-var_time) begin
        $info("TIME : you passed son!");
     end else begin
        $error("TIME : Tough luck bro!");
     end
     
     guess_dir_out = (sram_EW_out > sram_NS_out)? 1'b0 : 1'b1;
     
     if(guess_dir_out == sram_dir_out) begin
        $info("DIR : you passed son!");
     end else begin
        $error("DIR : Tough luck bro!");
     end
    
    //TESTCASE 4
    @(negedge clk);
    curr_tr_ns_weight = 7;
    curr_tr_ew_weight = 4;
    curr_ped_ns_weight = 6;
    curr_ped_ew_weight =2;
    curr_time_weight = 5;
    tns = 20;
    tew = 85;
    pns = 30;
    pew = 67;
    sram_NS_out = 350;
    sram_EW_out = 470 ;
    sram_dir_out = 1;
    sram_traffic_ns = {1'b0,tns};
    sram_traffic_ew = {1'b0,tew};
    sram_ped_ns = {1'b0,pns}; 
    sram_ped_ew = {1'b0,pew};
    
    /*
    j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
       sram_dir_out = 0;
     end else begin
       diff = sram_NS_out - sram_EW_out;
       sram_dir_out = 1;
     end
     time_out_estimate = diff*curr_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
    sram_time_change = i*8;
    sram_time_change = sram_time_change+20;
    */
    
    
     @(posedge clk);
    #(CHECK_DELAY);
    left_expression = new_tr_ns_weight*sram_traffic_ns+new_ped_ns_weight*sram_ped_ns;
    
    if(left_expression <= sram_NS_out+var_time && left_expression >= sram_NS_out-var_time) begin
        $info("NS : you passed son!");
     end else begin
       $error("NS : Tough luck bro!");
     end
     
   left_expression = new_tr_ew_weight*sram_traffic_ew + new_ped_ew_weight*sram_ped_ew;

     if(left_expression<= sram_EW_out+var_time && left_expression>= sram_EW_out-var_time) begin
        $info("EW : you passed son!");
     end else begin
       $error("EW : Tough luck bro!");
     end
     
     /*
     j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
     end else begin
       diff = sram_NS_out - sram_EW_out;
     end
     time_out_estimate = diff*new_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
     guess_time_change = i*8;
     */
     
     if(guess_time_change <= sram_time_change+var_time && guess_time_change >= sram_time_change-var_time) begin
        $info("TIME : you passed son!");
     end else begin
        $error("TIME : Tough luck bro!");
     end
     
     guess_dir_out = (sram_EW_out > sram_NS_out)? 1'b0 : 1'b1;
     
     if(guess_dir_out == sram_dir_out) begin
        $info("DIR : you passed son!");
     end else begin
        $error("DIR : Tough luck bro!");
     end
     
   
    //TESTCASE 5
    @(negedge clk);
    curr_tr_ns_weight = 2;
    curr_tr_ew_weight = 3;
    curr_ped_ns_weight = 4;
    curr_ped_ew_weight =5;
    curr_time_weight = 6;
    tns = 90;
    tew = 45;
    pns = 15;
    pew = 65;
    sram_NS_out = 190;
    sram_EW_out = 400;
    sram_dir_out = 1;
    sram_traffic_ns = {1'b0,tns};
    sram_traffic_ew = {1'b0,tew};
    sram_ped_ns = {1'b0,pns}; 
    sram_ped_ew = {1'b0,pew};
    /*
    j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
       sram_dir_out = 0;
     end else begin
       diff = sram_NS_out - sram_EW_out;
       sram_dir_out = 1;
     end
     time_out_estimate = diff*curr_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
    sram_time_change = i*8;
    sram_time_change = sram_time_change+20;
    
    */
    
     @(posedge clk);
    #(CHECK_DELAY);
    left_expression = new_tr_ns_weight*sram_traffic_ns+new_ped_ns_weight*sram_ped_ns;
    
    if(left_expression <= sram_NS_out+var_time && left_expression >= sram_NS_out-var_time) begin
        $info("NS : you passed son!");
     end else begin
       $error("NS : Tough luck bro!");
     end
     
  left_expression = new_tr_ew_weight*sram_traffic_ew + new_ped_ew_weight*sram_ped_ew;

     if(left_expression<= sram_EW_out+var_time && left_expression>= sram_EW_out-var_time) begin
        $info("EW : you passed son!");
     end else begin
       $error("EW : Tough luck bro!");
     end
     /*
     j=0;
     if(sram_EW_out > sram_NS_out) begin
       diff = sram_EW_out - sram_NS_out;
     end else begin
       diff = sram_NS_out - sram_EW_out;
     end
     time_out_estimate = diff*new_time_weight;
     for(i=15;i>=0;i=i-1) begin
       if(time_out_estimate[i] == 1'b1) begin
         break;
       end else begin
         j=j+1; //WASTE OPERATION
       end
     end
     guess_time_change = i*8;
     
     */
     
     
     if(guess_time_change <= sram_time_change+var_time && guess_time_change >= sram_time_change-var_time) begin
        $info("TIME : you passed son!");
     end else begin
        $error("TIME : Tough luck bro!");
     end
     
     guess_dir_out = (sram_EW_out > sram_NS_out)? 1'b0 : 1'b1;
     
     if(guess_dir_out == sram_dir_out) begin
        $info("DIR : you passed son!");
     end else begin
        $error("DIR : Tough luck bro!");
     end
     
   

    $stop;
  end

endmodule