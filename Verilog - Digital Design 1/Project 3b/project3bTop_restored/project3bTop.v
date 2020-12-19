////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: project3bTop.v
// Author:   Jason Thweatt
// Date:     24 March 2015
// Revision: 3 (29 October 2019)
//
// This is the top-level module for ECE 3544 Project 3b.
// Do not modify the module declaration or ports in this file.
// When synthesizing to the DE1-SoC, this file should be used with the provided
// Quartus project so that the FPGA pin assignments are made correctly.
//
// YOU MUST MAKE THE PIN ASSIGNMENTS FOR THE INPUTS AND OUTPUTS OF THIS MODULE.
// FOLLOW THE INSTRUCTIONS IN THE DOCUMENT ON PIN PLACEMENT.
// CONSULT THE DE1-SOC MANUAL FOR INFORMATION ON THE PIN LOCATIONS.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MODIFY THE TOP-LEVEL MODULE APPROPRIATELY TO COMPLETE YOUR BOARD-LEVEL IMPLEMENTATION.
// UPDATE THE COMMENTS ACCORDINGLY. DELETE THESE COMMENTS IN ALL CAPS.

module project3bTop(CLOCK_50, SW, KEY, HEX3, HEX2, HEX1, HEX0, LED);
   input         CLOCK_50; // 50 MHz FPGA Clock
   input   [6:0] SW;       // Switch SW[6] checks the Student ID Number.
                           // Switch SW[5] determines the mode.
                           // Switch SW[4] determines the direction.
                           // Switch SW[3:0] determines the count value.
   input   [1:0] KEY;      // KEY[1] is the system reset.
                           // KEY[0] provides the enable input
   output  [6:0] HEX3;		// These are the seven-segment display driver outputs.
	output  [6:0] HEX2; 
	output  [6:0] HEX1;
	output  [6:0] HEX0;
	output  [6:0] LED;		// Use the LEDs to view the switch values.

   wire          enable;   // The buttonpressed pulse_out drives the FSM enable input.
   wire   [15:0] count;    // The FSM output should drive the seven-segment display driver inputs.

// Display the switches on the corresponding LEDs.	
	
	assign LED = SW;
	
// The top-level module instantiates two sub-modules - the buttonpressed and fsm16bit modules.
// The buttonpressed module maps KEY[0] to a one clock-period long enable pulse.
// The fsm16bit module uses the enable pulse and the switch inputs to determine its next synchronous state.
	hexdriver hx1(count[15:12], HEX3), hx2(count[11:8], HEX2), hx3(count[7:4], HEX1), hx4(count[3:0], HEX0);
	buttonpressed U1(CLOCK_50, KEY[1], KEY[0], enable);
   fsm16bit      U2(CLOCK_50, KEY[1], enable, SW[6], SW[5], SW[4], SW[3:0], count); 
   
endmodule
