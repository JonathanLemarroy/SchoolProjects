////////////////////////////////////////////////////////////////////////////////
// Filename:    register10bit.v
// Author:      Jonathan Lemarroy
// Date:        10/23/2020
// Version:     1
// Description: This is a 10-bit register whose values are set on a positive edge
//              of the clock.
////////////////////////////////////////////////////////////////////////////////

module register10bit_jdl25175(clk, d_in, q_out); 
   input        clk;
   input  [9:0] d_in; 
   output reg [9:0] q_out; 

   always @(posedge clk) begin
       q_out[0] <= d_in[0];
       q_out[1] <= d_in[1];
       q_out[2] <= d_in[2];
       q_out[3] <= d_in[3];
       q_out[4] <= d_in[4];
       q_out[5] <= d_in[5];
       q_out[6] <= d_in[6];
       q_out[7] <= d_in[7];
       q_out[8] <= d_in[8];
       q_out[9] <= d_in[9];
   end

endmodule