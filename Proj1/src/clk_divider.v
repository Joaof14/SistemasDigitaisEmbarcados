module clk_divider(
    input clk,           // Clock de entrada (50 MHz na DE2-115)
    input reset,         // Reset
    output reg slow_clk  // Clock de saída (1 Hz)
);

   
    reg [25:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            slow_clk <= 0;
        end else begin
            if (counter == 26'd09_999_999) begin // 10.000.000 - 1
                counter <= 0;
                slow_clk <= ~slow_clk; // Alterna o clock lento
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule