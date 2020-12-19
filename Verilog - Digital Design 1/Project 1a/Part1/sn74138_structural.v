////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    sn74138_structural.v
// Author:      Jason Thweatt
// Date:        08 August 2019
// Version:     1
// Description: This file contains a structural model for the 74138 3-to-8 decoder IC chip.
//              It uses primitive logic gates.
//              We are using it here as an introduction to the ModelSim environment.
////////////////////////////////////////////////////////////////////////////////////////////////////

module sn74138_structural(g1, g2a_n, g2b_n, c, b, a, y_n);
   input        g1, g2a_n, g2b_n;	// Decoder enables: G1 is active high; G2A and G2B are active-low.
   input        c, b, a;		// Decoder inputs: C is the MSB; A is the LSB.
   output [7:0] y_n;			// Active-low decoder outputs.

   wire         g1_n;			// Inverted signal from the active-high decoder enable.
   wire         c_n, b_n, a_n;		// Inverted decoder inputs.
   wire         enable;			// Intermediate signal for the enable inputs.

   // NOT gates produce the necessary inverted versions of the signals.
   not  not1(g1_n, g1), not2(c_n, c), not3(b_n, b), not4(a_n, a);

   // A NOR gate defines the enable condition.
   // The enable signal is 1 only when {g1, g2a_n, g2b_n} = 3'b100.
   nor  and1(enable, g1_n, g2a_n, g2b_n);	

   // NAND gates supply the active-low decoder outputs.
   nand  out7(y_n[7], enable, c, b, a), out6(y_n[6], enable, c, b, a_n), out5(y_n[5], enable, c, b_n, a), out4(y_n[4], enable, c, b_n, a_n),
         out3(y_n[3], enable, c_n, b, a), out2(y_n[2], enable, c_n, b, a_n), out1(y_n[1], enable, c_n, b_n, a), out0(y_n[0], enable, c_n, b_n, a_n);

endmodule
