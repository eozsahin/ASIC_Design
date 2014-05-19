// $Id: $
// File name:   tb_i2c_slave.sv
// Created:     3/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench For Master


`timescale 1ns / 100ps

module tb_i2c_slave();
  
  
  parameter SLAVE_CLK_PERIOD = 10;
  parameter SCL_PERIOD = 300;
  parameter SCL_WAIT = SCL_PERIOD/6;
  
  reg s_clk, n_rst; //sda_out;
  wire scl, sda_in, fifo_empty, fifo_full;
  wire sda_out;
  reg write_enable;
  reg [7:0] write_data;
  reg m_scl_out;
  wire m_scl_in, m_sda_in;
  reg m_sda_out;
  reg [7:0] m_store;
  

  
  i2c_bus BUS (
    .scl_read({scl, m_scl_in}),
    .scl_write({1'bz, m_scl_out}),
    .sda_read({sda_in, m_sda_in}),
    .sda_write({sda_out, m_sda_out})
  );
  
  i2c_slave SLV (
    .clk(s_clk),
    .n_rst(n_rst),
    .scl(scl),
    .sda_in(sda_in),
    .sda_out(sda_out),
    .write_enable(write_enable),
    .write_data(write_data),
    .fifo_empty(fifo_empty),
    .fifo_full(fifo_full)
  );
  
  always begin
    s_clk = 1'b1;
    #(SLAVE_CLK_PERIOD/2);
    s_clk = 1'b0;
    #(SLAVE_CLK_PERIOD/2);
  end
  
  always begin
    #(5) //offset
    m_scl_out = 1'b1;
    #(SCL_PERIOD/3);
    m_scl_out = 1'b0;
    #(SCL_PERIOD/3);
    #(SCL_PERIOD/3 - 5);
  end
  
  
  //correct address: 1111000
  initial begin
    //initialized
    m_sda_out = 1; //idle value
    write_enable = 0;
    write_data = '0;
    
    //reset
    n_rst = 0;
    #(SLAVE_CLK_PERIOD * 5);
    n_rst = 1;
    
    //CHECK_ADDRESS
    //send start
    @(posedge m_scl_out)
    #(SCL_WAIT);
    m_sda_out = 0;
    //send wrong address
    @(negedge m_scl_out) //end of start
    m_sda_out = 1;
    @(negedge m_scl_out) //1
    @(negedge m_scl_out)//2
    @(negedge m_scl_out)//3
    @(negedge m_scl_out)//4
    @(negedge m_scl_out)//5
    @(negedge m_scl_out)//6
    @(negedge m_scl_out)//7
    @(negedge m_scl_out)//8
    
    //check for NACK
    @(posedge m_scl_in);
    if(m_sda_in) begin
      $info("Test case 1: check addres: PASSED");
    end else begin
      $error("Test case 1: check address: FAILED");
    end
    
    //Check mode
    //send start
    @(negedge m_scl_out)
    m_sda_out = 1;
    @(posedge m_scl_out)
    #(SCL_WAIT);
    m_sda_out = 0;
    //send correct address
    @(negedge m_scl_out);
    m_sda_out = 1;
    @(negedge m_scl_out); //1
    @(negedge m_scl_out); //2
    @(negedge m_scl_out); //3
    @(negedge m_scl_out); //4
    m_sda_out = 0;
    @(negedge m_scl_out); //5
    @(negedge m_scl_out); //6
    @(negedge m_scl_out); //7
    //wrong read/write
    @(negedge m_scl_out); //8
    m_sda_out = 1;
    
    //check for NACK
    @(posedge m_scl_in);
    if(m_sda_in) begin
      $info("Test case 2: check mode: PASSED");
    end else begin
      $error("Test case 2: check mode: FAILED");
    end
    
    //load in data:
    @(negedge m_scl_out);
    write_data = 8'b10101010;
    @(negedge s_clk);
    write_enable = 1;
    @(negedge s_clk);
    write_data = 8'b01010101;
    @(negedge s_clk);
    write_data = 8'b10101010;
    @(negedge s_clk);
    write_data = 8'b01010101;
    @(negedge s_clk);
    write_enable = 0;
    
    //transmit ending in nack
    
    @(posedge m_scl_out)
    #(SCL_WAIT);
    m_sda_out = 0;
    //send correct address
    @(negedge m_scl_out);
    m_sda_out = 1;
    @(negedge m_scl_out); //1
    @(negedge m_scl_out); //2
    @(negedge m_scl_out); //3
    @(negedge m_scl_out); //4
    m_sda_out = 0;
    @(negedge m_scl_out); //5
    @(negedge m_scl_out); //6
    @(negedge m_scl_out); //7
    //right read/write
    m_sda_out = 1;
    @(negedge m_scl_out); //8
    m_sda_out = 1;
    
    //check for ACK
    @(posedge m_scl_in);
    if(!m_sda_in) begin
      $info("Test case 3: right address and mode: PASSED");
    end else begin
      $error("Test case 3: right address and mode: FAILED");
    end
    
    @(posedge m_scl_out)
    m_store[7] = m_sda_in;
    @(posedge m_scl_out)
    m_store[6] = m_sda_in;
    @(posedge m_scl_out)
    m_store[5] = m_sda_in;
    @(posedge m_scl_out)
    m_store[4] = m_sda_in;
    @(posedge m_scl_out)
    m_store[3] = m_sda_in;
    @(posedge m_scl_out)
    m_store[2] = m_sda_in;
    @(posedge m_scl_out)
    m_store[1] = m_sda_in;
    @(posedge m_scl_out)
    m_store[0] = m_sda_in;
    @(negedge m_scl_out)
    if(m_store == 8'b10101010) begin
      $info("Test case 4: data received: PASSED");
    end else begin
      $error("Test case 4: data received: FAILED");
    end
    
    //@(negedge m_scl_out)
    m_sda_out = 1;
    @(negedge m_scl_out)/////////////////////////////////////////////////////
    @(posedge m_scl_out)
    #(SCL_WAIT)
    m_sda_out = 0;
    @(negedge m_scl_out)
    m_sda_out = 1;
     @(negedge m_scl_out); //1
    @(negedge m_scl_out); //2
    @(negedge m_scl_out); //3
    @(negedge m_scl_out); //4
    m_sda_out = 0;
    @(negedge m_scl_out); //5
    @(negedge m_scl_out); //6
    @(negedge m_scl_out); //7
    //right read/write
    m_sda_out = 1;
    @(negedge m_scl_out); //8
    m_sda_out = 1;
    
    //check for ACK
    @(posedge m_scl_in);
    if(!m_sda_in) begin
      $info("Test case 5: right address and mode: PASSED");
    end else begin
      $error("Test case 5: right address and mode: FAILED");
    end
    
    @(posedge m_scl_out)
    m_store[7] = m_sda_in;
    @(posedge m_scl_out)
    m_store[6] = m_sda_in;
    @(posedge m_scl_out)
    m_store[5] = m_sda_in;
    @(posedge m_scl_out)
    m_store[4] = m_sda_in;
    @(posedge m_scl_out)
    m_store[3] = m_sda_in;
    @(posedge m_scl_out)
    m_store[2] = m_sda_in;
    @(posedge m_scl_out)
    m_store[1] = m_sda_in;
    @(posedge m_scl_out)
    m_store[0] = m_sda_in;
    @(negedge m_scl_out)
    if(m_store == 8'b10101010) begin
      $info("Test case 6: data received: PASSED");
    end else begin
      $error("Test case 6: data received: FAILED");
    end
    
    m_sda_out = 0;
    @(negedge m_scl_out)
    m_sda_out = 1;
    
    @(posedge m_scl_out)
    m_store[7] = m_sda_in;
    @(posedge m_scl_out)
    m_store[6] = m_sda_in;
    @(posedge m_scl_out)
    m_store[5] = m_sda_in;
    @(posedge m_scl_out)
    m_store[4] = m_sda_in;
    @(posedge m_scl_out)
    m_store[3] = m_sda_in;
    @(posedge m_scl_out)
    m_store[2] = m_sda_in;
    @(posedge m_scl_out)
    m_store[1] = m_sda_in;
    @(posedge m_scl_out)
    m_store[0] = m_sda_in;
    @(negedge m_scl_out)
    if(m_store == 8'b01010101) begin
      $info("Test case 7: data received: PASSED");
    end else begin
      $error("Test case 7: data received: FAILED");
    end
    
    m_sda_out = 1;
    @(negedge m_scl_out)
    m_sda_out = 0;
    @(posedge m_scl_out)
    #(SCL_WAIT)
    m_sda_out = 1;
    
    #(SCL_PERIOD * 10)
    if(m_sda_in == 1) begin
      $info("Test case 8: stop: PASSED");
    end else begin
      $error("Test case 8: stop: FAILED");
    end
    
    
    //post stop recovery
    @(negedge m_scl_out)
    m_sda_out = 1;
    @(posedge m_scl_out)
    #(SCL_WAIT)
    m_sda_out = 0;
    @(negedge m_scl_out)
    m_sda_out = 1;
     @(negedge m_scl_out); //1
    @(negedge m_scl_out); //2
    @(negedge m_scl_out); //3
    @(negedge m_scl_out); //4
    m_sda_out = 0;
    @(negedge m_scl_out); //5
    @(negedge m_scl_out); //6
    @(negedge m_scl_out); //7
    //right read/write
    m_sda_out = 1;
    @(negedge m_scl_out); //8
    m_sda_out = 1;
    
    //check for ACK
    @(posedge m_scl_in);
    if(!m_sda_in) begin
      $info("Test case 9: right address and mode: PASSED");
    end else begin
      $error("Test case 9: right address and mode: FAILED");
    end
    
    @(posedge m_scl_out)
    m_store[7] = m_sda_in;
    @(posedge m_scl_out)
    m_store[6] = m_sda_in;
    @(posedge m_scl_out)
    m_store[5] = m_sda_in;
    @(posedge m_scl_out)
    m_store[4] = m_sda_in;
    @(posedge m_scl_out)
    m_store[3] = m_sda_in;
    @(posedge m_scl_out)
    m_store[2] = m_sda_in;
    @(posedge m_scl_out)
    m_store[1] = m_sda_in;
    @(posedge m_scl_out)
    m_store[0] = m_sda_in;
    @(negedge m_scl_out)
    if(m_store == 8'b01010101) begin
      $info("Test case 10: data received: PASSED");
    end else begin
      $error("Test case 10: data received: FAILED");
    end
    
    //@(negedge m_scl_out)
    m_sda_out = 0;
    @(negedge m_scl_out)
    m_sda_out = 1;
    
    @(posedge m_scl_out)
    m_store[7] = m_sda_in;
    @(posedge m_scl_out)
    m_store[6] = m_sda_in;
    @(posedge m_scl_out)
    m_store[5] = m_sda_in;
    @(posedge m_scl_out)
    m_store[4] = m_sda_in;
    @(posedge m_scl_out)
    m_store[3] = m_sda_in;
    @(posedge m_scl_out)
    m_store[2] = m_sda_in;
    @(posedge m_scl_out)
    m_store[1] = m_sda_in;
    @(posedge m_scl_out)
    m_store[0] = m_sda_in;
    @(negedge m_scl_out)
    if(m_store == 8'b10101010) begin
      $info("Test case 11: data received: PASSED");
    end else begin
      $error("Test case 11: data received: FAILED");
    end
    
    //@(negedge m_scl_out)
    m_sda_out = 0;
    @(negedge m_scl_out)
    m_sda_out = 1;
    
    @(posedge m_scl_out)
    m_store[7] = m_sda_in;
    @(posedge m_scl_out)
    m_store[6] = m_sda_in;
    @(posedge m_scl_out)
    m_store[5] = m_sda_in;
    @(posedge m_scl_out)
    m_store[4] = m_sda_in;
    @(posedge m_scl_out)
    m_store[3] = m_sda_in;
    @(posedge m_scl_out)
    m_store[2] = m_sda_in;
    @(posedge m_scl_out)
    m_store[1] = m_sda_in;
    @(posedge m_scl_out)
    m_store[0] = m_sda_in;
    @(negedge m_scl_out)
    if(m_store == 8'b01010101) begin
      $info("Test case 12: data received: PASSED");
    end else begin
      $error("Test case 12: data received: FAILED");
    end
    
    //@(negedge m_scl_out)
    m_sda_out = 1;
    @(negedge m_scl_out)
    @(posedge m_scl_out)
    #(SCL_WAIT)
    m_sda_out = 0;
    
    @(negedge m_scl_out)
    m_sda_out = 1;
     @(negedge m_scl_out); //1
    @(negedge m_scl_out); //2
    @(negedge m_scl_out); //3
    @(negedge m_scl_out); //4
    m_sda_out = 0;
    @(negedge m_scl_out); //5
    @(negedge m_scl_out); //6
    @(negedge m_scl_out); //7
    //right read/write
    m_sda_out = 1;
    @(negedge m_scl_out); //8
    m_sda_out = 1;
    
    //check for ACK
    @(posedge m_scl_in);
    if(!m_sda_in) begin
      $info("Test case 13: right address and mode: PASSED");
    end else begin
      $error("Test case 13: right address and mode: FAILED");
    end
    
    
    @(posedge m_scl_out)
    m_store[7] = m_sda_in;
    @(posedge m_scl_out)
    m_store[6] = m_sda_in;
    @(posedge m_scl_out)
    m_store[5] = m_sda_in;
    @(posedge m_scl_out)
    m_store[4] = m_sda_in;
    @(posedge m_scl_out)
    m_store[3] = m_sda_in;
    @(posedge m_scl_out)
    m_store[2] = m_sda_in;
    @(posedge m_scl_out)
    m_store[1] = m_sda_in;
    @(posedge m_scl_out)
    m_store[0] = m_sda_in;
    @(negedge m_scl_out)
    if(m_store == 8'b01010101) begin
      $info("Test case 14: data received: PASSED");
    end else begin
      $error("Test case 14: data received: FAILED");
    end
    
    
  
  end

  
endmodule
