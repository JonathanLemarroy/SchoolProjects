////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    problem1.v
// Author:      Jonathan Lemarroy
// Date:        12/5/2020
// Version:     1
// Description: This file is the working solution to problem 1 of HW 7
////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module full_adder_jdl25175(a, b, ci, s, co);
    input  a, b, ci;
    output s, co;

    assign #20 s = a ^ b ^ ci;
    assign #20 co = (a & b) | (b & ci) | (a & ci);

endmodule

module p1_rca_jdl25175(A, B, S, Cout);

// Remember: C0 = 0.
// You can make this connection at this level of the model.

    input  [7:0] A, B;
    output [7:0] S;
    output       Cout;	// Which of the carry-out bits is last?

    wire   [6:0] c;

    full_adder_jdl25175 adder0(A[0], B[0], 1'b0, S[0], c[0]),
                        adder1(A[1], B[1], c[0], S[1], c[1]),
                        adder2(A[2], B[2], c[1], S[2], c[2]),
                        adder3(A[3], B[3], c[2], S[3], c[3]),
                        adder4(A[4], B[4], c[3], S[4], c[4]),
                        adder5(A[5], B[5], c[4], S[5], c[5]),
                        adder6(A[6], B[6], c[5], S[6], c[6]),
                        adder7(A[7], B[7], c[6], S[7], Cout);
endmodule

module prop_gen_jdl25175(a, b, p, g);
    input  a, b;
    output p, g;

    assign #20 g = a & b;
    assign #20 p = a ^ b;

endmodule

module cl_block_jdl25175(P, G, C);
    input  [7:0] P, G;
    output [8:1] C;		// C0 = 0. It doesn’t need an equation. 

    assign #20 C[1] = G[0];
    assign #20 C[2] = G[1] | (P[1] & G[0]);
    assign #20 C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]);
    assign #20 C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
    assign #20 C[5] = G[4] | (P[4] & G[3]) | (P[4] & P[3] & G[2]) | (P[4] & P[3] & P[2] & G[1]) | (P[4] & P[3] & P[2] & P[1] & G[0]);

    assign #20 C[6] = G[5] | (P[5] & G[4]) | (P[5] & P[4] & G[3]) | (P[5] & P[4] & P[3] & G[2]) 
    | (P[5] & P[4] & P[3] & P[2] & G[1]) | (P[5] & P[4] & P[3] & P[2] & P[1] & G[0]);

    assign #20 C[7] = G[6] | (P[6] & G[5]) | (P[6] & P[5] & G[4]) | (P[6] & P[5] & P[4] & G[3]) 
    | (P[6] & P[5] & P[4] & P[3] & G[2]) | (P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) | (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]);

    assign #20 C[8] = G[7] | (P[7] & G[6]) | (P[7] & P[6] & G[5]) | (P[7] & P[6] & P[5] & G[4]) | (P[7] & P[6] & P[5] & P[4] & G[3]) 
    | (P[7] & P[6] & P[5] & P[4] & P[3] & G[2]) | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]);

endmodule

module sum_block_jdl25175(P, C, S);

// Remember, C0 is still 0.
// You can make this connection at this level of the model.
    input  [7:0] P;
    input  [7:1] C;
    output [7:0] S;

    assign #20 S[0] = P[0];
    assign #20 S[1] = P[1] ^ C[1];
    assign #20 S[2] = P[2] ^ C[2];
    assign #20 S[3] = P[3] ^ C[3];
    assign #20 S[4] = P[4] ^ C[4];
    assign #20 S[5] = P[5] ^ C[5];
    assign #20 S[6] = P[6] ^ C[6];
    assign #20 S[7] = P[7] ^ C[7];

endmodule

module p1_cla_jdl25175(A, B, S, Cout);
    input  [7:0] A, B;
    output [7:0] S;
    output       Cout;	// Which of the carry-out bits is last?
    
    wire [7:0] P;
    wire [7:0] G;
    wire [8:1] C;

    prop_gen_jdl25175 propGen0(A[0], B[0], P[0], G[0]),
                      propGen1(A[1], B[1], P[1], G[1]),
                      propGen2(A[2], B[2], P[2], G[2]),
                      propGen3(A[3], B[3], P[3], G[3]),
                      propGen4(A[4], B[4], P[4], G[4]),
                      propGen5(A[5], B[5], P[5], G[5]),
                      propGen6(A[6], B[6], P[6], G[6]),
                      propGen7(A[7], B[7], P[7], G[7]);

    cl_block_jdl25175 clBlock(P, G, C);

    sum_block_jdl25175 sumBlock(P, C[7:1], S);

    assign Cout = C[8];

endmodule

module tb_p1_jdl25175();
    reg [7:0] opA;
    reg [7:0] opB;

    wire [7:0] claSum;
    wire       claOverflow;
    
    wire [7:0] rcaSum;
    wire       rcaOverflow;

    p1_cla_jdl25175 lookAheadSum(opA, opB, claSum, claOverflow);
    p1_rca_jdl25175 rippleSum(opA, opB, rcaSum, rcaOverflow);

    initial begin
        opA = 8'd0;
        opB = 8'd0;
        #20;
        opA = 8'd255;
        opB = 8'd1;
        #200;
        opA = 8'd23;
        opB = 8'd71;
        #200;
    end

endmodule