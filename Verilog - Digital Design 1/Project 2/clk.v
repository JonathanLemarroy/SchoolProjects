////////////////////////////////////////////////////////////////////////////////
// Filename:    clk.v
// Author:      T. Martin
// Date:        09/07/04
// Version:     2
// Description: This module functions as a simple behavioral circuit that
//              SIMULATES a free-running clock.
//
//              This module has one input and one output:
//              - enable:  The clock module runs when this is asserted. (input)
//	        - clk_out: The clock output. (output)
// 
// 		This module has one parameter:
//              - period: The clock period of the free-running output (in ns).
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 09/07/2004  TLM  1        Original
// 08/24/2005  PMA  2        Restructured for Fall 2005
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/100 ps

module clk(clk_en, clk_out);
   input  clk_en;		// Allow clk_out to "run" when asserted.
   output clk_out;		// Enable-controlled clock output.
   reg    clk_out;		// Variable clk_out is defined procedurally.

   parameter PERIOD = 50;	// The default period of the clock.

// Set initial value for clk_out on power-up
   initial clk_out = 0;

// Produce controlled free-running clock
   always begin
      #(PERIOD/2) if(clk_en)
         clk_out = ~clk_out;
   end

endmodule
