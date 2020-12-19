// Filename:    tb_logicfunction_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is the test bench for Problem 2 and 3

// Time Unit = 1 ns (#1 means 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

module tb_logicfunction_jdl25175();
    reg [3:0] ABCD;
    reg [4:0] counter;
    wire p2_out, p3_out;

    problem2_jdl25175 mod1(ABCD[3], ABCD[2], ABCD[1], ABCD[0], p2_out);

    problem3_jdl25175 mod2(ABCD[3], ABCD[2], ABCD[1], ABCD[0], p3_out);

    initial begin
        for(counter = 5'b00000; counter < 5'b10000; counter = counter + 5'b00001) begin
            ABCD = counter;
            #20;
        end
    end

endmodule
