////////////////////////////////////////////////////////////////////
// Filename:    state_onehot_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        12 November 2020
// Version:     1
// Description: This is the solution to HW 5 problem 5 state module 
//              representing Problem 2.
///////////////////////////////////////////////////////////////////

module state_onehot_jdl25175(clock, init, in, out, state);
   input        clock;	// System clock
   input        init;	// Asynchronous active-low init
   input  [1:0] in;		// System (two-bit) input
   output       out;	// System output
   output [3:0] state;	// System state

   wire [3:0] newState;

   dff_hw5_set_reset D1(clock, ~init, 1'b0, newState[3], state[3]), D2(clock, ~init, 1'b0, newState[2], state[2]),
                     D3(clock, ~init, 1'b0, newState[1], state[1]), D4(clock, 1'b0, ~init, newState[0], state[0]);

   assign newState = (state[0] == 1'b1 && (in == 2'b11 || in == 2'b10)) ? 4'b0010:
                      (state[1] == 1'b1 && in == 2'b00) ? 4'b0100:
                      (state[1] == 1'b1) ? 4'b0010:
                      (state[2] == 1'b1 && (in == 2'b11 || in == 2'b01)) ? 4'b1000:
                      (state[3] == 1'b1 && in == 2'b00) ? 4'b0001:
                      (state[3] == 1'b1) ? 4'b0100 : state;

   assign out = (state[0] == 1'b1) ? 0:
                   (state[1] == 1'b1) ? 0:
                   (state[2] == 1'b1) ? 1:
                   (state[3] == 1'b1) ? 1:
                   1'bx;
endmodule