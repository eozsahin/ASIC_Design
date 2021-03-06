// $Id: $
// File name:   neuromorpher_chip.sv
// Created:     4/25/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Upper wrapper file for neuromorpher chip

module neuromorpher_chip
(
  //inputs
  input wire clk,
  input wire n_rst,
  input wire car_n,//traffic north enable
  input wire car_s,//traffic south enable
  input wire car_e,//traffic east enable
  input wire car_w,//traffic west enable
  input wire ped_n, //ped north enable
  input wire ped_s, //ped south enable
  input wire ped_e, //ped east enable
  input wire ped_w, //ped west enable
  input wire [3:0] weather, //weather input
  input wire emergency, //emergency for the system
  //outputs
  output wire [1:0] tr_out_n,
  output wire [1:0] tr_out_s,
  output wire [1:0] tr_out_e,
  output wire [1:0] tr_out_w,
  output wire [1:0] ped_out_n,
  output wire [1:0] ped_out_s,
  output wire [1:0] ped_out_e,
  output wire [1:0] ped_out_w,
  
  
  //SRAM STUFF
  input wire [15:0] s_trafficIn, // input format: 00 - 7bits of NS - 7 bits of EW 
  input wire [15:0] s_pedIn, //input format: 00 - 7 bits of Ns - 7 bits of EW
  input wire [15:0] s_NSout,  //input format 00 - 14 bits of NSout
  input wire [15:0] s_EWout, //input format 00 - 14 bits of NSout
  input wire [15:0] s_dir_time, //input format 00000000 s_dir_time[8] = dir, s_dir_time[7:0] = dTime
  
  output reg read_enable,
  output reg write_enable,
  output reg [11:0] s_addr, 
  
  output reg [15:0] w_trafficIn,  
  output reg [15:0] w_pedIn, 
  output reg [15:0] w_NSout,  
  output reg [15:0] w_EWout, 
  output reg [15:0] w_dir_time
);

reg clear;

//car counter
reg tr_flag_n;
reg tr_flag_s;
reg tr_flag_e;
reg tr_flag_w;

//ped counter
reg ped_flag_n;
reg ped_flag_s;
reg ped_flag_w;
reg ped_flag_e;

//sync outs
reg [3:0] sync_weather;
reg sync_emergency;

//count wires
reg [5:0] tr_n_count,tr_s_count, tr_e_count, tr_w_count;
reg [5:0] ped_n_count,ped_s_count, ped_e_count, ped_w_count;

//score wires
reg [6:0] tr_score_ns,tr_score_ew;
reg [6:0] ped_score_ns,ped_score_ew;
reg [6:0] weather_score;

//neural network outputs
reg p_dir;
reg [7:0] time_change;

//down counter
reg reset;
reg start;
reg delta;
reg [7:0] startVal; 
reg signed [7:0] deltaVal;  
reg [7:0] outVal;
reg pulse;


//new_calibrator
reg signed [4:0] curr_tr_ns_weight, curr_tr_ew_weight, curr_ped_ns_weight, curr_ped_ew_weight, curr_time_weight;
reg [6:0] tns, tew, pns, pew;
reg signed [13:0] sram_NS_out,sram_EW_out;
reg sram_dir_out;
reg signed [7:0] sram_time_change;
  //outputs to sram control 
reg ready;
reg [11:0] addr;
reg SRAM_enable;
  //output to NN
reg signed [4:0] new_tr_ns_weight,new_tr_ew_weight,new_ped_ns_weight,new_ped_ew_weight,new_time_weight;
reg dir_out;

reg calib_enable;


reg[4:0] traffic_ns_weight, traffic_ew_weight, ped_ns_weight, ped_ew_weight,time_weight;


//outputLogic 
  reg dir;
  reg [7:0] countVal;
  reg [1:0] trafficN; // 00 RED
  reg [1:0] trafficS; // 01 YELLOW
  reg [1:0] trafficE; // 10 GREEN
  reg [1:0] trafficW;
  reg [1:0] pedN;
  reg [1:0] pedS;
  reg [1:0] pedE;
  reg [1:0] pedW;
  

  reg [6:0] iTNS,iTEW,iPNS,iPEW;
  reg [13:0] iNS_OUT, iEW_OUT;

//car counters for each directions
car_counter car_count_n
(
  .n_rst(n_rst),
  .clk(clk),
  .clear(clear),
  .count_enable(car_n),
  .count_out(tr_n_count),
  .r_flag(tr_flag_n)
);

car_counter car_count_s
(
  .n_rst(n_rst),
  .clk(clk),
  .clear(clear),
  .count_enable(car_s),
  .count_out(tr_s_count),
  .r_flag(tr_flag_s)
);

car_counter car_count_e
(
  .n_rst(n_rst),
  .clk(clk),
  .clear(clear),
  .count_enable(car_e),
  .count_out(tr_e_count),
  .r_flag(tr_flag_e)
);

car_counter car_count_w
(
  .n_rst(n_rst),
  .clk(clk),
  .clear(clear),
  .count_enable(car_w),
  .count_out(tr_w_count),
  .r_flag(tr_flag_w)
);

//ped counter for each direction
ped_counter ped_count_n
(
  .clk(clk),
  .n_rst(n_rst),
  .clear(clear),
  .count_enable(ped_n),
  .count_out(ped_n_count),
  .r_flag(ped_flag_n)
);

ped_counter ped_count_s
(
  .clk(clk),
  .n_rst(n_rst),
  .clear(clear),
  .count_enable(ped_s),
  .count_out(ped_s_count),
  .r_flag(ped_flag_s)
);

ped_counter ped_count_e
(
  .clk(clk),
  .n_rst(n_rst),
  .clear(clear),
  .count_enable(ped_e),
  .count_out(ped_e_count),
  .r_flag(ped_flag_e)
);

ped_counter ped_count_w
(
  .clk(clk),
  .n_rst(n_rst),
  .clear(clear),
  .count_enable(ped_w),
  .count_out(ped_w_count),
  .r_flag(ped_flag_w)
);



//synchronizers
syncEmergency sync_e
(
  .clk(clk),
  .n_rst(n_rst),
  .e_async_in(emergency),
  .e_sync_out(sync_emergency)
);

syncWeather sync_w
(
  .clk(clk),
  .n_rst(n_rst),
  .w_async_in(weather),
  .w_sync_out(sync_weather)
);

//scoring modules
/*
score_car traffic_score
(
  .n_rst(n_rst),
  .n_count(tr_n_count),
  .s_count(tr_s_count),
  .e_count(tr_e_count),
  .w_count(tr_w_count),
  .tr_score_ns(tr_score_ns),
  .tr_score_ew(tr_score_ew)
);
*/
scoreAdd traffic_scoreNS(
  .score1(tr_n_count),
  .score2(tr_s_count),
  .outScore(tr_score_ns)
);

scoreAdd traffic_scoreEW(
  .score1(tr_e_count),
  .score2(tr_w_count),
  .outScore(tr_score_ew)
  );
/*
score_pedestrian pedestrian_score
(
  .n_rst(n_rst),
  .n_count(ped_n_count),
  .s_count(ped_s_count),
  .e_count(ped_s_count),
  .w_count(ped_w_count),
  .ped_score_ns(ped_score_ns),
  .ped_score_ew(ped_score_ew)
);
*/
scoreAdd ped_scoreNS(
  .score1(ped_n_count),
  .score2(ped_s_count),
  .outScore(ped_score_ns)
);

scoreAdd ped_scoreEW(
  .score1(ped_e_count),
  .score2(ped_w_count),
  .outScore(ped_score_ew)
  );


score_weather weather_score_
(
  .w_in(weather),
  .w_out(weather_score)
);

neural_network neural_network
(
  .clk(clk),
  .n_rst(n_rst),
  .traffic_score_ns(tr_score_ns),
  .traffic_score_ew(tr_score_ew),
  .ped_score_ns(ped_score_ns),
  .ped_score_ew(ped_score_ew),
  .traffic_ns_weight(traffic_ns_weight),
  .traffic_ew_weight(traffic_ew_weight),
  .ped_ns_weight(ped_ns_weight),
  .ped_ew_weight(ped_ew_weight),
  .time_weight(time_weight),
  
  .calib_enable(calib_enable),
  .dir_out(p_dir), //sram
  .time_change(time_change),//sram
  .write_enable(write_enable), //goes to sram
  .TNS(iTNS),
  .TEW(iTEW),
  .PNS(iPNS),
  .PEW(iPEW),
  .NS_OUT(iNS_OUT),
  .EW_OUT(iEW_OUT),
  //notsram
  .old_tns_weight(curr_tr_ns_weight),
  .old_tew_weight(curr_tr_ew_weight),
  .old_pns_weight(curr_ped_ns_weight),
  .old_pew_weight(curr_ped_ew_weight),
  .old_time_weight(curr_time_weight)
);
  
  
  sramcontrol SRAMCONTROL__(
  .clk(clk),
  .n_rst(n_rst),
  //inputs from sram
  .s_trafficIn(), // input format: 00 - 7bits of NS - 7 bits of EW 
  .s_pedIn(), //input format: 00 - 7 bits of Ns - 7 bits of EW
  .s_NSout(),  //input format 00 - 14 bits of NSout
  .s_EWout(), //input format 00 - 14 bits of NSout
  .s_dir_time(), //input format 00000000 s_dir_time[8] = dir, s_dir_time[7:0] = dTime
  //outputs to sram
  .read_enable(),
  .write_enable(write_enable),
  .s_addr(),
  //these values are writen to sram
  .w_trafficIn(),  
  .w_pedIn(), 
  .w_NSout(),  
  .w_EWout(), 
  .w_dir_time(),
  
  //inputs from NN
  .read(),
  .write(),
  .addr(addr), 
  
  .iTNS(iTNS),
  .iTEW(iTEW),
  .iPNS(iPNS),
  .iPEW(iPEW),
  .iNSout(iNS_OUT),
  .iEWout(iEW_OUT),
  .idir(p_dir),
  .idTime(time_change),
  //outputs to Calibrator
  .TNS(tns),
  .TEW(tew),
  .PNS(pns),
  .PEW(pew),
  .NSout(sram_NS_out),
  .EWout(sram_EW_out),
  .dir(sram_dir_out),
  .dTime(sram_time_change)
  );

  new_calibrator new_calibrator (
    //inputs
    .clk(clk),
    .n_rst(n_rst),
    .enable(calib_enable),
    .curr_tr_ns_weight(curr_tr_ns_weight),
    .curr_tr_ew_weight(curr_tr_ew_weight),
    .curr_ped_ns_weight(curr_ped_ns_weight),
    .curr_ped_ew_weight(curr_ped_ew_weight),
    .curr_time_weight(curr_time_weight),
    //from sram
    .tns(tns), //
    .tew(tew), // 
    .pns(pns), // 
    .pew(pew), // 
    .sram_NS_out(sram_NS_out),// 
    .sram_EW_out(sram_EW_out),// 
    .sram_dir_out(sram_dir_out),// 
    .sram_time_change(sram_time_change),//
    //outputs
    .ready(), //goRead
    .SRAM_enable(SRAM_enable), //read_enable
    .new_tr_ns_weight(traffic_ns_weight),
    .new_tr_ew_weight(traffic_ew_weight),
    .new_ped_ns_weight(ped_ns_weight),
    .new_ped_ew_weight(ped_ew_weight),
    .new_time_weight(time_weight),
    .dir_out(dir_out)
    );



downCounter downCount
(
  .clk(clk), //ADD IN CLOCK DIVIDER DUMMY
  .n_rst(n_rst),
  .delta(delta),
  .deltaVal(deltaVal),
  .start(start),
  .startVal(startVal),
  .outVal(outVal),
  .pulse(pulse)
);

decide decision_block
(
  //inputs
  .clk(clk),
  .n_rst(n_rst),
  .weatherScore(weather_score),
  .dTime(time_change),
  .halfPulse(halfPulse),
  .outVal(outVal),
  //outputs
  .delta(delta),
  .deltaVal(deltaVal),
  .start(start),
  .startVal(startVal)
);

//sram
//append and sram control modules

outputLogic outLog
(
  .clk(clk), 
  .n_rst(n_rst), 
  .emergency(sync_emergency), 
  .dir(p_dir), 
  .countVal(countVal), 
  .trafficN(tr_out_n), 
  .trafficS(tr_out_s), 
  .trafficE(tr_out_e), 
  .trafficW(tr_out_w), 
  .pedN(ped_out_n), 
  .pedS(ped_out_s), 
  .pedE(ped_out_e), 
  .pedW(ped_out_w),
  .clear(clear)
);


addrControl addrController(
  .clk(clk),
  .n_rst(n_rst),
  .goRead(ready),
  .goWrite(),
  .addr(addr)
  );
  
  
  
  
  
  
  
  //additions
   
 


endmodule