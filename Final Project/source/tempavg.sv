module tempavg(quotient,remainder,ready,dividend,divider,start,clk);
   
   input [8:0]  dividend,divider;
   input         start, clk;
   output        quotient,remainder;
   output        ready;

//  """"""""|
//     1011 |  <----  dividend_copy
// -0011    |  <----  divider_copy
//  """"""""|    0  Difference is negative: copy dividend and put 0 in quotient.
//     1011 |  <----  dividend_copy
//  -0011   |  <----  divider_copy
//  """"""""|   00  Difference is negative: copy dividend and put 0 in quotient.
//     1011 |  <----  dividend_copy
//   -0011  |  <----  divider_copy
//  """"""""|  001  Difference is positive: use difference and put 1 in quotient.
//            quotient (numbers above)   


   reg [8:0]    quotient;
   reg [17:0]    dividend_copy, divider_copy, diff;
   wire [8:0]   remainder = dividend_copy[15:0];

   reg [4:0]     _bit; 
   wire ready;
   assign ready = !_bit;
   
   initial _bit = 0;

   always @( posedge clk ) 

     if( ready && start ) begin

        _bit = 9;
        quotient = 0;
        dividend_copy = {9'd0,dividend};
        divider_copy = {1'b0,divider,8'd0};

     end else begin

        diff = dividend_copy - divider_copy;

        quotient = quotient << 1;

        if( !diff[17] ) begin

           dividend_copy = diff;
           quotient[0] = 1'd1;

        end

        divider_copy = divider_copy >> 1;
        _bit = _bit - 1;

     end

endmodule