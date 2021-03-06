////////////////////////////////////////////////////////////////////////////////
// Modify this header with your name, date, etc.

// Filename: project5Top.v
// Author:   Jonathan Lemarroy
// Date:     12/9/2020
// Revision: 3
// 
// Description: 
// This is the top level module for ECE 3544 Project 5.
// Do not modify the module declarations or ports in this file.
// Make a pin assignment before you program your board with this design!

module project5Top(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED);
	input        CLOCK_50;
	input  [3:0] KEY;
	input  [9:0] SW;
	output [6:0] HEX5;
	output [6:0] HEX4;
	output [6:0] HEX3;
	output [6:0] HEX2;
	output [6:0] HEX1;
	output [6:0] HEX0;
	output [9:0] LED;
	
// You should add your reg/wire/parameter declarations here.
	reg calculate;
	reg [3:0] opcode;
	reg [7:0] opA, opB;
	reg [15:0] result;
	reg [1:0] state;
	wire [15:0] coreOut;
	wire complete, enter;
	wire [7:0] opAIn, opBIn;
//=======================================================
// Module instantiantions
//=======================================================

// You should add your module instances here. You may also add continuous assignments as appropriate.
	buttonpressed btn(CLOCK_50, KEY[0], KEY[1], enter);
	ALU_jdl25175 ALU(enter, calculate, opcode, opAIn, opBIn, coreOut, complete);
	hexdriver hd0(result[3:0], HEX0), hd1(result[7:4], HEX1), hd2(result[11:8], HEX2), hd3(result[15:12], HEX3), hd4(opcode, HEX5);

	assign opAIn = (state == 2'd1) ? SW[7:0] : opA;
	assign opBIn = (state == 2'd2) ? SW[7:0] : opB;
	assign LED = (state == 2'd1) ? {2'b0, SW[7:0]} : {2'b0, opA};

	always @(negedge KEY[0] or posedge enter) begin
		if(KEY[0] == 1'b0) begin
			opcode <= 4'b0;
			opA <= 8'b0;
			opB <= 8'b0;
			state <= 2'b0;
			calculate = 1'b0;
			result <= 15'b0;
		end
		else if(state == 2'd0) begin
			opcode <= SW[3:0];
			state <= 2'd1;
			calculate <= 1'b0;
		end
		else if(state == 2'd1) begin
			opA <= SW[7:0];
			if(opcode == 4'b0011 || opcode == 4'b0111) begin
				state <= 2'd0;
				result <= coreOut;
			end
			else begin
				state <= 2'd2;
			end
		end
		else if(state == 2'd2) begin
			opB <= SW[7:0];
			if(opcode == 4'b1100) begin
				state <= 2'd3;
				result <= SW[7:0];
				calculate <= 1'b1;
			end
			else begin
				state <= 2'd0;
				result <= coreOut;
			end
		end
		else if(state == 2'd3) begin
			result <= coreOut;
			if(complete == 1'b1) begin
				state <=  2'b0;
			end
		end
	end



endmodule
