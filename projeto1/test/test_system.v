`timescale 1ns / 1ps

module test_system;
    reg clk, reset;
    reg u, d;
    wire [15:0] c_out;

    // sinais internos para debug
    wire [1:0] current_state;
    wire op, c_ld, c_clr, z, m;

    // instancia top_system
    top_system dut(
        .clk(clk),
        .reset(reset),
        .u(u),
        .d(d),
        .c_out(c_out)
    );

    // acesso aos sinais internos da FSM e datapath
    assign current_state = dut.fsm.current_state;
    assign op = dut.fsm.op;
    assign c_ld = dut.fsm.c_ld;
    assign c_clr = dut.fsm.c_clr;
    assign z = dut.dp.z;
    assign m = dut.dp.m;

    // clock
    always #5 clk = ~clk; // 10ns período

    initial begin
        clk = 0;
        reset = 1;
        u = 0;
        d = 0;

        $dumpfile("system_wave.vcd");
        $dumpvars(0, test_system);

        $display("=== Teste FSM + Datapath ===");
        $display("Tempo | Estado | u | d | c_ld | c_clr | op | z | m | c_out");
        $display("-----------------------------------------------------------");

        // reset inicial
        #20 reset = 0;
        $display("%t | %b | %b | %b | %b | %b | %b | %b | %b | %d", 
                 $time, current_state, u, d, c_ld, c_clr, op, z, m, c_out);

        // Teste 1: Incrementar
        $display(">>> Teste 1: Incrementar (u=1, d=0)");
        u = 1; d = 0;
        repeat (5) begin
            #10;
            $display("%t | %b | %b | %b | %b | %b | %b | %b | %b | %d", 
                     $time, current_state, u, d, c_ld, c_clr, op, z, m, c_out);
        end
        u = 0;

        // Teste 2: Decrementar
        $display(">>> Teste 2: Decrementar (u=0, d=1)");
        d = 1; u = 0;
        repeat (5) begin
            #10;
            $display("%t | %b | %b | %b | %b | %b | %b | %b | %b | %d", 
                     $time, current_state, u, d, c_ld, c_clr, op, z, m, c_out);
        end
        d = 0;

        // Teste 3: Incrementar até limite máximo
        $display(">>> Teste 3: Incrementar até o máximo (c_out=0xFFFF)");
        u = 1; d = 0;
        repeat (20) begin
            #10;
            $display("%t | %b | %b | %b | %b | %b | %b | %b | %b | %d", 
                     $time, current_state, u, d, c_ld, c_clr, op, z, m, c_out);
        end
        u = 0;

        // Teste 4: Decrementar até zero
        $display(">>> Teste 4: Decrementar até zero (c_out=0)");
        d = 1; u = 0;
        repeat (20) begin
            #10;
            $display("%t | %b | %b | %b | %b | %b | %b | %b | %b | %d", 
                     $time, current_state, u, d, c_ld, c_clr, op, z, m, c_out);
        end
        d = 0;

        $display("=== Simulação Concluída ===");
        $finish;
    end
endmodule
