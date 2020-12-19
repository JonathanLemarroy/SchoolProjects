// Filename:    tb_problem5_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is the test bench for Problem 5 - The seven-segment display.

// Time Unit = 1 ns (#1 means 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

module tb_problem5_jdl25175();
    reg     [3:0] digit;
    reg     [4:0] counter;
    wire    [6:0] hexDisp;

    problem5_jdl25175 mod1(digit, hexDisp);

    initial begin
        for(counter = 5'b00000; counter < 5'b10000; counter = counter + 5'b00001) begin
            digit = counter;
            #20;
        end
    end

endmodule
