// Filename:    problem2_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is the solution to Problem 2 part b, which implements the
//              function F using a 4 to 16 decoder.

module problem2_jdl25175(a, b, c, d, f);
    input  a, b, c, d;		// The input variables for the function
    output f;				// The output of the function

    wire [15:0] o;

    decoder4to16_jdl25175 den(1'b1, {a,b,c,d}, o);

    or out1(f, o[13], o[12], o[10], o[9], o[5], o[3], o[2], o[0]);

endmodule
