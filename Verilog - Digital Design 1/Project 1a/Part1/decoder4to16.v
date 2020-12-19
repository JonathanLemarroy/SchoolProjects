////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    decoder4to16.v
// Author:      Jason Thweatt
// Date:        08 August 2019
// Version:     1
// Description: This file contains a 4-to-16 decoder.
//              It uses two SN74138 decoders and an inverter.
//              We are using it here as an introduction to the ModelSim environment.
////////////////////////////////////////////////////////////////////////////////////////////////////

module decoder4to16(en_n, s, w_n);
   input         en_n;		// Active-low enable input for the 4-to-16 decoder.
   input  [3:0]  s;		// Decoder inputs: s[3] is the MSB; s[0] is the LSB.
   output [15:0] w_n;		// Active-low decoder outputs.

   wire          s3_n;		// Inverted signal from the decoder input MSB.

// The inverter provides the complement of s[3].
   not not1(s3_n, s[3]);

// INSTANTIATE two sn74138 decoders as structural blocks.
// - The 4-to-16 decoder's active-low enable (en_n) controls the two active-low enables of both 3-to-8 decoders.
// - s[3] (from the 4-to-16 decoder) controls the active-high enable of the 3-to-8 decoders.
//   - The "lower" decoder is active when s[3] = 0.
//   - The "upper" decoder is active when s[3] = 1.
// - s[2:0] (from the 4-to-16 decoder) controls the inputs of both 3-to-8 decoders.
//   - The outputs of the "lower" decoder correspond to the lower 8 outputs of the 4-to-16 decoder: w_n[7:0].
//   - The outputs of the "upper" decoder correspond to the upper 8 outputs of the 4-to-16 decoder: w_n[15:8].

   sn74138_structural U1(s3_n, en_n, en_n, s[2], s[1], s[0], w_n[ 7:0]);
   sn74138_structural U2(s[3], en_n, en_n, s[2], s[1], s[0], w_n[15:8]);

endmodule
