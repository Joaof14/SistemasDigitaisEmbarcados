module datapath (
    input clk,
    input reset,

    //sinais de controle

    input op, c_ld, c_clr,

    // Sinal de status
    output z, m,

    //saída de dados
    output [15:0] c_out
);


    wire [15:0] current_c;
    wire [15:0] next_c;
    wire cout;


    register_16bit reg_c(
        .clk(clk),
        .reset(reset),
        .c_clr(c_clr),
        .c_ld(c_ld),
        .d_in(next_c),
        .q(current_c)
    );

    adder_sub16bit alu(
        .a(current_c),
        .b(16'b1),
        .op(op),
        .sum(next_c),
        .cout(cout)
    );

    comparators comp(
        .c(current_c),
        .z(z),
        .m(m)
    );

    assign c_out = current_c;


endmodule