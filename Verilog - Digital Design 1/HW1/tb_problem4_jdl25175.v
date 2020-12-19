////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_problem4_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        07 September 2020
// Version:     1
// Description: This file tests the problem4_jdl25175 module by creating the truth table for ABCDEF
////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module tb_problem4_jdl25175();
    reg a, b, c, d, e;
    wire f;
    problem4_jdl25175 mod1(a, b, c, d, e, f);

    //ABCDE
    initial begin
        a = 0'b0; //00000
        b = 0'b0;
        c = 0'b0;
        d = 0'b0;
        e = 0'b0;
        #10;
        e = 0'b1; //00001
        #10;
        d = 0'b1; //00010
        e = 0'b0;
        #10;
        e = 0'b1; //00011
        #10;
        c = 0'b1; //00100
        d = 0'b0;
        e = 0'b0;
        #10;
        e = 0'b1; //00101
        #10;
        d = 0'b1; //00110
        e = 0'b0;
        #10;
        e = 0'b1; //00111
        #10
        b = 0'b1; //01000
        c = 0'b0;
        d = 0'b0;
        e = 0'b0;
        #10;
        e = 0'b1; //01001
        #10;
        d = 0'b1; //01010
        e = 0'b0;
        #10;
        e = 0'b1; //01011
        #10;
        c = 0'b1; //01100
        d = 0'b0;
        e = 0'b0;
        #10;
        e = 0'b1; //01101
        #10;
        d = 0'b1; //01110
        e = 0'b0;
        #10;
        e = 0'b1; //01111
        #10;
        a = 0'b1; //10000
        b = 0'b0;
        c = 0'b0;
        d = 0'b0;
        e = 0'b0;
        #10;
        e = 0'b1; //10001
        #10;
        d = 0'b1; //10010
        e = 0'b0;
        #10;
        e = 0'b1; //10011
        #10;
        c = 0'b1; //10100
        d = 0'b0;
        e = 0'b0;
        #10;
        e = 0'b1; //10101
        #10;
        d = 0'b1; //10110
        e = 0'b0;
        #10;
        e = 0'b1; //10111
        #10
        b = 0'b1; //11000
        c = 0'b0;
        d = 0'b0;
        e = 0'b0;
        #10;
        e = 0'b1; //11001
        #10;
        d = 0'b1; //11010
        e = 0'b0;
        #10;
        e = 0'b1; //11011
        #10;
        c = 0'b1; //11100
        d = 0'b0;
        e = 0'b0;
        #10;
        e = 0'b1; //11101
        #10;
        d = 0'b1; //11110
        e = 0'b0;
        #10;
        e = 0'b1; //11111
        #10;
    end
endmodule