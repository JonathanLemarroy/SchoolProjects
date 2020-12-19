

module tenMinTimer(tenthsIn, stop, reset, minutes, secondTens, secondOnes, tenthsOut);
	input               reset;      //Active-Low timer reset
    input               stop;       //Active-High timer stop
    input      [3:0]    tenthsIn;

	output reg [3:0]    minutes = 4'b1111;
	output reg [2:0]    secondTens = 3'b111;
    output reg [3:0]    secondOnes = 4'b1111;
    output reg [3:0]    tenthsOut = 4'b1111;

    always @(negedge reset) begin
        minutes = 4'b0;
        secondTens = 3'b0;
        secondOnes = 4'b0;
        tenthsOut = 4'b0;
    end

    always @(tenthsIn) begin
        if(stop == 1'b0)
            tenthsOut <= tenthsOut + 4'b1;
    end

    always @(tenthsOut) begin
        if(tenthsOut >= 4'd10) begin
            secondOnes <= secondOnes + 4'b1;
            tenthsOut <= 4'b0;
        end
    end

    always @(secondOnes) begin
        if(secondOnes >= 4'd10) begin
            secondTens <= secondTens + 3'b1;
            secondOnes <= 4'b0;
        end
    end

    always @(secondTens) begin
        if(secondTens >= 3'd6) begin
            minutes <= minutes + 4'b1;
            secondTens <= 3'b0;
        end
    end

    always @(minutes) begin
        if(minutes >= 4'd10)
            minutes = 4'b0;
    end

endmodule