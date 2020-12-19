module problem6_jdl25175(clock, reset_l, state);
   input        clock;
   input        reset_l;		// SYNCHRONOUS ACTIVE-LOW RESET;
   output [3:0] state;

   reg clr, load, updn;
   reg [3:0] ins;
   wire      carry;

   problem5_jdl25175 mod1(clock, clr, load, 1'b1, updn, ins, state, carry);

   always @(posedge clock) begin
        if(reset_l == 1'b0)
            clr = 1'b1;
        else begin
            clr = 1'b0;
            if(state == 4'b0111) begin
                updn = 1'b1;
                load = 1'b1;
                ins = 4'b1111;
            end
            else if(state == 4'b1000) begin
                updn = 1'b0;
                load = 1'b1;
                ins = 4'b0000;
            end
            else
                load = 1'b0;
        end
   end
   
endmodule