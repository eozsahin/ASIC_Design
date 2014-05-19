module tb_test();

   reg signed[13:0] in;
   reg signed [13:0] out;


   test teststs(
		in, out);


   initial begin
      in = -14'd1300;

      #20
	in = 14'd1300;



   end


   endmodule