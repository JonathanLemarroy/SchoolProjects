////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    problem3.v
// Author:      Jonathan Lemarroy
// Date:        12/5/2020
// Version:     1
// Description: This file is the solution to problem 3 of HW 7
// 
// NOTE: The control circuit and multiplier module aren't implemented correctly for this circuit to
//       work properly - Not sure as to why they don't work yet.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module reg_8bit_jdl25175(clock, reset, load, ins, outs);
    input        clock;
    input        reset;
    input        load;
    input  [7:0] ins;
    output [7:0] outs;
    reg    [7:0] outs;

    always @(posedge clock or negedge reset) begin
        if(reset == 1'b0)
            outs <= 8'b0;
        else if(load == 1'b1)
            outs <= ins;
    end
endmodule

module adder_8bit_jdl25175(a, b, cout, s);
    input  [7:0] a, b;
    output [7:0] s;
    output cout;

    assign {cout, s} = {1'b0, a} + {1'b0, b};
endmodule

module shiftreg_17bit_jdl25175(clock, reset, load, shift_right, ins, outs);
    input clock, reset, load, shift_right;
    input [16:0] ins;
    output reg [16:0] outs;

    always @(posedge clock, negedge reset) begin
        if(reset == 1'b0)
            outs <= 17'b0;
        else if(load & shift_right)
            outs <= ins >> 1;
        else if(load)
            outs <= ins;
        else if(shift_right)
            outs <= outs >> 1'b1;
    end

endmodule

module mux2to1_17bit_jdl25175(select, in0, in1, out);
    input select;
    input [16:0] in0, in1;
    output [16:0] out;

    assign out = (select == 1'b0) ? in0 : in1;
endmodule

module multiply_controller_jdl25175(clock, reset, lsb, loadA, loadB, select, shift);
    input clock, reset, lsb;
    output reg loadA, loadB, select, shift;
    reg [4:0] cycles;

    always @(posedge clock, negedge reset) begin
        if(reset == 1'b0)
            cycles <= 5'd0;
        else if(cycles >= 5'd8)
            cycles <= 5'd0;
        else
            cycles <= cycles + 1;
    end

    always @(cycles) begin
        if(cycles == 5'd0) begin
            loadA = 1'b1;
            loadB = 1'b0;
            select = 1'b0;
            shift = 1'b0;
        end
        else if(cycles == 5'd1) begin
            loadA = 1'b0;
            loadB = 1'b1;
            select = 1'b0;
            shift = 1'b0;
        end
        else begin
            loadA = 1'b0;
            loadB = 1'b0;
            if(lsb == 1'b0) begin
                select = 1'b0;
                shift = 1'b1;
            end
            else begin
                select = 1'b1;
                shift = 1'b1;
            end
        end
    end

endmodule

module p3_multiplier_jdl25175(clock, reset, bus_in, multiplicand, product);
    input         clock;
    input         reset;
    input   [7:0] bus_in;
    output  [7:0] multiplicand;
    output [15:0] product;

    wire loadA, loadB, select, shift, carry;
    wire [16:0] shiftRegOut;
    wire [7:0] sum;
    wire [16:0] mux1Out, mux2Out;

    adder_8bit_jdl25175 adder(multiplicand, shiftRegOut[15:8], carry, sum);
    reg_8bit_jdl25175 multpcnd(clock, reset, loadA, bus_in, multiplicand);

    mux2to1_17bit_jdl25175 mux1(select, {shiftRegOut}, {carry, sum, shiftRegOut[7:0]}, mux1Out),
                           mux2(loadB, mux1Out, {9'b0, bus_in}, mux2Out);

    shiftreg_17bit_jdl25175 shiftReg(clock, reset, 1'b1, shift, mux2Out, shiftRegOut);

    multiply_controller_jdl25175 cntrl(clock, reset, mux2Out[0], loadA, loadB, select, shift);

    assign product = shiftRegOut[15:0];

endmodule

module tb_p3_jdl25175();
    reg clock;
    reg reset;
    reg [7:0] bus_in;

    wire [7:0] multiplicand;
    wire [15:0] product;

    p3_multiplier_jdl25175 mult(clock, reset, bus_in, multiplicand, product);

    initial begin
        reset = 1'b1;
        #5;
        reset = 1'b0;
        #5;
        reset = 1'b1;
        #5;
        clock = 1'b0;
        forever
            #10 clock = ~clock;
    end

    initial begin
        #15;

        //Test bit-wise OR
        bus_in = 8'd5;
        #20;
        bus_in = 8'd7;
        #40;

        // //Test bit-wise AND
        // bus_in = 8'd1;
        // #20;
        // bus_in = 8'd2;
        // #40;
        
        // //Test addition
        // bus_in = 8'd1;
        // #20;
        // bus_in = 8'd2;
        // #40;

        // //Test subtraction
        // bus_in = 8'd1;
        // #20;
        // bus_in = 8'd1;
        // #40;
    end

endmodule