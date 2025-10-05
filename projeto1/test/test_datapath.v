// test/test_datapath.v
`timescale 1ns/1ps

module test_datapath;
    reg clk, reset;
    reg op, c_ld, c_clr;
    wire z, m;
    wire [15:0] c_out;
    
    // Instância do datapath
    datapath dut(
        .clk(clk),
        .reset(reset),
        .op(op),
        .c_ld(c_ld),
        .c_clr(c_clr),
        .z(z),
        .m(m),
        .c_out(c_out)
    );
    
    // Geração de clock
    always #5 clk = ~clk;
    
    initial begin
        // Inicialização
        clk = 0;
        reset = 1;
        op = 0;
        c_ld = 0;
        c_clr = 0;
        
        // Reset
        #20 reset = 0;
        
        // Teste 1: Incremento
        $display("=== Teste 1: Incremento ===");
        c_ld = 1;
        op = 0; // incremento
        #10;
        c_ld = 0;
        #10;
        $display("C = %d, z = %b, m = %b", c_out, z, m);
        
        // Teste 2: Vários incrementos
        $display("=== Teste 2: 3 Incrementos ===");
        repeat(3) begin
            c_ld = 1;
            #10;
            c_ld = 0;
            #10;
            $display("C = %d, z = %b, m = %b", c_out, z, m);
        end
        
        // Teste 3: Decremento
        $display("=== Teste 3: Decremento ===");
        c_ld = 1;
        op = 1; // decremento
        #10;
        c_ld = 0;
        #10;
        $display("C = %d, z = %b, m = %b", c_out, z, m);
        
        // Teste 4: Clear
        $display("=== Teste 4: Clear ===");
        c_clr = 1;
        #10;
        c_clr = 0;
        #10;
        $display("C = %d, z = %b, m = %b", c_out, z, m);
        
        // Teste 5: Sequência mista
        $display("=== Teste 5: Sequência Mista ===");
        op = 0; // incremento
        c_ld = 1; #10; c_ld = 0; #10; // +1
        c_ld = 1; #10; c_ld = 0; #10; // +1
        op = 1; // decremento  
        c_ld = 1; #10; c_ld = 0; #10; // -1
        
        $display("Final: C = %d, z = %b, m = %b", c_out, z, m);
        $display("Simulação concluída!");
        $stop; // No ModelSim usa $stop em vez de $finish
    end
    
endmodule