`timescale 10 ns/10 ns

module tb_tenMinTimer();
    reg         CLOCK_50;
    wire [3:0]  secondTenths;
    wire [3:0]  minutes;
	wire [2:0]  secondTens;
    wire [3:0]  secondOnes;
    wire [3:0]  tenthsOut;

    initial begin
        forever begin
            CLOCK_50 = 1'b1;
            #1;
            CLOCK_50 = 1'b0;
            #1;
        end
    end

    secondTenthsTimer basicTimer(CLOCK_50, secondTenths);

    tenMinTimer tenMinTimer(secondTenths, 1'b0, 1'b1, minutes, secondTens, secondOnes, tenthsOut);

endmodule