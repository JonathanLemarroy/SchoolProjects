////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    problem2.v
// Author:      Jonathan Lemarroy
// Date:        12/5/2020
// Version:     1
// Description: This file is the working solution to problem 2 of HW 7
////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module alu_core_jdl25175(opcode, opA, opB, core_out);
   input  [3:0] opcode;
   input  [7:0] opA, opB;
   output [7:0] core_out;

   assign core_out = (opcode == 4'd0) ? (opA + opB) :
                     (opcode == 4'd1) ? (opA - opB) :
                     (opcode == 4'd2) ? (opA & opB) :
                     (opcode == 4'd3) ? (opA | opB) :
                     4'd0;

endmodule

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

module alu_controller_jdl25175(clock, reset, loadOp, loadA, loadB, loadOut);
    input  clock;
    input  reset;
    output loadOp, loadA, loadB, loadOut;
    reg    loadOp, loadA, loadB, loadOut;

    reg [1:0] cycles;

    wire out;

    always @(posedge clock or negedge reset) begin
        if(reset == 1'b0) begin
            cycles <= 2'b00;
        end
        else begin
            cycles <= cycles + 2'b1;
        end
    end

    always @(cycles) begin
        if(cycles == 2'b00) begin
            loadOp = 1'b1;
            loadA = 1'b0;
            loadB = 1'b0;
            loadOut = 1'b0;
        end
        else if(cycles == 2'b01) begin
            loadOp = 1'b0;
            loadA = 1'b1;
            loadB = 1'b0;
            loadOut = 1'b0;
        end
        else if(cycles == 2'b10) begin
            loadOp = 1'b0;
            loadA = 1'b0;
            loadB = 1'b1;
            loadOut = 1'b0;
        end
        else begin
            loadOp = 1'b0;
            loadA = 1'b0;
            loadB = 1'b0;
            loadOut = 1'b1;
        end
    end
endmodule

module p2_alu_jdl25175(clock, reset, alu_in, alu_out, regOp, regA, regB, core_out);
    input        clock, reset;
    input  [7:0] alu_in;
    output [7:0] alu_out;
    output [7:0] regOp, regA, regB, core_out;

    wire loadOp, loadA, loadB, loadOut;

    alu_controller_jdl25175 aluCtrl(clock, reset, loadOp, loadA, loadB, loadOut);

    reg_8bit_jdl25175 opReg(clock, reset, loadOp, alu_in, regOp),
                      aReg(clock, reset, loadA, alu_in, regA),
                      bReg(clock, reset, loadB, alu_in, regB),
                      outReg(clock, reset, loadOut, core_out, alu_out);

    alu_core_jdl25175 aluCore(regOp[3:0], regA, regB, core_out);

endmodule


module tb_p2_jdl25175();
    reg clock;
    reg reset;
    reg [7:0] alu_in;

    wire [7:0] alu_out;
    wire [7:0] regOp, regA, regB, core_out;

    p2_alu_jdl25175 ALU(clock, reset, alu_in, alu_out, regOp, regA, regB, core_out);

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
        alu_in = 8'd3;
        #20;
        alu_in = 8'd1;
        #20;
        alu_in = 8'd2;
        #40;

        //Test bit-wise AND
        alu_in = 8'd2;
        #20;
        alu_in = 8'd1;
        #20;
        alu_in = 8'd2;
        #40;

        //Test addition
        alu_in = 8'd0;
        #20;
        alu_in = 8'd1;
        #20;
        alu_in = 8'd2;
        #40;

        //Test subtraction
        alu_in = 8'd1;
        #20;
        alu_in = 8'd1;
        #20;
        alu_in = 8'd1;
        #40;
    end

endmodule