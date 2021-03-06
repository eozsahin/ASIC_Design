// $Id: $
// File name:   decide.sv
// Created:     4/29/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: decision block 

module decide(
  //inputs
  input wire clk, 
  input wire n_rst,
  input wire [6:0] weatherScore, 
  input wire signed [7:0] dTime, //delta time value
  input wire [7:0] outVal, //count value from downCounter
  input wire halfPulse, 
  //outputs
  output reg delta, //delta value enable
  output reg signed [7:0] deltaVal,
  output reg start, //start value enable
  output reg [7:0] startVal
  );

  reg [3:0] state, nextstate;
  parameter [3:0] S0 = 4'h0,
                  S1 = 4'h1,
                  S2 = 4'h2,
                  S3 = 4'h3,
                  S4 = 4'h4,
                  S5 = 4'h5;

  reg[7:0] nstartVal;
  reg signed[7:0] ndeltaVal;

  always @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      state <= S0;
      startVal <= 0;
    end else begin
      state <= nextstate;
      startVal <= nstartVal;
      deltaVal <= ndeltaVal;
    end
  end
  
  
  always_comb begin
    delta = 0;
    ndeltaVal = 8'd0;
    start = 0;
    nstartVal = 8'd0;
    case(state)
      S0: begin //set startVal
        delta = 0;
        ndeltaVal = 0;
        start = 0;
        if(weatherScore < 50) begin
          nstartVal = 70;
        end else if(weatherScore < 70) begin
          nstartVal = 80;
        end else if(weatherScore < 90) begin
          nstartVal = 95;
        end else begin
          nstartVal = 120;
        end 
        nextstate = S1;
      end
      S1: begin //set the start enable to the counter
        delta = 0;
        ndeltaVal = 0;
        start = 1;
        nextstate = S2;
      end
      S2: begin //wait for halfpulse
        delta = 0;
        ndeltaVal = 0;
        start = 0;
        if(halfPulse == 1)
          nextstate = S3;
        else 
          nextstate = S2;
      end
      S3: begin //set the delta time
        delta = 0;
        ndeltaVal = dTime;
        start = 0;
        nextstate = S4;
      end
      S4: begin //set the delta enable
        delta = 1;
        start = 0;
        nextstate = S5;
      end
      S5: begin
        delta = 0;
        start = 0;
        if(outVal == 0)
          nextstate = S0;
        else
          nextstate = S5;
        end
      default: nextstate = S5;
    endcase
    end
endmodule
  
  