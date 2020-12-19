module problem7_jdl25175(clock, reset_l, enable, state, out);
   input        clock;		// System clock
   input        reset_l;	// Asynchronous active-low reset
   input        enable;	    // Synchronous active-high count enable
   output [25:0] state;		// Counter state.
   output       out;		// Output pulse.

   reg   [25:0] state;
   reg          out;    

    always @(posedge clock, negedge reset_l) begin
        if(reset_l == 1'b0)
            state <= 26'b0;
        else if(enable) begin
            if(state == 26'b0) begin
                out <= 1'b1;
                state <= state + 26'b1;
            end
            else if(state == 26'd49999999) begin
                out <= 1'b0;
                state <= 26'b0;
            end
            else begin
                out <= 1'b0;
                state <= state + 26'b1;
            end
        end
        else begin
            state <= 26'b0;
        end
    end

endmodule