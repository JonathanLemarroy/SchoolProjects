////////////////////////////////////////////////////////////////////////////////
// Filename: project3aTest.v
// Author:   Jason Thweatt
// Date:     24 October 2017
// Revision: 1
//
// This module is for ECE 3544 Project 3a.
// Do not modify the module declaration or ports in this file.
// It provides an example for a component that the designer can instantiate in
// the top-level module.

module project3aTest(ins, HEX);
    input  [1:0] ins;
    output [6:0] HEX;

    assign HEX = {~ins[0], ins[1] & ins[0], ins[1] | ins[0], ~(ins[1] & ins[0]), ~(ins[1] | ins[0]), ins[1] ^ ins[0], ~(ins[1] ^ ins[0])};

endmodule
