////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_ALU.v
// Author:      Jonathan Lemarroy
// Date:        12/6/2020
// Version:     1
// Description: This file contains the testbench for the ALU described in the project 5 spec
////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module tb_ALU();
    reg [3:0] opcode;
    reg [7:0] opA, opB;
    reg pulse, calculate;
    wire [15:0] coreOut;
    wire opComplete;

    initial begin
        pulse = 1'b0;
        forever begin
            #10;
            pulse = ~pulse;
        end
    end

    ALU_jdl25175 ALU(pulse, calculate, opcode, opA, opB, coreOut, opComplete);

    initial begin
        calculate = 1'b0;
        #5;
        opcode = 4'd0;
        opA = 8'd127;
        opB = 8'd126;
        #20;
        opcode = 4'd1;
        opA = 8'd127;
        opB = 8'd126;
        #20;
        opcode = 4'd2;
        opA = 8'd127;
        opB = 8'd126;
        #20;
        opcode = 4'd3;
        opA = 8'd126;
        opB = 8'd127;
        #20;
        opcode = 4'd4;
        opA = 8'b10101111;
        opB = 8'b01010101;
        #20;
        opcode = 4'd5;
        opA = 8'b11110000;
        opB = 8'b00001111;
        #20;
        opcode = 4'd6;
        opA = 8'b11110110;
        opB = 8'b01101111;
        #20;
        opcode = 4'd7;
        opA = 8'b10101010;
        opB = 8'b00000000;
        #20;
        opcode = 4'd8;
        opA = 8'b11110000;
        opB = 8'b00000011;
        #20;
        opcode = 4'd9;
        opA = 8'b00001111;
        opB = 8'b00000011;
        #20;
        opcode = 4'd10;
        opA = 8'b11110000;
        opB = 8'b00000011;
        #20;
        opcode = 4'd11;
        opA = 8'b00001111;
        opB = 8'b00000011;
        #20;
        calculate = 1'b0;
        opcode = 4'd12;
        opA = 8'd5;
        opB = 8'd10;
        #20;
        calculate = 1'b1;
        #120;
    end

endmodule