// Filename:    problem7.v
// Author:      Jonathan Lemarroy
// Date:        06 October 2020
// Version:     1
// Description: This circuit maps a hexidecimal input to a seven-segment display.
//              This is the procedural implementation.

module sevensegdecoder_proc_jdl25175(hex_digit, hex_display);
    input  [3:0] hex_digit;
    output [6:0] hex_display;
    reg    [6:0] temp;

    always @(hex_digit) begin
        case(hex_digit)
            4'h0    : temp <= 7'b0000000;
            4'h1    : temp <= 7'b1111001;
            4'h2    : temp <= 7'b0100110;
            4'h3    : temp <= 7'b0110000;
            4'h4    : temp <= 7'b0011001;
            4'h5    : temp <= 7'b0010010;
            4'h6    : temp <= 7'b0000010;
            4'h7    : temp <= 7'b1111000;
            4'h8    : temp <= 7'b0000000;
            4'h9    : temp <= 7'b0010000;
            4'hA    : temp <= 7'b0001000;
            4'hB    : temp <= 7'b0000011;
            4'hC    : temp <= 7'b1000110;
            4'hD    : temp <= 7'b0100001;
            4'hE    : temp <= 7'b0000110;
            4'hF    : temp <= 7'b0001110;
            default : temp <= 7'b1111111;
        endcase
    end
    
    assign hex_display = temp;

endmodule
