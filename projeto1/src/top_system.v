module top_system(
    input clk, 
    input reset,
    input u,
    input d,
    output[15:0] c_out
);

    //Sinais de interconexão entre FSM e Datapath
    wire op;
    wire c_ld;
    wire c_clr;
    wire z;
    wire m;

    //Instância da Unidade de controle
    control_unit fsm(
        
        .clk(clk),
        .reset(reset),
        .u(u),
        .d(d),
        .z(z),
        .m(m),
        .op(op),
        .c_clr(c_clr),
        .c_ld(c_ld)
    );


    //Instância do datapath
    datapath dp(
        .clk(clk),
        .reset(reset),
        .op(op),
        .c_ld(c_ld),
        .c_clr(c_clr),
        .z(z),
        .m(m),
        .c_out(c_out)
    );

endmodule