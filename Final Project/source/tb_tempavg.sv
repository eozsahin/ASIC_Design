`timescale 1ns/10ps


module tb_tempavg();
  
  //inputs 
  reg [8:0] dividend, divider;
  reg start, clk;
  
  //outputs
  reg[8:0] quotient, remainder;
  reg ready;
  
  tempavg avg(quotient, remainder, ready, dividend, divider, start, clk);
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    clk = 1;
    start = 0;
    
    #50
    dividend = 9'd200; //200 / 400
    divider = 9'd4;
    
    #10
    start = 1;
    
    #1000
    start = 0;
    
    #50
    dividend = 9'd300;
    divider = 9'd4;
    
    #100
    start = 1;
    
    #1000
    $stop;
  end
  
endmodule
    
    
    