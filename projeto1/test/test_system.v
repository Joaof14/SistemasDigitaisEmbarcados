`timescale 1ns/1ps

module test_system;
    reg clk, reset;
    reg u, d;
    wire [15:0] c_out;

    top_system dut(
        .clk(clk),
        .reset(reset),
        .u(u),
        .d(d),
        .c_out(c_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        u = 0;
        d = 0;

        $dumpfile("../sim/system_wave.vcd");
        $dumpvars(0, test_system);

        $display("=== Teste do Sistema Completo ===");

        // Reset inicial
        #20 reset = 0;

        // Teste 1: Pressionar U (deve incrementar)
        $display("Teste 1: Pressionar U");
        u = 1; #30; u = 0; #50;
        $display("C = %d", c_out);

        // Teste 2: Pressionar U novamente
        $display("Teste 2: Segundo U");
        u = 1; #30; u = 0; #50;
        $display("C = %d", c_out);

        // Teste 3: Pressionar D (deve decrementar)
        $display("Teste 3: Pressionar D");
        d = 1; #30; d = 0; #50;
        $display("C = %d", c_out);

        // Teste 4: Tentar decrementar no zero
        $display("Teste 4: Clear e tentar D no zero");
        reset = 1; #20; reset = 0; #20;
        d = 1; #30; d = 0; #50;
        $display("C = %d (deve permanecer 0)", c_out);

        // Teste 5: Ambos botões pressionados
        $display("Teste 5: U e D simultâneos");
        u = 1; d = 1; #30;
        u = 0; d = 0; #50;
        $display("C = %d", c_out);

        $display("=== Simulação Concluída ===");
        $finish;
    end

endmodule