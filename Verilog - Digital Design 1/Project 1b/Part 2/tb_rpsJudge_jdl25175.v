////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_rpsJudge_jdl25175.v
// Author:      Jonathan Lemarroy
// Date:        2 October 2020
// Version:     1
// Description: This file contains the benchmark for testing the rpsJudge_continuous_jdl2517 module
////////////////////////////////////////////////////////////////////////////////////////////////////

// Time Unit = 1 ns (#1 = 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

//Definitions to make the code readable
`ifndef NAME_MAPPINGS
`define NAME_MAPPINGS

`define ROCK 3'b001
`define PAPER 3'b010
`define SCISSORS 3'b011
`define LIZARD 3'b100
`define SPOCK 3'b101

`endif

module tb_rpsJudge_jdl25175();

    reg [2:0] player1, player2;
    wire p1Win, p2Win, tie;

    rpsJudge_continuous_jdl25175 game(player1, player2, p1Win, p2Win, tie);

    initial begin

        //Checks against tied combinations
        player1 = `ROCK; //Rock vs Rock
        player2 = `ROCK;
        #50;
        player1 = `PAPER; //Paper vs Paper
        player2 = `PAPER;
        #50;
        player1 = `SCISSORS; //Scissors vs Scissors
        player2 = `SCISSORS;
        #50;
        player1 = `LIZARD; //Lizard vs Lizard
        player2 = `LIZARD;
        #50;
        player1 = `SPOCK; //Spock vs Spock
        player2 = `SPOCK;
        #50;

        //Checks for combinations that player1 should win
        player1 = `ROCK; //Rock vs Scissors
        player2 = `SCISSORS;
        #50;
        player2 = `LIZARD; //Rock vs Lizard
        #50;
        player1 = `PAPER; //Paper vs Rock
        player2 = `ROCK;
        #50;
        player2 = `SPOCK; //Paper vs Spock
        #50;
        player1 = `SCISSORS; //Scissors vs Paper
        player2 = `PAPER;
        #50;
        player2 = `LIZARD; //Scissors vs Lizard
        #50;
        player1 = `LIZARD; //Lizard vs Paper
        player2 = `PAPER;
        #50;
        player2 = `SPOCK; //Lizard vs Spock
        #50;
        player1 = `SPOCK; //Spock vs Rock
        player2 = `ROCK;
        #50;
        player2 = `SCISSORS; //Spock vs Scissors
        #50;

        //Checks for combinations that player2 should win
        player2 = `ROCK; //Rock vs Scissors
        player1 = `SCISSORS;
        #50;
        player1 = `LIZARD; //Rock vs Lizard
        #50;
        player2 = `PAPER; //Paper vs Rock
        player1 = `ROCK;
        #50;
        player1 = `SPOCK; //Paper vs Spock
        #50;
        player2 = `SCISSORS; //Scissors vs Paper
        player1 = `PAPER;
        #50;
        player1 = `LIZARD; //Scissors vs Lizard
        #50;
        player2 = `LIZARD; //Lizard vs Paper
        player1 = `PAPER;
        #50;
        player1 = `SPOCK; //Lizard vs Spock
        #50;
        player2 = `SPOCK; //Spock vs Rock
        player1 = `ROCK;
        #50;
        player1 = `SCISSORS; //Spock vs Scissors
        #50;
    end

endmodule
                       