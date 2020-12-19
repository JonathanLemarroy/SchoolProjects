////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    problem4_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        07 September 2020
// Version:     1
// Description: This file implements the boolean expression F = ~((AB) + (CDE))
////////////////////////////////////////////////////////////////////////////////////////////////////

module problem4_jdl25175(a, b, c, d, e, f);

    input  a, b, c, d, e;
    output f;

    wire ow1, aw1, aw2, aw3, aw4;

    pmos pt1(ow1, 1'b1, a), pt2(ow1, 1'b1, b), pt3(f, ow1, c), pt4(f, ow1, d), pt5(f, ow1, e);
    nmos nt1(f, aw1, c), nt2(aw1, aw2, d), nt3(aw2, 1'b0, e), nt4(f, aw4, a), nt5(aw4, 1'b0, b);
    
endmodule
    
