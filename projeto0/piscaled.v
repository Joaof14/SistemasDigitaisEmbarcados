module piscaled(input wire clk, 
    output reg led);


    //Divisor de clk
    parameter CLK_FREQ = 27_000_000; // Frequência padrão do clock (50 MHz)
    parameter BLINK_FREQ = 1;        // Frequência desejada do LED (1 Hz)

    // Cálculo do contador (ajuste conforme necessidade)
    localparam MAX_COUNT = CLK_FREQ / (2 * BLINK_FREQ) - 1;
    reg [24:0] counter = 0; // Ajuste a largura conforme necessário

    always @(posedge clk) begin
        if (counter >= MAX_COUNT) begin
            counter <= 0;
            led <= ~led; // Inverte o estado do LED
        end else begin
            counter <= counter + 1;
        end
    end


endmodule