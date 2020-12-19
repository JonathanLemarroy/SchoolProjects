// Filename:    tb_problem6_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is the test bench for Problem 6 - Parity bit concatenator.

// Time Unit = 1 ns (#1 means 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

module tb_problem6_jdl25175();
    reg           parity;
    reg     [7:0] in;
    wire    [8:0] out;

    problem6_jdl25175 mod1(parity, in, out);

    initial begin
        parity = 1'b0;
        in = 8'b00000000;
        #50;
        parity = 1'b1;
        #50;

        parity = 1'b0;
        in = 8'b01010010;
        #50;
        parity = 1'b1;
        #50;

        parity = 1'b0;
        in = 8'b10100111;
        #50;
        parity = 1'b1;
        #50;

        parity = 1'b0;
        in = 8'b11111111;
        #50;
        parity = 1'b1;
        #50;
    end

endmodule
