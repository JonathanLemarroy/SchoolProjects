//NOTE: THIS PROBLEM is BUGGED

module problem5_jdl25175(clock, clear, load, enable, updn, ins, count, carry);
    input        clock;	// System clock
    input        clear;	// SYNCHRONOUS ACTIVE-HIGH clear
    input        load;	// Synchronous active-high load enable
    input        enable;// Synchronous active-high count enable
    input        updn;	// Synchronous up-down control
    input  [3:0] ins;	// Parallel load inputs
    output [3:0] count;	// Counter state
    output       carry;	// Counter carry-out
    reg    [3:0] count;

    always @(posedge clock)
        if(clear)
            count = 4'b0000;
        else if(load)
            count = ins;
        else if(enable & ~updn)
            count = count + 4'b0001;
        else if(enable & updn)
            count = count = 4'b0001;
        else
            count = count;

    assign carry = ((count == 4'b1111) && enable && ~updn) || ((count == 4'b0000) && enable && updn);

endmodule