////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_counter9bit.v
// Author:      Jonathan Lemarroy
// Date:        10/22/2020
// Version:     4
// Description: This module serves as a simple testbench for the counter module.
//              Two counters are instantiated and stimulated with a simple sequence.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module tb_counter9bit_jdl25175();
   reg        clk_enable;	// Locally-created clock enable signal
   reg        ctr_enable;	// Locally-created counter enable signal
   reg        ctr_clr;		// Locally-created counter clear signal
   wire       clk_out;		// Clock produced by the clk module
   wire [8:0] count1, count2;	// Counter outputs for the two 9-bit counters

// Instantiate the clock generator with a period of 100 ns
   clk #(100) clk1(clk_enable, clk_out);

// Intantiate two versions of the counter. ctr1 uses the default values.
// ctr2 overrides the default values of the parameters with #(20,30) ns.
   counter9bit_jdl25175          ctr1(ctr_enable, ctr_clr, clk_out, count1);
   counter9bit_jdl25175 #(20,30) ctr2(ctr_enable, ctr_clr, clk_out, count2);

// Sequence the ENABLE and CLR signals
   initial begin
      clk_enable = 1;
      ctr_enable = 0;
      ctr_clr = 0;
      #10  ctr_clr = 1;
      #40  ctr_clr = 0;
      #50  ctr_enable = 1;
      #1000 ctr_enable = 0;
      #200 ctr_enable = 1;
      #300 ctr_clr = 1;
      #60  ctr_clr = 0;
   end

endmodule
