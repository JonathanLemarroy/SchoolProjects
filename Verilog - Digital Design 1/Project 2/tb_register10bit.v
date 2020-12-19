////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_register10bit.v
// Author:      Jonathan Lemarroy
// Date:        10/24/2020
// Version:     1
// Description: This is the test bench for a 10-bit register.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module tb_register10bit_jdl25175();
    reg clk_en;
    reg [9:0] in;
    reg [9:0] count;
    wire clk_out;
    wire [9:0] out;


    clk #(30) M1(clk_en, clk_out);
    register10bit_jdl25175 rgstr(clk_out, in, out);

    initial begin
        clk_en = 1'b1;
        in = 10'd1023;
        #20;
        for(count = 10'd0; count < 10'd63; count = count + 10'd1) begin
            in = count;
            #20;
        end
    end

endmodule