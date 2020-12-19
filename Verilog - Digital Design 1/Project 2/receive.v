////////////////////////////////////////////////////////////////////////////////
// Filename:    transmit.v
// Author:      Jonathan Lemarroy
// Date:        10/24/2020
// Version:     1
// Description: This is the design for the receiver described in ECE 3544-Project 2
////////////////////////////////////////////////////////////////////////////////

module receive_jdl25175(clk, data_in, data_valid, data_out);
    input        clk;
    input  [9:0] data_in;
    output       data_valid;
    output [8:0] data_out;
    wire         even_out, odd_out;
    wire   [9:0] regOut;

    register10bit_jdl25175 rgstr(clk, data_in, regOut);
    hc280_jdl25175 parityGenerator(regOut[8:0], even_out, odd_out);
    assign data_valid = ~(odd_out ^ regOut[9]);
    assign data_out = regOut[8:0];

endmodule
