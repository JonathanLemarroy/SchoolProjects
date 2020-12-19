////////////////////////////////////////////////////////////////////
// Filename:    state_procedural_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        12 November 2020
// Version:     1
// Description: This is the solution to HW 5 problem 6 state module 
//              representing Problem 2.
///////////////////////////////////////////////////////////////////

module state_procedural_jdl25175(clock, init, in, out, state);
   input        clock;	// System clock
   input        init;	// Asynchronous active-low init
   input  [1:0] in;		// System (two-bit) input
   output reg   out;	// System output

   output reg [1:0] state;	// System state
   reg [1:0] nextState;

    always @(posedge clock or negedge init) begin
        if(init == 1'b0)
            state <= 2'b00;
        else
            state <= nextState;
    end

    always @(in or state) begin
        if(state == 2'b00) begin
            if(in == 2'b11 || in == 2'b10)
                nextState = 2'b01;
            else
                nextState = state;
        end
        else if(state == 2'b01) begin
            if(in == 2'b00)
                nextState = 2'b10;
            else
                nextState = state;
        end
        else if(state == 2'b10) begin
            if(in == 2'b11 || in == 2'b01)
                nextState = 2'b11;
            else
                nextState = state;
        end
        else if(state == 2'b11) begin
            if(in == 2'b00)
                nextState = 2'b00;
            else
                nextState = 2'b10;
        end
        else
            nextState = state;
    end

    always @(state) begin
        if(state == 2'b00)
            out = 1'b0;
        else if(state == 2'b01)
            out = 1'b0;
        else if(state == 2'b10)
            out = 1'b1;
        else if(state == 2'b11)
            out = 1'b1;
        else
            out = 1'bx;
    end

endmodule