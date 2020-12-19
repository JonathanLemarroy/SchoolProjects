////////////////////////////////////////////////////////////////////////////////
// Filename:    counter9bit.v
// Author:      Jonathan Lemarroy
// Date:        10/22/2020
// Version:     1
// Description: This module is a behavioral description of a simple 9-bit
//              counter with enable and asynchronous clear.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module counter9bit_jdl25175(enable, clear, clk, count);
   input        enable;		// Active-high counter enable.
   input        clear;		// Asynchronous active-high clear
   input        clk;		// System clock
   output [8:0] count;		// 4-bit counter output
   reg    [8:0] count;		// Variable count is defined procedurally.

   parameter CLRDEL = 10;	// Delay from clear to valid output.
   parameter CLKDEL = 15;	// Delay from clock to valid output.

   // Behavioral 9-bit up-counter with asynchronous clear
   always @(posedge clk or posedge clear) begin
      if(clear)
         count <= #CLRDEL 9'b0;
      else begin
         if(enable) begin
            if(count == 9'd511)
               count <= #CLKDEL 9'b0;
            else
               count <= #CLKDEL count + 9'd1;
         end
      end
   end

endmodule
