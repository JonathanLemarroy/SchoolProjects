module problem3_jdl25175(clock, reset_l, load, count, ins, state, carry);
   input        clock;		// System clock
   input        reset_l;	// Asynchronous active-low reset
   input        load;		// Synchronous active-high load enable
   input        count		// Synchronous active-high count enable
   input  [3:0] ins;		// Parallel load inputs
   output [3:0] state;		// Counter state
   output       carry;		// Counter carry-out
   reg    [3:0] state;
   
   always @(posedge clock or negedge reset_l) begin
        if(reset_l == 1'b0)
            state <= 4'b0000;
        else if(load & ~count)
            state <= ins;
        else if(count & ~load)
            state <= state + 1;
        else
            state <= state;
   end
   
   assign carry = count & (state == 4'b1111);

endmodule