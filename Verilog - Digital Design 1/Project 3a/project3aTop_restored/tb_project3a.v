////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_project3a.v
// Author:      Jonathan Lemarroy
// Date:        11/2/2020
// Version:     1
// Description: This is the test bench for Project 3A's Hamming code machine
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/100 ps

module tb_project3a();
//  Declare regs and wires.
   reg  [9:0] SW;
   wire [9:0] LED;
   wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;


//  Instantiate system.
	project3aTop HC(SW, LED, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

   initial begin
      // Test when all bits are valid
      SW[9:7] = 3'b000;
      SW[6:0] = 7'b0000000;
      #20;
      SW[6:0] = 7'b1010101;
      #20;
      SW[6:0] = 7'b0101010;
      #20;
      SW[6:0] = 7'b1110111;
      #20;
      SW[6:0] = 7'b0001000;
      #20;
      
      // Test when a single bit is invalid
      SW[6:0] = 7'b0000000;
      SW[9:7] = 3'b001;
      #20;
      SW[9:7] = 3'b101;
      #20;
      SW[6:0] = 7'b1010101;
      SW[9:7] = 3'b010;
      #20;
      SW[9:7] = 3'b110;
      #20;
      SW[6:0] = 7'b0101010;
      SW[9:7] = 3'b011;
      #20;
      SW[9:7] = 3'b111;
      #20;
      SW[6:0] = 7'b1110111;
      SW[9:7] = 3'b100;
      #20;
      SW[6:0] = 7'b0001000;
      SW[9:7] = 3'b001;
      #20;
      SW[9:7] = 3'b011;
      #20;
      SW[9:7] = 3'b101;
      #20;
      SW[9:7] = 3'b111;
      #20;
   end
endmodule
