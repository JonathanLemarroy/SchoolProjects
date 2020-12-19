////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    rpsJudge_continuous_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        2 October 2020
// Version:     1
// Description: This file contains a continuous assignment model using dataflow operators for a 
//              device designed to be the judge of a rock, paper, scissors, lizard, and spock.
////////////////////////////////////////////////////////////////////////////////////////////////////


//Definitions to make the code readable
`ifndef NAME_MAPPINGS
`define NAME_MAPPINGS

`define ROCK 3'b001
`define PAPER 3'b010
`define SCISSORS 3'b011
`define LIZARD 3'b100
`define SPOCK 3'b101

`endif

module rpsJudge_continuous_jdl25175(player1, player2, p1wins, p2wins, tied);
   input  [2:0] player1, player2;
   output       p1wins, p2wins, tied;

   assign tied = (player1 == player2);

   assign p1wins = ({player1, player2} == {`ROCK, `SCISSORS}) ? 1'b1 :
                  ({player1, player2} == {`ROCK, `LIZARD}) ? 1'b1 :
                  ({player1, player2} == {`PAPER, `ROCK}) ? 1'b1 :
                  ({player1, player2} == {`PAPER, `SPOCK}) ? 1'b1 :
                  ({player1, player2} == {`SCISSORS, `PAPER}) ? 1'b1 :
                  ({player1, player2} == {`SCISSORS, `LIZARD}) ? 1'b1 :
                  ({player1, player2} == {`LIZARD, `PAPER}) ? 1'b1 :
                  ({player1, player2} == {`LIZARD, `SPOCK}) ? 1'b1 :
                  ({player1, player2} == {`SPOCK, `ROCK}) ? 1'b1 :
                  ({player1, player2} == {`SPOCK, `SCISSORS}) ? 1'b1 : 1'b0;

   assign p2wins = ~(p1wins | tied);

endmodule
