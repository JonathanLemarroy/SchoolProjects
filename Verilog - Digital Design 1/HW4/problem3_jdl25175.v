// Filename:    problem3_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is the solution to Problem 3 part b, which implements the
//              function F using a 8 to 1 multiplexer.

module problem3_jdl25175(a, b, c, d, f);
    input  a, b, c, d;		// The input variables for the function
    output f;				// The output of the function

    mux8to1_jdl25175 den(1'b1, {a,b,c}, {1'b0, 1'b1, ~d, d, 1'b0, d, 1'b1, ~d}, f);

endmodule
