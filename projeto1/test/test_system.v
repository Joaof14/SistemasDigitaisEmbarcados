`timescale 1ns / 1ps

module test_system;
    reg clk;
    reg reset;
    reg u;
    reg d;
    wire [15:0] c_out;

    // Instancia o sistema completo do diretório src
    top_system uut (
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

        #20;
        reset = 0;

        // Teste 1: u=1, d=0 (deve incrementar até m=0)
        u = 1;
        d = 0;
        #200;

        // Teste 2: u=0, d=1 (deve decrementar até z=0)
        u = 0;
        d = 1;
        #200;

        // Teste 3: u=0, d=0 (não faz nada)
        u = 0;
        d = 0;
        #100;

        // Teste 4: u=1, d=1 (não faz nada)
        u = 1;
        d = 1;
        #100;

        $finish;
    end

    initial begin
        $monitor("Time = %0t, clk=%b, reset=%b, u=%b, d=%b, c_out=%d", 
                 $time, clk, reset, u, d, c_out);
    end
endmodule