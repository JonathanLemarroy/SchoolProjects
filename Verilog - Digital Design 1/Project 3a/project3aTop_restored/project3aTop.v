////////////////////////////////////////////////////////////////////////////////
// Filename: project3aTop.v
// Author:   Jason Thweatt
// Date:     24 October 2017
// Revision: 1
//
// This is the top-level module for ECE 3544 Project 3a.
// Do not modify the module declaration or ports in this file.
// When synthesizing to the DE1-SoC, this file should be used with the provided
// Quartus project so that the FPGA pin assignments are made correctly.
//
// YOU MUST MAKE THE PIN ASSIGNMENTS FOR THE INPUTS AND OUTPUTS OF THIS MODULE.
// FOLLOW THE INSTRUCTIONS IN THE DOCUMENT ON PIN PLACEMENT.
// CONSULT THE MANUAL FOR INFORMATION ON THE PIN LOCATIONS.

module project3aTop(SW, LED, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
   input  [9:0] SW;
   output [9:0] LED;
   output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 
// This should allow you to see the values of the switches on the LEDs.
// YOU WILL NEED TO CHANGE THIS TO SATISFY THE SPECIFICATION REQUIREMENTS
    assign LED[6:0] = SW[6:0];
	
	wire [7:1] BC_out;
	wire [5:0] e;
	wire [2:0] Todd;
	wire [2:0] Rodd;

// This maps certain switches to the seven-segment display inputs.
// Use this as an example of instantiating in the top-level module, and as a
// test of your seven-segment displays. 
// You may leave these instantiations in place in your final submission, since
// Project 3A does not use the seven-segment displays.

    project3aTest U0(SW[1:0], HEX0);
	project3aTest U1(SW[3:2], HEX1);
	project3aTest U2(SW[5:4], HEX2);
	project3aTest U3(SW[7:6], HEX3);
	project3aTest U4(SW[9:8], HEX4);
    project3aTest U5(SW[9:8], HEX5);	 
	
	hc280_jdl25175 TP0({5'b0, SW[6], SW[4], SW[2], SW[0]}, e[0], Todd[0]);
	hc280_jdl25175 TP1({5'b0, SW[6], SW[5], SW[2], SW[1]}, e[1], Todd[1]);
	hc280_jdl25175 TP2({5'b0, SW[6], SW[5], SW[4], SW[3]}, e[2], Todd[2]);
	
	bit_corrupter C(SW[9:7], SW[6:0], BC_out);
	
	hc280_jdl25175 RP0({5'b0, BC_out[7], BC_out[5], BC_out[3], BC_out[1]}, e[3], Rodd[0]);
	hc280_jdl25175 RP1({5'b0, BC_out[7], BC_out[6], BC_out[3], BC_out[2]}, e[4], Rodd[1]);
	hc280_jdl25175 RP2({5'b0, BC_out[7], BC_out[6], BC_out[5], BC_out[4]}, e[5], Rodd[2]);
	
	xor x1(LED[9], Todd[2], Rodd[2]), x2(LED[8], Todd[1], Rodd[1]), x3(LED[7], Todd[0], Rodd[0]);
	

// Your top-level module should conform to block diagram provided in the
// specification. It should contain:
// - Six instantiations of your 74HC280.
//   - Three represent "transmit-side" parity checkers. Use the appropriate
//     bits of SW[6:0] as the inputs to these parity checkers. YOU WILL NOT
//     USE ALL OF THE BIT OF SW[6:0] as the inputs to these parity checkers.
//   - Three represent "receive-side" parity checkers. Use the appropriate
//     outputs of the bit corrupter module as the inputs to these parity
//     checkers. YOU WILL NOT USE ALL OF THE BIT CORRUPTER outputs as the
//     inputs to these parity checkers.
// - One instantiation of your Bit Corrupter module. Use SW[6:0] as the 7-bit
//   input word. Use SW[9:7] as the index input. Use the appropriate outputs
//   of the bit corrupter module as the inputs to the "receive-side" parity
//   checkers. 
// - Three 2-input XOR gates. Connect corresponding pairs of "transmit-side" and
//   "receive-side" parity checker outputs as the inputs of your XOR gates.

endmodule
