////////////////////////////////////////////////////////////////////
// Filename:    tb_state_onehot_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        12 November 2020
// Version:     1
// Description: This is module state_onehot_jdl25175's test bench
///////////////////////////////////////////////////////////////////

// Time Unit = 1 ns (#1 means 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

module tb_state_onehot_jdl25175();
    reg clk, init;
    reg [1:0] in;
    
    wire [1:0] state;
    wire out;

    state_onehot_jdl25175 FSM(clk, init, in, out, state);

    initial begin
        clk = 0;
        while(1'b1) begin
            #10;
            clk = 1;
            #10;
            clk = 0;
        end
    end

    initial begin
        init = 1'b1;
        in = 2'b01;
        init = 1'b0;
        #20;
        init = 1'b1;
        #20;
        in = 2'b00;
        #20;
        in = 2'b10;
        #20;
        in = 2'b00;
        #20;
        in = 2'b11;
        #20;
        in = 2'b00;
        #20;
        in = 2'b11;
        #20;
        in = 2'b00;
        #20;
        in = 2'b01;
        #40;
        in = 2'b11;
        #20;
        in = 2'b10;
        #20;
        in = 2'b00;
        #40;
        in = 2'b10;
        #20;
        in = 2'b00;
        #20;
        in = 2'b11;
        #20;
        in = 2'b00;
        #20;
        in = 2'b11;
        #20;
        in = 2'b01;
        #40;
        in = 2'b11;
        #40;
        in = 2'b00;
        #20;
        in = 2'b01;
        #20;
        in = 2'b00;
        #60;
        in = 2'b10;
        #60;
        in = 2'b00;
        #20;
        in = 2'b10;
        #40;
        in = 2'b00;
        #20;
        in = 2'b11;
        #20;
        in = 2'b01;
        #40;
        in = 2'b00;
        #40;
        in = 2'b11;
        #20;
        in = 2'b10;
        #20;
        in = 2'b11;
        #20;
        in = 2'b00;
        #20;
        in = 2'b01;
        #20;
        in = 2'b00;
        #20;
        in = 2'b10;
        #20;
        in = 2'b00;
        #40;
    end
endmodule