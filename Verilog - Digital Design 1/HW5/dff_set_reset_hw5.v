////////////////////////////////////////////////////////////////////////////////
// Filename:    dff_set_reset_hw5.v
// Author:      J.S. Thweatt
// Date:        19 October 2015
// Version:     1
// Description: This is a D flip-flop for use with Homework 5.
//              This flip-flop has both asynchronous reset and set inputs.

module dff_hw5_set_reset(clock, reset, set, d, q);
   input  clock;	// Flip-flop clock
   input  reset;	// Asynchronous active-high reset
   input  set;		// Asynchronous active-high set
   input  d;		// Flip-flop input
   output q;		// Flip-flop output
   reg    q;

   always @(posedge clock or posedge reset or posedge set) begin
      if(reset)
         q <= 1'b0;
      else if(set)
         q <= 1'b1;
      else
         q <= d;
   end

endmodule
