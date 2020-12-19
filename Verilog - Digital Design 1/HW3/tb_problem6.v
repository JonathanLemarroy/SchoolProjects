// Time Unit = 1 ns (#1 means 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

// Filename:    tb_problem6.v
// Author:      Jonathan Lemarroy
// Date:        06 October 2020
// Version:     1
// Description: This file contains a test bench for a seven-segment decoder
//              that was implemented using continuous assignment.

module tb_problem6();
    reg  [3:0] ins;
    reg  [4:0] count;
    wire [6:0] out;

    sevensegdecoder_cont_jdl25175 dut(ins, out);	// Instantiate the design being tested.

    initial begin
        for(count = 5'b00000; count < 5'b10000; count = count + 5'b00001) begin
            ins = count;
            #20;
        end
    end

endmodule