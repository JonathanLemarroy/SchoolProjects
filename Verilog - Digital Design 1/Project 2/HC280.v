////////////////////////////////////////////////////////////////////////////////
// Filename:    HC280.v
// Author:      Jonathan Lemarroy
// Date:        10/22/2020
// Version:     1
// Description: This is the HC280 9-bit even/odd parity bit generator.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module hc280_jdl25175(data_in, even, odd);
    input  [8:0] data_in;
    output       even, odd;
    wire         func1, func2, func3;

    parameter evenDelay = 20;
    parameter oddDelay = 23;

    assign func1 = (data_in[0] ^ data_in[1] ^ data_in[2]);
    assign func2 = (data_in[3] ^ data_in[4] ^ data_in[5]);
    assign func3 = (data_in[6] ^ data_in[7] ^ data_in[8]);

    assign even = (func2 ^ func3) ^ ~func1;

    assign odd = (func2 ^ func3) ^ func1;

    specify
        (data_in *> even) = (evenDelay);
        (data_in *> odd) = (oddDelay);
    endspecify

endmodule