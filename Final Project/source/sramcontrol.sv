// $Id: $
// File name:   control.sv
// Created:     4/26/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: sram controller

module sramcontrol(
  input wire clk,
  input wire n_rst,
  //inputs from sram
  input wire [15:0] s_trafficIn, // input format: 00 - 7bits of NS - 7 bits of EW 
  input wire [15:0] s_pedIn, //input format: 00 - 7 bits of Ns - 7 bits of EW
  input wire [15:0] s_NSout,  //input format 00 - 14 bits of NSout
  input wire [15:0] s_EWout, //input format 00 - 14 bits of NSout
  input wire [15:0] s_dir_time, //input format 00000000 s_dir_time[8] = dir, s_dir_time[7:0] = dTime
  //outputs to sram
  output reg read_enable,
  output reg write_enable,
  output reg [11:0] s_addr,
  //these values are writen to sram
  output reg [15:0] w_trafficIn,  
  output reg [15:0] w_pedIn, 
  output reg [15:0] w_NSout,  
  output reg [15:0] w_EWout, 
  output reg [15:0] w_dir_time,
  
  //inputs from NN
  input wire read,
  input wire write,
  input wire [11:0] addr, 
  
  input wire [6:0] iTNS,
  input wire [6:0] iTEW,
  input wire [6:0] iPNS,
  input wire [6:0] iPEW,
  input wire [13:0] iNSout,
  input wire [13:0] iEWout,
  input wire idir,
  input wire [7:0] idTime,
  //outputs to Calibrator
  output reg [6:0] TNS,
  output reg [6:0] TEW,
  output reg [6:0] PNS,
  output reg [6:0] PEW,
  output reg [13:0] NSout,
  output reg [13:0] EWout,
  output reg dir,
  output reg [7:0] dTime
  );
  
  always @ (posedge clk, negedge n_rst) begin
  if(n_rst == 0) begin
    read_enable <= 0;
    write_enable <= 0;
    s_addr <= 0;
  end else begin
    read_enable <= read;
    write_enable <= write;
    s_addr <= addr;
    end
  end
  
  always_comb begin
    //calibrator outputs
    TNS = s_trafficIn[13:7];
    TEW = s_trafficIn[6:0];
    PNS = s_pedIn[13:7];
    PEW = s_pedIn[6:0];
    NSout = s_NSout[13:0];
    EWout = s_NSout[13:0];
    dir = s_dir_time[8];
    dTime = s_dir_time[7:0]; 
    
    w_trafficIn = {2'b0, iTNS, iTEW};
    w_pedIn = {2'b0, iPNS, iPEW};
    w_NSout = {2'b0, iNSout};
    w_EWout = {2'b0, iEWout};
    w_dir_time = {0, idir, idTime};
    
  end
  
endmodule