// Filename:    decoder4to16_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is a behavioral 4 to 16 decoder whose default output value is 0
//              unless enable and dec_in pins are correctly active.

module decoder4to16_jdl25175(enable, dec_in, dec_out);
    input           enable; // active-high enable
    input     [3:0] dec_in;	// decoder inputs
    output   [15:0] dec_out;// decoder outputs
    reg      [15:0] temp;

    always @(enable, dec_in) begin
        if(enable) begin
            case(dec_in)
                4'b0000: temp = 16'b0000000000000001;
                4'b0001: temp = 16'b0000000000000010;
                4'b0010: temp = 16'b0000000000000100;
                4'b0011: temp = 16'b0000000000001000;
                4'b0100: temp = 16'b0000000000010000;
                4'b0101: temp = 16'b0000000000100000;
                4'b0110: temp = 16'b0000000001000000;
                4'b0111: temp = 16'b0000000010000000;
                4'b1000: temp = 16'b0000000100000000;
                4'b1001: temp = 16'b0000001000000000;
                4'b1010: temp = 16'b0000010000000000;
                4'b1011: temp = 16'b0000100000000000;
                4'b1100: temp = 16'b0001000000000000;
                4'b1101: temp = 16'b0010000000000000;
                4'b1110: temp = 16'b0100000000000000;
                4'b1111: temp = 16'b1000000000000000;
                default: temp = 16'b0000000000000000;
            endcase
        end
        else
            temp = 16'b0000000000000000;
    end

    assign dec_out = temp;
endmodule