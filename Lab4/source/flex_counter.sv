// $Id: $
// File name:   flex_counter.sv
// Created:     2/12/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Flexible Counter 

module flex_counter
#(
  parameter NUM_CNT_BITS = 4
)
(
  input wire n_rst,clear,clk,count_enable,
  input wire [NUM_CNT_BITS - 1:0] rollover_val,
  output wire [NUM_CNT_BITS - 1:0] count_out,
  output wire rollover_flag
);

reg [NUM_CNT_BITS-1:0] tmp_cnt;
reg [NUM_CNT_BITS-1:0] tmp_next_cnt;
reg tmp_flag;
reg tmp_next_flag;
int i;

always_ff @(negedge n_rst,posedge clk) begin
  if(n_rst == 1'b0)begin
    tmp_cnt <= '0;
    tmp_flag <= '0;
  end else begin
    tmp_cnt <= tmp_next_cnt;
    tmp_flag <= tmp_next_flag;
  end
  
end


always_comb begin
  tmp_next_flag = '0;
  
  if(clear)begin
      tmp_next_flag = '0;
      tmp_next_cnt = '0;
  end else begin
    if(count_enable == '0) begin
      tmp_next_flag = tmp_flag;
      tmp_next_cnt = tmp_cnt;
    end else begin
      if(count_out == rollover_val)begin
        tmp_next_cnt = 1;
        tmp_next_flag = 0; 
        if(rollover_val == 1)begin
          tmp_next_flag = 1;
        end
      end else if (count_out == rollover_val - 1)begin
          tmp_next_cnt = tmp_cnt + 1;
          tmp_next_flag = 1'b1;
      end else begin
          tmp_next_cnt = tmp_cnt + 1;
          tmp_next_flag = 0;
      end 
     end
   end   
end

assign count_out = tmp_cnt;
assign rollover_flag = tmp_flag;

endmodule