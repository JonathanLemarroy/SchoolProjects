module problem4_jdl25175(clock, reset_l, count, state);
   input        clock;		// System clock;
   input        reset_l;	// Asynchronous active-low reset;
   input        count;		// Synchronous active-high count enable
   output [3:0] state;		// Counter state

   wire         carry;

   problem3_jdl25175 mod1(clock, reset_l, 1'b0, count, 4'b0000, state, carry);

endmodule