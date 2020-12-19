// Filename:    decoder4to10_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is a behavioral 4 to 10 decoder whose default output value is 0
//              unless enable and dec_in pins are correctly active.

module decoder4to10_jdl25175(enable, dec_in, dec_out);
    input           enable; // active-high enable
    input     [3:0] dec_in;	// decoder inputs
    output    [9:0] dec_out;// decoder outputs
    reg       [9:0] temp;   // temporarily holds the decoders output.

    always @(enable, dec_in) begin
        if(enable) begin
            case(dec_in)
                4'b0000: temp = 10'b0000000001;
                4'b0001: temp = 10'b0000000010;
                4'b0010: temp = 10'b0000000100;
                4'b0011: temp = 10'b0000001000;
                4'b0100: temp = 10'b0000010000;
                4'b0101: temp = 10'b0000100000;
                4'b0110: temp = 10'b0001000000;
                4'b0111: temp = 10'b0010000000;
                4'b1000: temp = 10'b0100000000;
                4'b1001: temp = 10'b1000000000;
                default: temp = 10'b0000000000;
            endcase
        end
        else
            temp = 10'b0000000000;
    end

    assign dec_out = temp;
endmodule