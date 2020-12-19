// Time Unit = 1 ns (#1 means 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

// Filename:    problem2.v
// Author:      Jonathan Lemarroy
// Date:        06 October 2020
// Version:     1
// Description: This file contains a test bench for a 5 input circuit.
//              It uses a FOR-loop in an initial block to apply all
//              combinations of the inputs for a period of 20 ns each. 

module tb_problem1_for();
    reg  [4:0] ins;
    wire       out;
    reg  [5:0] count;

    problem1_jdl25175 dut(ins, out);	// Instantiate the design being tested.

    initial begin
        for(count = 6'd0; count < 6'd32; count = count + 1'd1) begin
            ins = count;
            #20;
        end
    end

endmodule