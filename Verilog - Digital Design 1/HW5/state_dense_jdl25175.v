////////////////////////////////////////////////////////////////////
// Filename:    state_dense_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        12 November 2020
// Version:     1
// Description: This is the solution to HW 5 problem 4 state module 
//              representing Problem 2.
///////////////////////////////////////////////////////////////////

module state_dense_jdl25175(clock, init, in, out, state);
   input        clock;	// System clock
   input        init;	// Asynchronous active-low init
   input  [1:0] in;		// System (two-bit) input
   output       out;	   // System output
   output [1:0] state;	// System state

   wire  [1:0] newState;

   dff_hw5_set_reset D1(clock, ~init, 1'b0, newState[1], state[1]), D2(clock, ~init, 1'b0, newState[0], state[0]);

   assign newState = (state == 2'b00 && (in == 2'b11 || in == 2'b10)) ? 2'b01:
                      (state == 2'b01 && in == 2'b00) ? 2'b10:
                      (state == 2'b01) ? 2'b01:
                      (state == 2'b10 && (in == 2'b11 || in == 2'b01)) ? 2'b11:
                      (state == 2'b11 && in == 2'b00) ? 2'b00:
                      (state == 2'b11) ? 2'b10 : state;

   assign out = (state == 2'b00) ? 0:
                   (state == 2'b01) ? 0:
                   (state == 2'b10) ? 1:
                   (state == 2'b11) ? 1:
                   1'bx;

endmodule
