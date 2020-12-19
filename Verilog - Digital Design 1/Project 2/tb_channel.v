////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_channel.v
// Author:      Jonathan Lemarroy
// Date:        10/24/2020
// Version:     1
// Description: This is the design for the receiver described in ECE 3544-Project 2
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

//This module shows a good solution with clock frequency low enough to prevent errors
module tb_channel1();
    reg clk_en, clr, enable;
    wire [9:0] transmit_out;
    wire [8:0] data_out;
    wire valid;

    clk #(40) clock(clk_en, clk_out);
    transmit_jdl25175 transmitter(clk_out, enable, clr, transmit_out);
    receive_jdl25175 receiver(clk_out, transmit_out, valid, data_out);

    initial begin
        clk_en = 1'b1;
        clr = 1'b1;
        #15;
        clr = 1'b0;
        enable = 1'b1;
    end

endmodule


// //This module shows a bad solution with clock frequency too high creating invalid output
module tb_channel2();
    reg clk_en, clr, enable;
    wire [9:0] transmit_out;
    wire [8:0] data_out;
    wire valid;

    clk #(20) clock(clk_en, clk_out);
    transmit_jdl25175 transmitter(clk_out, enable, clr, transmit_out);
    receive_jdl25175 receiver(clk_out, transmit_out, valid, data_out);

    initial begin
        clk_en = 1'b1;
        clr = 1'b1;
        #15;
        clr = 1'b0;
        enable = 1'b1;
    end

endmodule