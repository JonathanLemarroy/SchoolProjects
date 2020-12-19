////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    problem5_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        07 September 2020
// Version:     1
// Description: This file implements the boolean expression F = ~(A(B + C)(D + E))
////////////////////////////////////////////////////////////////////////////////////////////////////

module problem5_jdl25175(a, b, c, d, e, f);

    input  a, b, c, d, e;
    output f;

    wire ow1, ow2, ow3, aw1, aw2;

    pmos pt1(f, 1'b1, a), pt2(aw1, 1'b1, b), pt3(f, aw1, c), pt4(aw2, 1'b1, d), pt5(f, aw2, e);
    nmos nt1(f, ow1, a), nt2(ow1, ow2, b), nt3(ow1, ow2, c), nt4(ow2, 1'b0, d), nt5(ow2, 1'b0, e);
    
endmodule
    
