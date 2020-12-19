// Filename:    problem1.v
// Author:      Jonathan Lemarroy
// Date:        06 October 2020
// Version:     1
// Description: I was not able to implement this using only 10 gates. This was written
//              just so the other problems will still compile

module problem1_jdl25175(code, valid);
    input  [4:0] code;
    output       valid;
    wire   [2:0] count;

    assign count = code[4] + code[3] + code[2] + code[1] + code[0];

    assign valid = (count == 3'b010) ? 1'b1 : 1'b0;

endmodule