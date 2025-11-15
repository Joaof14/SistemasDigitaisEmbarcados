`timescale 1ns/1ps

module test_datapath;
    reg clk, reset;
    reg op, c_ld, c_clr;
    wire z, m;
    wire [15:0] c_out;

    datapath uut (
        .clk(clk),
        .reset(reset),
        .op(op),
        .c_ld(c_ld),
        .c_clr(c_clr),
        .z(z),
        .m(m),
        .c_out(c_out)
    );

    always #5 clk = ~clk; // clock de 10ns

    initial begin
        $dumpfile("../sim/datapath_wave.vcd");
        $dumpvars(0, test_datapath);

        clk = 0;
        reset = 1; op = 0; c_ld = 0; c_clr = 0;
        #20 reset = 0;

        $display("\n=== TESTE DO DATAPATH ===");

        // Teste 1: limpar registrador
        $display("Limpando registrador...");
        c_clr = 1; #10; c_clr = 0;

        // Teste 2: Incrementar 3x
        repeat(3) begin
            op = 0; c_ld = 1; #10; c_ld = 0; #10;
            $display("Incremento: c_out = %d (z=%b, m=%b)", c_out, z, m);
        end

        // Teste 3: Decrementar 2x
        repeat(2) begin
            op = 1; c_ld = 1; #10; c_ld = 0; #10;
            $display("Decremento: c_out = %d (z=%b, m=%b)", c_out, z, m);
        end

        #20;
        $display("=== Fim da simulação ===");
        $finish;
    end
endmodule
