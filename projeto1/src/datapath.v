module datapath(
    input clk,
    input reset,
    
    //Sinais de controle
    input op,
    input c_ld,
    input c_clr,

    //Sinais de status
    output z, m, //flags zero e maximo

    //Saída de dados do sistema
    output [15:0] c_out // contador
);


    wire [15:0] current_c;
    wire [15:0] next_c;
    wire cout;

    //Registrador c
    register_16bit reg_c(
        .clk(clk),
        .reset(reset),
        .c_ld(c_ld),
        .c_clr(c_clr),
        .d_in(next_c),
        .q(current_c)
    );

//Somador e subtrator
    adder_sub_16bit alu(
        .a(current_c),
        .b(16'b1),
        .op(op),
        .sum(next_c),
        .cout(cout)
    );

//Comparadores
    comparators comp(
        .c(current_c),
        .z(z),
        .m(m)
    );

    //Saída
    assign c_out = current_c;


endmodule