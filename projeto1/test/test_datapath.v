`timescale 1ns / 1ps

module test_datapath;
    reg clk;
    reg reset;
    reg op;
    reg c_ld;
    reg c_clr;
    wire z;
    wire m;
    wire [15:0] c_out;

    // Instancia o datapath do diretório src
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

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        op = 0;
        c_ld = 0;
        c_clr = 0;

        #20;
        reset = 0;

        // Teste 1: Limpar o registrador
        #10;
        c_clr = 1;
        #10;
        c_clr = 0;

        // Teste 2: Incrementar (op=0) com c_ld=1
        #10;
        c_ld = 1;
        op = 0;
        #10;
        c_ld = 0;

        // Teste 3: Decrementar (op=1) com c_ld=1
        #10;
        c_ld = 1;
        op = 1;
        #10;
        c_ld = 0;

        // Teste 4: Manter o valor (c_ld=0) por alguns ciclos
        #30;

        // Teste 5: Incrementar várias vezes
        repeat(3) begin
            #10;
            c_ld = 1;
            op = 0;
            #10;
            c_ld = 0;
        end

        // Teste 6: Decrementar várias vezes
        repeat(3) begin
            #10;
            c_ld = 1;
            op = 1;
            #10;
            c_ld = 0;
        end

        #100;
        $finish;
    end

    initial begin
        $monitor("Time = %0t, clk=%b, reset=%b, op=%b, c_ld=%b, c_clr=%b, z=%b, m=%b, c_out=%d", 
                 $time, clk, reset, op, c_ld, c_clr, z, m, c_out);
    end
endmodule