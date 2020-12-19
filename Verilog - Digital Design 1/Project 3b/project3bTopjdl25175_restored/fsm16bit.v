////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename:    fsm16bit.v
// Author:      Jason Thweatt
// Date:        24 March 2015
// Version:     2 (28 March 2017)
// Description: A 16-bit synchronous FSM as a starting point for Project 3.
//              Requires separate keypress state machine by T. Martin
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fsm16bit(clock, reset, enable, check, mode, direction, value, count);
	input         clock;
	input         reset;
	input         enable;
	input         check;
	input         mode;
	input         direction;
	input   [3:0] value;
	output [15:0] count;

	reg    [15:0] counter_state;
	
// MODIFY THE STATE MACHINE ALWAYS BLOCK APPROPRIATELY TO IMPLEMENT YOUR VERSION OF THE FSM.
// UPDATE THE COMMENTS ACCORDINGLY. DELETE THESE COMMENTS IN ALL CAPS.
	
// STATE MACHINE: This always block represents sequential logic, so it uses non-blocking assignments.
// It is sensitized to appropriate edges of the clock input and the clear input.
// You should picture this always block as a 16-bit register with an active-low asynchronous clear, plus the
// logic needed to derive the correct next state from the present state and the inputs.

	always @(posedge clock or negedge reset) begin

	// If a negative edge occured on reset, then reset must equal 0.
	// Since the effect of the reset occurs in the absence of a clock edge, this reset is ASYNCHRONOUS.
	// Release reset to permit synchronous behavior of the counter.

		if(reset == 1'b0)
			counter_state <= 16'b0;

	// If reset is not 0 but this always block is executing anyway, there must have been a positive clock edge.
	// On each positive clock edge where enable is asserted, update the counter state based on the counter state
	//	and the values of check, mode, direction, and value.

		
		else if(enable) begin
			if(check) begin
				if(mode) begin		
					if(direction)
						counter_state <= {counter_state[0], counter_state[15:1]};
					else 
						counter_state <= {counter_state[14:0], counter_state[15]};		
				end
				else begin
					if(direction)
						counter_state <= counter_state - {12'b0, value[3:0]};
					else 
						counter_state <= counter_state + {12'b0, value[3:0]};	
				end
			end
			else
				counter_state <= 16'h4732;
		end
		else
			counter_state <= counter_state;
	end
	
// OUTPUT MACHINE: Since the output is always the same as the FSM state, assign the present state to the output.
// The output machine is combinational logic. A continuous assignment represents combinational logic.
// In a more complex FSM, the output machine would have consisted of an always block.
// Since the output machine represents combinational logic, this always block would have used blocking assignments.

// You should not need to modify this continuous assignment. 
// Changing counter_state in the state machine will change the output machine directly.

	assign count = counter_state; 

endmodule
