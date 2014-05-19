// $Id: $
// File name:   controller.sv
// Created:     2/19/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Controller Unit For Averager

module controller
( 
  input wire clk,
  input wire n_reset,
  input wire dr,
  input wire overflow,
  output reg cnt_up,
  output reg modwait,
  output reg [1:0] op,
  output reg [3:0] src1,
  output reg [3:0] src2,
  output reg [3:0] dest,
  output reg err
);

typedef enum bit[3:0]{IDLE,EIDLE,STORE,SORT1,SORT2,SORT3,SORT4,ADD1,ADD2,ADD3} state_type;
state_type state,next_state;
//reg tempreg;
always @(posedge clk, negedge n_reset) begin
  if(n_reset == 1'b0)begin
    state <= IDLE;
  end else begin
    state <= next_state;
  end
  
end

//assign modwait = tempreg;

always_comb begin
  cnt_up = 1'b0;
  modwait =1'b0;//tempreg = 1'b0;
  err = 1'b0;
  src1 = 4'b0000;
  src2 = 4'b0000;
  dest = 4'b0000;
  op = 2'b00;
  case(state)
      IDLE: begin
        cnt_up = 1'b0;
        modwait =1'b0;//tempreg = 1'b0;
        err = 1'b0;
        if(dr) begin
           next_state = STORE;
        end else begin
           next_state = IDLE;
        end
      end
      EIDLE: begin
        cnt_up = 1'b0;
        modwait =1'b0;//tempreg = 1'b0;
        err = 1'b1;
        op = 2'b00;
        if(dr) begin
          next_state = STORE;
        end else begin
          next_state = EIDLE;
        end
      end
      STORE: begin
        cnt_up = 1'b0;
        modwait =1'b1;//tempreg = 1'b1;
        err = 1'b0;
        src1 = 4'b0000;
        op = 2'b10;
        err = 1'b0;
        dest = 4'b0101;
        
        if(dr) begin
          next_state = SORT1;
        end else begin
          next_state = EIDLE;
        end
      end
      SORT1: begin
        cnt_up = 1'b1;
        modwait =1'b0;//tempreg = 1'b1;
        err = 1'b0;
        src1 = 4'b0010;
        dest = 4'b0001;
        op = 2'b01;
        next_state = SORT2;
      end
      SORT2: begin
        cnt_up = 1'b0;
        modwait =1'b1;//tempreg = 1'b1;
        err = 1'b0;
        src1 = 4'b0011;
        dest = 4'b0010;
        op = 2'b01;
        next_state = SORT3;
      end
      SORT3: begin
        cnt_up = 1'b0;
        modwait =1'b1;//tempreg = 1'b1;
        err = 1'b0;
        src1 = 4'b0100;
        dest = 4'b0011;
        op = 2'b01;
        next_state = SORT4;
      end
      SORT4: begin
        cnt_up = 1'b0;
        modwait =1'b1;//tempreg = 1'b1;
        err = 1'b0;
        src1 = 4'b0101;
        dest = 4'b0100;
        op = 2'b01;
        next_state = ADD1;
      end
      
      ADD1: begin
        cnt_up = 1'b0;
        modwait =1'b1;//tempreg= 1'b1;
        err = 1'b0;
        src1 = 4'b0001;
        src2 = 4'b0010;
        dest = 4'b0110;
        op = 2'b11;
        if(overflow) begin
          next_state = EIDLE;
        end else begin
          next_state = ADD2;
        end
      end
        
      ADD2: begin
        cnt_up = 1'b0;
        modwait =1'b1;//tempreg = 1'b1;
        err = 1'b0;
        src1 = 4'b0100;
        src2 = 4'b0011;
        dest = 4'b0111;
        op = 2'b11;
        if(overflow) begin
          next_state = EIDLE;
        end else begin
          next_state = ADD3;
        end
      end
          
      ADD3: begin
        cnt_up = 1'b0;
        modwait =1'b1;//tempreg = 1'b1;
        err = 1'b0;
        src1 = 4'b0110;
        src2 = 4'b0111;
        dest = 4'b0000;
        op = 2'b11;
        if(overflow) begin
          next_state = EIDLE;
        end else begin
          next_state = IDLE;
        end
      end
      default: next_state = IDLE;
  endcase
end

endmodule