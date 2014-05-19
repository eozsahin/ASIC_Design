// $Id: $
// File name:   downCounter.sv
// Created:     4/9/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: counts up or down

module downCounter(
  input wire clk,
  input wire n_rst,
  input wire start, //start pulse received from the decision block
  input wire delta, //pulse recieved to make change to time
  input wire[7:0] startVal, //value to start counting down from 
  input wire signed [7:0] deltaVal,  //value change time by
  output reg[7:0] outVal, //current output
  output reg pulse //pulse to send to decision block for half time
);
  reg signed [8:0] signStart;
  reg signed [8:0] signCount;
  reg started;
  
  reg signed [8:0] half;
  
  always_comb begin
    signStart = {0, startVal};
    outVal = (signCount <= 0) ? 0 : signCount[7:0];
  end
  
  always @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      signCount <= 0;
      started <= 0;
      half <= 0;
    end else if(start == 1) begin
      started <= 1;
      signCount <= signStart;
      half <= signStart / 2;
    end else if(delta == 1) begin
      signCount <= signCount + deltaVal;
    end else if(started == 1) begin
      signCount <= signCount - 1;
    end else if(signCount <= 0 && started == 1) begin
      started <= 0;
      signCount <= 0;
    end
  end
  
  always_comb begin
    pulse = (signCount == half) ? 1 : 0;
  end
      
endmodule