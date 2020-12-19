// Filename:    tb_problem4_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is the test bench for Problem 4

// Time Unit = 1 ns (#1 means 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

module tb_problem4_jdl25175();
    reg en;
    reg [2:0] sel;
    reg [7:0] in;
    reg [3:0] counter;
    wire p4_out;

    mux8to1_delay_jdl25175 mod2(en, sel, in, p4_out);

    initial begin
        en = 1'b1;
        in = 8'b10101010;
        for(counter = 4'b0000; counter < 4'b1000; counter = counter + 4'b0001) begin
            sel = counter;
            #50;
        end

        //This tests the time delay of switching mux_in and enable pins
        sel = 3'b000;
        #50;
        in = 8'b00000000;
        #50;
        in = 8'b11111111;
        #50;
        en = 1'b0;
        #50;
        en = 1'b1;
        #50;
    end

endmodule
