////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_bitCorrupter.v
// Author:      Jonathan Lemarroy
// Date:        11/2/2020
// Version:     1
// Description: This is the test bench for Project 3A's bit corrupter
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/100 ps

module tb_bitCorrupter();
    reg [2:0] indx;
    reg [7:1] in;
    wire [7:1] out;

    bit_corrupter BC(indx, in, out);

    initial begin
        indx = 3'd0;
        in = 7'b0;
        #20;
        indx = 3'd1;
        #20;
        indx = 3'd2;
        #20;
        indx = 3'd3;
        #20;
        indx = 3'd4;
        #20;
        indx = 3'd5;
        #20;
        indx = 3'd6;
        #20;
        indx = 3'd7;
        #20;
        indx = 3'd0;
        in = 7'b1111111;
        #20;
        indx = 3'd1;
        #20;
        indx = 3'd2;
        #20;
        indx = 3'd3;
        #20;
        indx = 3'd4;
        #20;
        indx = 3'd5;
        #20;
        indx = 3'd6;
        #20;
        indx = 3'd7;
        #20;
    end
endmodule