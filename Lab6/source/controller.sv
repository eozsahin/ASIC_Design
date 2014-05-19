// $Id: $
// File name:   controller.sv
// Created:     3/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: controller
module controller (
  input wire clk,
  input wire n_rst,
  input wire stop_found,
  input wire start_found,
  input wire byte_received,
  input wire check_ack,
  input wire ack_done,
  input wire ack_prep,
  input wire rw_mode,
  input wire address_match,
  input wire sda_in,
  output reg rx_enable,
  output reg tx_enable,
  output reg read_enable,
  output reg [1:0] sda_mode,
  output reg load_data
  );
  
  //reg rx_enable;
  //reg tx_enable;
  //reg read_enable;
  //reg [1:0] sda_mode;
  //reg load_data;
  
  
    typedef enum bit[3:0] {IDLE,REC,ADDR_CHK,SLAVE_ACK,SLAVE_NACK,LOAD_DATA,READ_ENABLE,TX_FIFO,MASTER_CHECK_ACK,MASTER_CHECK,MASTER_ACK,MASTER_NACK} state_type;
  state_type state,next_state;
  
always @(posedge clk,negedge n_rst) begin

  if(n_rst == '0) begin
     state <= IDLE;
  end else begin
      state <= next_state;
      
  end
end
  
always_comb begin
    next_state = state;
    rx_enable = 1'b0;
    tx_enable = 1'b0;
    read_enable = 1'b0;
    sda_mode = 2'b00;
    load_data = 1'b0;
    
    case (state)
      
    IDLE : begin
    //  rx_enable = 1'b1;
      if(start_found == 1'b1) begin
        next_state = REC;
      end 
    end 
    
    
    REC : begin
      rx_enable = 1'b1;
      //if(ack_prep == 1'b1) begin
      if(byte_received == 1'b1) begin
        next_state = ADDR_CHK;
      end else if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
      
    end 
    
    ADDR_CHK : begin
      if(address_match == 1'b1 && rw_mode == 1'b1) begin
         next_state = SLAVE_ACK;
      //end else if(address_match == 1'b0 && rw_mode == 1'b0)begin
      end else begin
         next_state = SLAVE_NACK;
      end 
      if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
    end 
    
    SLAVE_NACK : begin
      sda_mode = 2'b10;
      if(ack_done == 1'b1) begin
        next_state = IDLE;
      end
    end 
    
    SLAVE_ACK : begin
      sda_mode = 2'b01; //ACK
      if(ack_done == 1'b1)begin
        next_state = LOAD_DATA;
      end else if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
    end
    
    LOAD_DATA : begin
      sda_mode = 2'b01; //ACK
      load_data = 1'b1;
      next_state = TX_FIFO;
      
      if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
    end 
    
    TX_FIFO : begin
      tx_enable = 1'b1;
      sda_mode = 2'b11;
      if(ack_prep == 1'b1)begin
        next_state = MASTER_CHECK_ACK;
      end else if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
    end 
    
    MASTER_CHECK_ACK : begin
      if(check_ack == 1'b1) begin
        next_state = MASTER_CHECK;
      end else if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
    end 
    
    MASTER_CHECK : begin
      if (sda_in == 1'b0) begin
        next_state = READ_ENABLE;
      end else begin
        next_state = MASTER_NACK;
      end 
      
      if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
    end 
    
    MASTER_NACK : begin
//      if(stop_found == 1'b1) begin
        next_state = IDLE;
//      end 
    end
    
    READ_ENABLE : begin
      read_enable = 1'b1;
      next_state = MASTER_ACK;
      if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
      
    end 
    
    MASTER_ACK : begin
      if(ack_done == 1'b1) begin
        next_state = LOAD_DATA;
      end else if(stop_found == 1'b1) begin
        next_state = IDLE;
      end
    
    end
    
    
    endcase 
end 
    

endmodule
  
