////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_sn74138.v
// Author:      Jason Thweatt
// Date:        08 August 2019
// Version:     1
// Description: This file contains a test bench for the SN74138 3-to-8 decoder.
//              We are using it here as an introduction to the ModelSim environment.
//              The testbench is defined behaviorally. It uses a procedure to define the input
//              waveform.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Time Unit = 1 ns (#1 = 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

// Testbenches don't have arguments. Instead, the values that we want to modify are regs.
// ANY VALUE THAT IS THE TARGET OF A PROCEDURE MUST BE A REG.
// The values that we wish to observe are wires.

module tb_sn74138();
   reg  [2:0] dec_en;		// A vector representing the three decoder enables {G1, G2a_n, G2b_n}
   reg  [2:0] dec_in;		// A vector representing the three decoder inputs {C, B, A}
   wire [7:0] dec_out_n;	// A vector representing the decoder outputs.

// Instantiate the decoder (the identifier is dut, or "device under test").

   sn74138_structural dut1(dec_en[2], dec_en[1], dec_en[0], dec_in[2], dec_in[1], dec_in[0], dec_out_n);

// The input test stimulus is defined as a pair of initial blocks.
// Each initial block is a procedure.
// Even though the statements in each initial block execute in sequence, THE TWO INITIAL BLOCKS EXECUTE CONCURRENTLY.
// Each one begins at simulation time t = 0 and continues according to the timing delays that each one contains.

// Both initial blocks should cover the same 600 ns of simulation time.

   initial begin
      dec_en = 3'b000;	// (t = 0) Apply an enable condition that disables the decoder.
      #50;		// Wait 50 ns. 
      dec_en = 3'b100;	// Apply the enable condition that enables the decoder.
      #450;		// Wait 4500 ns.
      dec_en = 3'b110;	// Apply a different enable condition that disables the decoder.
      #50;		// Wait 50 ns.
      dec_en = 3'b101;	// Apply a different enable condition that disables the decoder.
      #50;		// Wait 50 ns.
   end

   initial begin
      dec_in = 3'b000;	// (t = 0) Apply the first input combination.
      #100;		// Wait for 100 ns.
      dec_in = 3'b001;	// Apply the remaining input combinations in sequence.
      #50;		// Wait for 50 ns after each input change.
      dec_in = 3'b010;
      #50;
      dec_in = 3'b011;
      #50;
      dec_in = 3'b100;
      #50;
      dec_in = 3'b101;
      #50;
      dec_in = 3'b110;
      #50;
      dec_in = 3'b111;
      #50;
      dec_in = 3'b000;	// Return to the first decoder input combination.
      #150;
   end

endmodule
