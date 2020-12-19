// Filename:    problem5.v
// Author:      Jonathan Lemarroy
// Date:        06 October 2020
// Version:     1
// Description: This circuit returns valid if exactly 2 bits out of the 5 bit code are 1s.
//              This is the continuous assignment implementation

module problem5_jdl25175(code, valid);
    input  [4:0] code;
    output       valid;
    wire   [2:0] count;

    assign count = code[4] + code[3] + code[2] + code[1] + code[0];

    assign valid = (count == 3'b010) ? 1'b1 : 1'b0;

endmodule