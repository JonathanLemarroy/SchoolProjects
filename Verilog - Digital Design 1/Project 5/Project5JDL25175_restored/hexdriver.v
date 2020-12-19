// Filename:    hexdriver.v
// Author:      Jonathan Lemarroy
// Date:        10 November 2020
// Version:     1
// Description: This implements the seven-segment display driver.

//              ****IMPORTANT**** --> This implements a 7 segement display that
//              is active when logic 0 is applied. The display will enable all
//              segments if digits are z or x.

module hexdriver(digit, hex_display);
    input  [3:0] digit;
    output [6:0] hex_display;

	assign hex_display = (digit == 4'h0) ? 7'b1000000 :
								(digit == 4'h1) ? 7'b1111001 :
								(digit == 4'h2) ? 7'b0100100 :
								(digit == 4'h3) ? 7'b0110000 :
								(digit == 4'h4) ? 7'b0011001 :
								(digit == 4'h5) ? 7'b0010010 :
								(digit == 4'h6) ? 7'b0000010 :
								(digit == 4'h7) ? 7'b1111000 :
								(digit == 4'h8) ? 7'b0000000 :
								(digit == 4'h9) ? 7'b0011000 :
								(digit == 4'hA) ? 7'b0001000 :
								(digit == 4'hB) ? 7'b0000011 :
								(digit == 4'hC) ? 7'b1000110 :
								(digit == 4'hD) ? 7'b0100001 :
								(digit == 4'hE) ? 7'b0000110 :
								(digit == 4'hF) ? 7'b0001110 :
								7'b1111111;
								
endmodule
