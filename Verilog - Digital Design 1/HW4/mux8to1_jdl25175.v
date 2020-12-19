// Filename:    mux8to1_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        15 October 2020
// Version:     1
// Description: This is a behavioral 8 to 1 multiplexer whose default value is 0
//              unless enable and select pins are correctly active.

module mux8to1_jdl25175(enable, select, mux_in, mux_out);
    input       enable;		// active-high enable
    input [2:0] select;		// multiplexer select lines
    input [7:0] mux_in;		// multiplexer input lines
    output      mux_out;	// multiplexer output
    reg         temp;

    always @(enable, select, mux_in) begin
        if(enable) begin
            case(select)
                3'b000: temp = mux_in[0];
                3'b001: temp = mux_in[1];
                3'b010: temp = mux_in[2];
                3'b011: temp = mux_in[3];
                3'b100: temp = mux_in[4];
                3'b101: temp = mux_in[5];
                3'b110: temp = mux_in[6];
                3'b111: temp = mux_in[7];
                default: temp = 1'b0;
            endcase
        end
        else
            temp = 1'b0;
    end
    
    assign mux_out = temp;
endmodule