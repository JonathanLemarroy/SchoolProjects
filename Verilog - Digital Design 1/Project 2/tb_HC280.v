////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_HC280.v
// Author:      Jonathan Lemarroy
// Date:        10/22/2020
// Version:     1
// Description: This is the HC280 9-bit even/odd parity bit generator test bench.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module tb_hc280_jdl25175();
   reg        clk_enable;	// Locally-created clock enable signal
   reg        ctr_enable;	// Locally-created counter enable signal
   reg        ctr_clr;		// Locally-created counter clear signal
   wire       clk_out;		// Clock produced by the clk module
   wire [8:0] count;	    // Counter outputs for the two 9-bit counters
   wire       even_out, odd_out;

// Instantiate the clock generator with a period of 100 ns
   clk #(100) clk1(clk_enable, clk_out);

// Intantiation of the counter.
   counter9bit_jdl25175 ctr(ctr_enable, ctr_clr, clk_out, count);
   hc280_jdl25175 parityGenerator(count, even_out, odd_out);
// Sequence the ENABLE and CLR signals
   initial begin
      clk_enable = 1;
      ctr_clr = 1;
      #1  ctr_clr = 0;
      ctr_enable = 1;
   end

endmodule