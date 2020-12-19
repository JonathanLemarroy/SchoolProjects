////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename:    tb_fsm16bit.v
// Author:      Jason Thweatt
// Date:        28 March 2017
// Version:     2
// Description: FSM testbench.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ns

module tb_fsm16bit();
	reg         clock, reset, enable, check, mode, direction;
	reg   [3:0] value;
	wire [15:0] count;

	// Instantiate counter.
	fsm16bit dut(clock, reset, enable, check, mode, direction, value, count);	

	// Test the counter functionality here.
	// You should set up a 50 MHz clock, along with the various control and input signals.
	// Avoid using the Project 2 clock module, since it is not synthesizable.
	// Adding it to this project will cause Quartus to complain about its synthesizability.

endmodule
