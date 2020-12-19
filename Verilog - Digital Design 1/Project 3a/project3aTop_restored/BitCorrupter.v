////////////////////////////////////////////////////////////////////////////////
// Filename:    BitCorrupter.v
// Author:      Jonathan Lemarroy
// Date:        11/2/2020
// Version:     1
// Description: This is a bit corrupter that complements the bit at the given index
//              Note: the bit flipped assumes starting at index 1 for bit0
////////////////////////////////////////////////////////////////////////////////

module bit_corrupter(index, input_word, output_word);
    input  [2:0] index;
	input  [7:1] input_word;
	output [7:1] output_word; 

    assign output_word[1] = (index == 3'd1) ? ~ input_word[1] : input_word[1];
    assign output_word[2] = (index == 3'd2) ? ~ input_word[2] : input_word[2];
    assign output_word[3] = (index == 3'd3) ? ~ input_word[3] : input_word[3];
    assign output_word[4] = (index == 3'd4) ? ~ input_word[4] : input_word[4];
    assign output_word[5] = (index == 3'd5) ? ~ input_word[5] : input_word[5];
    assign output_word[6] = (index == 3'd6) ? ~ input_word[6] : input_word[6];
    assign output_word[7] = (index == 3'd7) ? ~ input_word[7] : input_word[7];

endmodule