////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_decoder4to16.v
// Author:      Jason Thweatt
// Date:        08 August 2019
// Version:     1
// Description: This file contains a test bench for the 4-to-16 decoder.
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

module tb_decoder4to16();
   reg         enable;
   reg   [3:0] dec_in;
   wire [15:0] dec_out;

   reg   [4:0] count;

// Instantiate the decoder (the identifier is dut, or "device under test").

   decoder4to16 dut1(enable, dec_in, dec_out);

// Test input stimulus, defined as an initial block (procedure).

   initial begin
      enable = 1'b1;		// At time t = 0, the decoder is DISABLED and dec_in = 4'b0000.
      dec_in = 4'b0000;		
      #50;  			// Wait for 50 ns
      enable = 1'b0;		// Enable the decoder.
    	
// We can use a loop to avoid long procedures. There are many other options to write test benches easily!
// NOTE THE DIFFERENCES IN SYNTAX BETWEEN C AND VERILOG!

// With the decoder enabled, the FOR-loop causes dec_in to take in each possible 4-bit value for 50 ns.

      for(count = 0; count < 16; count = count + 1) begin
         dec_in = count[3:0];
         #50;
      end

      dec_in = 4'b0000;		// Set dec_in = 0000.
      #50;			// Wait for 50 ns.
      enable = 1'b1;		// Disable the decoder.
      #50;			// Wait for 50 ns.
   end

endmodule
