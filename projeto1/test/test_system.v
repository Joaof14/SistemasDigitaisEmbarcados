`timescale 1ns/1ps

module test_system;
    reg clk, reset;
    reg u, d;
    wire [15:0] c_out;
    
    // Sinais de debug
    wire [2:0] current_state;
    wire op, c_ld, c_clr, z, m;

    top_system dut(
        .clk(clk),
        .reset(reset),
        .u(u),
        .d(d),
        .c_out(c_out)
    );
    
    // Acessar sinais internos
    assign current_state = dut.fsm.current_state;
    assign op = dut.fsm.op;
    assign c_ld = dut.fsm.c_ld;
    assign c_clr = dut.fsm.c_clr;
    assign z = dut.dp.z;
    assign m = dut.dp.m;

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        u = 0;
        d = 0;

        $dumpfile("../sim/system_wave.vcd");
        $dumpvars(0, test_system);

        $display("=== Teste do Sistema Completo - TIMING AJUSTADO ===");
        $display("Tempo | Estado | u | d | c_ld | c_clr | C");
        $display("------------------------------------------");

        // Reset inicial
        #100 reset = 0;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);

        // Aguardar chegar no VERIFICA
        #50;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);

        // Teste 1: Pressionar U - com amostragem em alta frequência
        $display(">>> Teste 1: Pressionar U");
        u = 1; 
        #10; // ⚡ AMOSTRAGEM A CADA 10ns (1 ciclo clock)
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        u = 0;
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #50; // Espera para voltar ao VERIFICA
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        $display("C = %d", c_out);

        // Teste 2: Pressionar U novamente
        $display(">>> Teste 2: Segundo U");
        u = 1; 
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        u = 0;
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #50;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        $display("C = %d", c_out);

        // Teste 3: Pressionar D
        $display(">>> Teste 3: Pressionar D");
        d = 1; 
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        d = 0;
        #10;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        #50;
        $display("%t | %b | %b | %b | %b | %b | %d", 
                $time, current_state, u, d, c_ld, c_clr, c_out);
        $display("C = %d", c_out);

        $display("=== Simulação Concluída ===");
        $finish;
    end
endmodule