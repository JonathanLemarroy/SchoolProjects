////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    ALU.v
// Author:      Jonathan Lemarroy
// Date:        12/8/2020
// Version:     1
// Description: This file contains the ALU described in the project 5 spec
////////////////////////////////////////////////////////////////////////////////////////////////////

module ALU_jdl25175(pulse, calculate, opcode, opA, opB, coreOut, opComplete);
    input  pulse, calculate;
    input  [3:0] opcode;
    input  [7:0] opA, opB;
    output [15:0] coreOut;
    output opComplete;

    wire  [15:0] opASE, opBSE, opAZF, opBZF, Ashifted, Rshifted, multiplied;
    wire  shftRight, multComplete;

    SignExtender8To16Bit SE1(opA, opASE), SE2(opB, opBSE);
    ShiftArithmetic_16Bit_Operator AS(opASE, opB[3:0], shftRight, Ashifted);
    ShiftRotational_16Bit_Operator RS({8'b0, opA}, opB[3:0], shftRight, Rshifted);
    Multiplier mult(pulse, calculate, opA, opB, multiplied, multComplete);

    assign coreOut = (opcode == 4'd0) ? (opASE + opBSE) :
                     (opcode == 4'd1) ? (opASE - opBSE) :
                     (opcode == 4'd2) ? (opBSE - opASE) :
                     (opcode == 4'd3) ? (16'b0 - opASE) :
                     (opcode == 4'd4) ? ({8'b0, opA & opB}) :
                     (opcode == 4'd5) ? ({8'b0, opA | opB}) :
                     (opcode == 4'd6) ? ({8'b0, opA ^ opB}) :
                     (opcode == 4'd7) ? ({8'b0, ~opA}) :
                     (opcode == 4'd8) ? Rshifted :
                     (opcode == 4'd9) ? Rshifted :
                     (opcode == 4'd10) ? Ashifted :
                     (opcode == 4'd11) ? Ashifted : 
                     (opcode == 4'd12) ? multiplied : 
                     16'bx;
    
    assign shftRight = (opcode == 4'd8 || opcode == 4'd10) ? 1'b1 :
                       (opcode == 4'd9 || opcode == 4'd11) ? 1'b0 : 
                       1'bx;

    assign opComplete = (opcode == 4'd12) ? multComplete :
                        1'b1;

endmodule


module SignExtender8To16Bit(operand, out);
    input [7:0] operand;
    output [15:0] out;
    assign out = {{8{operand[7]}}, operand[7:0]};
endmodule

module ShiftArithmetic_16Bit_Operator(operand, shift, right, result);
    input [15:0] operand;
    input [3:0] shift;
    input right;
    output [15:0] result;

    assign result = (shift == 4'd0) ? operand :
                    (shift == 4'd1 && right) ? {{1{operand[15]}}, operand[15:1]}:
                    (shift == 4'd1 && ~right) ? {operand[14:0], 1'b0}:
                    (shift == 4'd2 && right) ? {{2{operand[15]}}, operand[15:2]}:
                    (shift == 4'd2 && ~right) ? {operand[13:0], 2'b0}:
                    (shift == 4'd3 && right) ? {{3{operand[15]}}, operand[15:3]}:
                    (shift == 4'd3 && ~right) ? {operand[12:0], 3'b0}:
                    (shift == 4'd4 && right) ? {{4{operand[15]}}, operand[15:4]}:
                    (shift == 4'd4 && ~right) ? {operand[11:0], 4'b0}:
                    (shift == 4'd5 && right) ? {{5{operand[15]}}, operand[15:5]}:
                    (shift == 4'd5 && ~right) ? {operand[10:0], 5'b0}:
                    (shift == 4'd6 && right) ? {{6{operand[15]}}, operand[15:6]}:
                    (shift == 4'd6 && ~right) ? {operand[9:0], 6'b0}:
                    (shift == 4'd7 && right) ? {{7{operand[15]}}, operand[15:7]}:
                    (shift == 4'd7 && ~right) ? {operand[8:0], 7'b0}:
                    (shift == 4'd8 && right) ? {{8{operand[15]}}, operand[15:8]}:
                    (shift == 4'd8 && ~right) ? {operand[7:0], 8'b0}:
                    (shift == 4'd9 && right) ? {{9{operand[15]}}, operand[15:9]}:
                    (shift == 4'd9 && ~right) ? {operand[6:0], 9'b0}:
                    (shift == 4'd10 && right) ? {{10{operand[15]}}, operand[15:10]}:
                    (shift == 4'd10 && ~right) ? {operand[5:0], 10'b0}:
                    (shift == 4'd11 && right) ? {{11{operand[15]}}, operand[15:11]}:
                    (shift == 4'd11 && ~right) ? {operand[4:0], 11'b0}:
                    (shift == 4'd12 && right) ? {{12{operand[15]}}, operand[15:12]}:
                    (shift == 4'd12 && ~right) ? {operand[3:0], 12'b0}:
                    (shift == 4'd13 && right) ? {{13{operand[15]}}, operand[15:13]}:
                    (shift == 4'd13 && ~right) ? {operand[2:0], 13'b0}:
                    (shift == 4'd14 && right) ? {{14{operand[15]}}, operand[15:14]}:
                    (shift == 4'd14 && ~right) ? {operand[1:0], 14'b0}:
                    (shift == 4'd15 && right) ? {{15{operand[15]}}, operand[15]}:
                    (shift == 4'd15 && ~right) ? {operand[0], 15'b0}: 16'bx;
endmodule

module ShiftRotational_16Bit_Operator(operand, shift, right, result);
    input [15:0] operand;
    input [3:0] shift;
    input right;
    output [15:0] result;

    assign result = (shift == 4'd0) ? operand :
                    (shift == 4'd1 && right) ? {operand[0], operand[15:1]} :
                    (shift == 4'd1 && ~right) ? {operand[14:0], operand[15]} :
                    (shift == 4'd2 && right) ? {operand[1:0], operand[15:2]} :
                    (shift == 4'd2 && ~right) ? {operand[13:0], operand[15:14]} :
                    (shift == 4'd3 && right) ? {operand[2:0], operand[15:3]} :
                    (shift == 4'd3 && ~right) ? {operand[12:0], operand[15:13]} :
                    (shift == 4'd4 && right) ? {operand[3:0], operand[15:4]} :
                    (shift == 4'd4 && ~right) ? {operand[11:0], operand[15:12]} :
                    (shift == 4'd5 && right) ? {operand[4:0], operand[15:5]} :
                    (shift == 4'd5 && ~right) ? {operand[10:0], operand[15:11]} :
                    (shift == 4'd6 && right) ? {operand[5:0], operand[15:6]} :
                    (shift == 4'd6 && ~right) ? {operand[9:0], operand[15:10]} :
                    (shift == 4'd7 && right) ? {operand[6:0], operand[15:7]} :
                    (shift == 4'd7 && ~right) ? {operand[8:0], operand[15:9]} :
                    (shift == 4'd8 && right) ? {operand[7:0], operand[15:8]} :
                    (shift == 4'd8 && ~right) ? {operand[7:0], operand[15:8]} :
                    (shift == 4'd9 && right) ? {operand[8:0], operand[15:9]} :
                    (shift == 4'd9 && ~right) ? {operand[6:0], operand[15:7]} :
                    (shift == 4'd10 && right) ? {operand[9:0], operand[15:10]} :
                    (shift == 4'd10 && ~right) ? {operand[5:0], operand[15:6]} :
                    (shift == 4'd11 && right) ? {operand[10:0], operand[15:11]} :
                    (shift == 4'd11 && ~right) ? {operand[4:0], operand[15:5]} :
                    (shift == 4'd12 && right) ? {operand[11:0], operand[15:12]} :
                    (shift == 4'd12 && ~right) ? {operand[3:0], operand[15:4]} :
                    (shift == 4'd13 && right) ? {operand[12:0], operand[15:13]} :
                    (shift == 4'd13 && ~right) ? {operand[2:0], operand[15:3]} :
                    (shift == 4'd14 && right) ? {operand[13:0], operand[15:14]} :
                    (shift == 4'd14 && ~right) ? {operand[1:0], operand[15:2]} :
                    (shift == 4'd15 && right) ? {operand[14:0], operand[15]} :
                    (shift == 4'd15 && ~right) ? {operand[0], operand[15:1]} : 16'bx;
endmodule

module RightShiftReg(pulse, shift, load, loadVal, regVal);
    input pulse, load, shift;
    input [16:0] loadVal;
    output reg [16:0] regVal;

    always @(posedge pulse) begin
        if(shift == 1'b1 && load == 1'b1)
            regVal <= {1'b0, loadVal[16:1]};
        else if(load == 1'b1)
            regVal <= loadVal;
        else if(shift == 1'b1)
            regVal <= {1'b0, regVal[16:1]};
    end

endmodule

module Multiplier(pulse, calculate, operandA, operandB, result, complete);
    input pulse, calculate;
    input [7:0] operandA, operandB;
    output [15:0] result;
    output complete;

    wire [16:0] loadVal, regVal;
    wire [8:0] adderResult;
    reg [2:0] cycles;
    wire shift;

    RightShiftReg shftReg(pulse, shift, 1'b1, loadVal, regVal);

    assign adderResult = regVal[15:8] + operandA;
    assign loadVal = (calculate == 1'b0) ? {9'b0, operandB} : 
                     (regVal[0] == 1'b1) ? {adderResult, regVal[7:0]} : regVal;

    assign result = regVal[15:0];
    assign shift = (cycles == 3'b0) ? 1'b0 : 1'b1;
    assign complete = ~shift;

    always @(posedge pulse) begin
        if(calculate == 1'b0)
            cycles <= 3'd7;
        else
            cycles <= cycles - 3'b1;
    end
endmodule
