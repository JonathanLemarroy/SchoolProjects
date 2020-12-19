module problem2_jdl25175(clock, reset_l, count, state, carry);
   input        clock;		// System clock
   input        reset_l;	// Asynchronous active-low reset	
   input        count;		// Synchronous active-high count enable
   output [3:0] state;		// Counter state
   output       carry;		// Counter carry-out
   reg    [3:0] state;
   
    always @(posedge clock or negedge reset_l) begin
        if(reset_l == 1'b0)
            state <= 4'b0000;
        else if(count) begin
            if(state == 4'b1001)
                state <= 4'b0000;
            else
                state <= state + 1'b1;
        else
            state <= state;
        end
    end
    assign carry = (state == 4'b1001) && count;

endmodule