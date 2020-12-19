////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename:    tb_project3bTop.v
// Author:      Jonathan Lemarroy
// Date:        10 November 2020
// Version:     1
// Description: FSM testbench.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ns
module tb_project3bTop();
	reg         CLOCK_50;
	reg   [6:0] SW;
	reg   [1:0] KEY;
	
   wire  [6:0] HEX3;		// These are the seven-segment display driver outputs.
	wire  [6:0] HEX2; 
	wire  [6:0] HEX1;
	wire  [6:0] HEX0;
	wire  [6:0] LED;		// Use the LEDs to view the switch values.


	// Instantiate counter.
	project3bTop dut(CLOCK_50, SW, KEY, HEX3, HEX2, HEX1, HEX0, LED);	
	
	//Creates a 50MHz clock
	initial begin
		CLOCK_50 = 1'b0;
		#10;
		while(1'b1) begin
		#10
		CLOCK_50 = 1'b1;
		#10
		CLOCK_50 = 1'b0;
		end
	end
	
	initial begin
		KEY[1] = 1'b1;
		#1;
		KEY[1] = 1'b0;
		KEY[0] = 1'b1;
		#1;
		KEY[1] = 1'b1;
		SW = 7'b000000;
	end

	// NOTE: ran out of time for this project while writing the test bench.

endmodule
