module project4Top(CLOCK_50, KEY, SW, LED, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input        CLOCK_50;
	input  [3:0] KEY;
	input  [9:0] SW;
	output [9:0] LED;
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

	reg stopped = 1'b1;
	reg toggle = 1'b0;
	reg mode = 1'b0;
	reg tempEnabled = 1'b0;
	reg clearSig = 1'b1;
	reg clearSig2 = 1'b1;

	reg [2:0] timer = 3'd5;
	reg 	  runTimer = 1'b0;

	reg [3:0] outputMode = 4'd5;

	wire [3:0]  minutes;
	wire [2:0]  secondTens;
	wire [3:0] 	secondOnes;
	wire [3:0]	secondTenths;

	wire [3:0]  minutes2;
	wire [2:0]  secondTens2;
	wire [3:0] 	secondOnes2;
	wire [3:0]	secondTenths2;

	reg [3:0]  	fmins = 4'b0;
	reg [2:0]  	fsecTens = 3'b0;
	reg [3:0]   fsecOnes = 4'b0;
	reg [3:0]   fsecTenths = 4'b0;

	reg [3:0]  	tmins = 4'b0;
	reg [2:0]  	tsecTens = 3'b0;
	reg [3:0]   tsecOnes = 4'b0;
	reg [3:0]   tsecTenths = 4'b0;

	wire [3:0]	  tenths;
	wire [2:0]	  bOut;
	
	buttonpressed bp1(CLOCk_50, KEY[3], KEY[0], bOut[0]), 
				  bp2(CLOCk_50, KEY[3], KEY[1], bOut[1]), 
				  bp3(CLOCk_50, KEY[3], KEY[2], bOut[2]);

	secondTenthsTimer basicTimer(CLOCK_50, tenths);

	tenMinTimer tenMinTimer1(tenths, stopped, clearSig, minutes, secondTens, secondOnes, secondTenths),
				tenMinTimer2(tenths, stopped, clearSig2, minutes2, secondTens2, secondOnes2, secondTenths2);

	hexdriver hxdr0(fsecTenths, HEX0), hxdr1(fsecOnes, HEX1), hxdr2(fsecTens, HEX2), hxdr3(fmins, HEX3), hxdr4(outputMode, HEX4);

	always @(KEY[3] or bOut) begin
		if(KEY[3] == 1'b0) begin
			stopped = 1'b1;
			toggle = 1'b0;
			mode = 1'b0;
			tempEnabled = 1'b0;
			timer = 3'd5;
			runTimer = 1'b0;
			outputMode = 4'd5;
			clearSig = 1'b0;
			clearSig2 = 1'b0;
		end
		else if(bOut[0] == 1'b1) begin
			if(stopped == 1'b0)
				stopped = 1'b1;
			else begin
				clearSig = 1'b0;
				clearSig2 = 1'b0;
			end
		end
		else if(bOut[1] == 1'b1) begin
			if(stopped == 1'b1)
				stopped = 1'b0;
			else begin
				tempEnabled = 1'b1;
				runTimer = 1'b1;
			end
		end
		else if(bOut[2] == 1'b1) begin
			mode <= ~mode;
		end
		else
			clearSig = 1'b1;
			clearSig2 = 1'b1;
	end

	always @(tenths) begin
		if(tempEnabled) begin
			if(toggle == 1'b1)
				outputMode = 4'd11;
			else begin
				if(mode == 1'b0)
					outputMode = 4'd5;
				else
					outputMode = 4'd10;
			end
			fmins = tmins;
			fsecTens = tsecTens;
			fsecOnes = tsecOnes;
			fsecTenths = tsecTenths;
			if(timer == 3'b0) begin
				tempEnabled = 1'b0;
				runTimer = 1'b0;
				timer = 4'd5;
			end
		end
		else if(stopped == 1'b0) begin
			if(toggle == 1'b1)
				outputMode = 4'd11;
			else begin
				if(mode == 1'b0)
					outputMode = 4'd5;
				else
					outputMode = 4'd10;
			end
			if(mode == 1'b0) begin
				outputMode = 4'd5;
				fmins = minutes;
				fsecTens = secondTens;
				fsecOnes = secondOnes;
				fsecTenths = secondTenths;
			end
			else begin
				outputMode = 4'd10;
				fmins = minutes2;
				fsecTens = secondTens2;
				fsecOnes = secondOnes2;
				fsecTenths = secondTenths2;
			end
			
		end
		else begin
			if(mode == 1'b0) begin
				outputMode = 4'd5;
				fmins = minutes;
				fsecTens = secondTens;
				fsecOnes = secondOnes;
				fsecTenths = secondTenths;
			end
			else begin
				outputMode = 4'd10;
				fmins = minutes2;
				fsecTens = secondTens2;
				fsecOnes = secondOnes2;
				fsecTenths = secondTenths2;
			end
		end
	end

	always @(tenths) begin
		if(tenths == 4'd9) begin
			if(runTimer)
				timer <= timer - 3'b1;
			toggle <= ~toggle;
		end		
	end
		
endmodule
