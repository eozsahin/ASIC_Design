`timescale 1ns / 10ps

module tb_adder_16bit
();
	// Define local parameters used by the test bench
	localparam NUM_INPUT_BITS			= 16;
	localparam NUM_OUTPUT_BITS		= NUM_INPUT_BITS + 1;
	localparam MAX_OUTPUT_BIT			= NUM_OUTPUT_BITS - 1;
	localparam NUM_TEST_BITS 			= (NUM_INPUT_BITS * 2) + 1;
	localparam MAX_TEST_BIT				= NUM_TEST_BITS - 1;
	localparam NUM_TEST_CASES 		= 2 ** NUM_TEST_BITS;
	localparam MAX_TEST_VALUE 		= NUM_TEST_CASES - 1;
	localparam TEST_A_BIT					= 0;
	localparam TEST_B_BIT					= NUM_INPUT_BITS;
	localparam TEST_CARRY_IN_BIT	= MAX_TEST_BIT;
	localparam TEST_SUM_BIT				= 0;
	localparam TEST_CARRY_OUT_BIT	= MAX_OUTPUT_BIT;
	localparam TEST_DELAY					= 10;
	
	// Declare Design Under Test (DUT) portmap signals
	reg [NUM_INPUT_BITS - 1:0] tb_a;
	reg [NUM_INPUT_BITS - 1:0] tb_b;
	reg	tb_carry_in;
	wire [NUM_INPUT_BITS - 1:0] tb_sum;
	wire	tb_carry_out;
	
	// Declare test bench signals
	integer tb_test_case;
	reg [MAX_TEST_BIT:0] tb_test_inputs;
	reg [MAX_OUTPUT_BIT:0] tb_expected_outputs;
	
	// DUT port map
	adder_16bit DUT(.a(tb_a), .b(tb_b), .carry_in(tb_carry_in), .sum(tb_sum), .overflow(tb_carry_out));
	
	// Connect individual test input bits to a vector for easier testing
  //tb_a					 = tb_test_inputs[NUM_INPUT_BITS - 1:0]; 
	//tb_b					= tb_test_inputs[MAX_TEST_BIT - 1:NUM_INPUT_BITS];
	//tb_test_inputs[TEST_CARRY_IN_BIT];
	
	// Test bench process
	initial
	begin
		// Initialize test inputs for DUT
		  tb_test_inputs = 0;
				
		//TEST CASE 1: A=0, B=0
		  tb_test_case = 1;
		  tb_carry_in	= 1;
		
		  tb_a = 16'b0000000000000000;
		  tb_b = 16'b0000000000000000;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
	
				
		//TEST CASE 2: A=0, B=0
		  tb_test_case = 2;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b0000000000000000;
		  tb_b = 16'b0000000000000000;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
	
		//TEST CASE 3: A=0, B=0
	
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b1010101010000000;
		  tb_b = 16'b0000001010101010;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
	

		//TEST CASE 4: A=0, B=0
	
		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b1010101010000000;
		  tb_b = 16'b0000001010101010;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
	
//TEST CASE 5: A=0, B=0

		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b1011101010110000;
		  tb_b = 16'b0010101000100010;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
	
//TEST CASE 6: A=0, B=0

		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b1010101010110000;
		  tb_b = 16'b0101001100001010;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  
			  //TEST CASE 7: A=0, B=0
			  
		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b0000001010110100;
		  tb_b = 16'b0111101000100010;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  
			    //TEST CASE 7: A=0, B=0
			    
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b0000001010110100;
		  tb_b = 16'b0111101000100010;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end

//TEST CASE 8: A=0, B=0

		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b0001000100101101;
		  tb_b = 16'b1000101100001110;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end

//TEST CASE 9: A=0, B=0

		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b0001000100101101;
		  tb_b = 16'b1000101100001110;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
//TEST CASE 10: A=0, B=0

		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b0000000010110011;
		  tb_b = 16'b1000000110101010;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  //TEST CASE 10: A=0, B=0
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b0000000000101001;
		  tb_b = 16'b1000000001010001;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  
			  //TEST CASE 10: A=0, B=0
			  
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b000000000011111;
		  tb_b = 16'b101111000111001;	
			#1
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  
			  //TEST CASE 10: A=0, B=0
			  
		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b000000000011111;
		  tb_b = 16'b101111000111001;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  //TEST CASE 10: A=0, B=0
			  
		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b011111110011111;
		  tb_b = 16'b101010101010101;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  
			   //TEST CASE 10: A=0, B=0
			   
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b001001001001111;
		  tb_b = 16'b110010010010010;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  
			  
			   //TEST CASE 10: A=0, B=0
			   
		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b000001111000000;
		  tb_b = 16'b000000111110000;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  //TEST CASE 10: A=0, B=0
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b111110000001111;
		  tb_b = 16'b111110000000111;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  //TEST CASE 10: A=0, B=0
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b100101001001010;
		  tb_b = 16'b001010000111111;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  
			  //TEST CASE 10: A=0, B=0
		  tb_test_case = 3;
		  tb_carry_in	= 1'b1;
		
		  tb_a = 16'b000001010000010;
		  tb_b = 16'b000001000000110;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  

//TEST CASE 10: A=0, B=0
		  tb_test_case = 3;
		  tb_carry_in	= 1;
		
		  tb_a = 16'b100000001100011;
		  tb_b = 16'b101100000000111;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  
			  //TEST CASE 10: A=0, B=0
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b011000000111000;
		  tb_b = 16'b011001111000111;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end	  
			  //TEST CASE 10: A=0, B=0
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b111111111111111;
		  tb_b = 16'b111111111111111;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correctsim:/tb_adder_16bit/tb_test_case sim:/tb_adder_16bit/tb_carry_in sim:/tb_adder_16bit/tb_a sim:/tb_adder_16bit/tb_b sim:/tb_adder_16bit/tb_expected_outputs sim:/tb_adder_16bit/tb_sum sim:/tb_adder_16bit/tb_carry_out Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
			  

			  //TEST CASE 10: A=0, B=0
		  tb_test_case = 3;
		  tb_carry_in	= 1'b0;
		
		  tb_a = 16'b011101111101111;
		  tb_b = 16'b011101111110111;	
			#1;
			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			#10;
			if(tb_expected_outputs[NUM_INPUT_BITS-1:0] == tb_sum)begin $info("---Correct Sum value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Sum value for test case %d!", tb_test_case);end
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin $info("---Correct Carry Out value for test case %d!", tb_test_case);end
			else begin $error("Incorrect Carry Out value for test case %d!", tb_test_case);end
	
			  
	end
	
	// Wrap-up process
	final
	begin
		if(NUM_TEST_CASES != tb_test_case)
		begin
			// Didn't run the test bench through all test cases
			$display("This test bench was not run long enough to execute all test cases. Please run this test bench for at least a total of %d ns", (NUM_TEST_CASES * TEST_DELAY));
		end
		else
		begin
			// Test bench was run to completion
			$display("This test bench has run to completion");
		end
	end
endmodule 
