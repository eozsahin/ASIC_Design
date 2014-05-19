// $Id: $
// File name:   flex_stp_sr.sv
// Created:     2/11/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Flexible and Scalable Serial to Parallel shift register design

module flex_stp_sr
#(
  parameter NUM_BITS = 4,
  parameter SHIFT_MSB = 1
)
(
  input wire clk,n_rst,shift_enable,serial_in,
  output reg [NUM_BITS-1:0] parallel_out
);

int x;
always_ff @(posedge clk,negedge n_rst) begin
  
 if(n_rst == 1'b0)begin
      for(x=0;x<NUM_BITS;x=x+1)begin
          parallel_out[x] =1'b1;
      end
 end else begin
   if(shift_enable == 1'b1)begin
      if(SHIFT_MSB)begin
          //parallel_out <= {serial_in,parallel_out[(NUM_BITS-2):0]};
	parallel_out = {parallel_out[(NUM_BITS-2):0],serial_in};
      end else begin
          //parallel_out <= {parallel_out[(NUM_BITS-1):1],serial_in};
	parallel_out = {serial_in,parallel_out[(NUM_BITS-1):1]};
      end
   end  
 end       
        
end

endmodule
