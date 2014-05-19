// $Id: sensor_b.sv,v 1.1 2014/01/31 18:35:03 mg137 Exp $
// File name:   sensor_b.sv
// Created:     1/31/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Behavioral style sensor error detector


module sensor_b
(
  input wire [3:0] sensors,
  output reg error
);

always @ * begin
    error=0;
    if(sensors[0] == 1'b1) begin
      error=1;
    end else if (sensors[1] == 1'b1  && sensors[2] == 1'b1) begin
      error=1;
    end else if (sensors[1] == 1'b1 && sensors[3] == 1'b1) begin
      error=1;
    end
  
end

endmodule