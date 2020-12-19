////////////////////////////////////////////////////////////////////////////////
// Filename:    transmit.v
// Author:      Jonathan Lemarroy
// Date:        10/24/2020
// Version:     1
// Description: This is the design for the transmitter described in ECE 3544 Project 2
////////////////////////////////////////////////////////////////////////////////

module transmit_jdl25175(clk, enable, clear, data_out);
    input        clk, enable, clear;
    output [9:0] data_out;
    wire   [8:0] count;
    wire         even, odd;

    counter9bit_jdl25175 counter(enable, clear, clk, count);
    hc280_jdl25175 parityChecker(count, even, odd);
    register10bit_jdl25175 rgstr(clk, {odd, count}, data_out);
    
endmodule