module secondTenthsTimer(CLOCK_50, secondTenths);
    input               CLOCK_50;
	output reg [3:0]    secondTenths = 4'b0;
    reg [22:0]          ticks = 23'b0;

    always @(posedge CLOCK_50) begin
        if(ticks > 23'd4999999) begin
            ticks <= 23'b0;
            secondTenths <= secondTenths + 4'b1;
        end
        else
            ticks <= ticks + 23'b1;
    end

    always @(secondTenths) begin
        if(secondTenths >= 4'd10) begin
            secondTenths <= 4'b0;
        end
    end
endmodule