// Filename:    problem6_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is the solution to Problem 6, which implements a
//              circuit designed to add a parity bit on the end;

module problem6_jdl25175(parity_control, input_word, output_word);
    input        parity_control;	// 0 - even, 1 - odd
    input  [7:0] input_word;
    output [8:0] output_word;
    wire         odd, parityBit;
    assign odd = ((input_word[0] ^ input_word[1]) ^ (input_word[2] ^ input_word[3])) ^
                 ((input_word[4] ^ input_word[5]) ^ (input_word[6] ^ input_word[7]));
    
    assign parityBit = odd ^ parity_control;
    assign output_word = {input_word, parityBit};

endmodule
