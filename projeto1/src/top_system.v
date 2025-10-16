module top_system (
    input clk,
    input reset,

    //Entradas do controle
    input u, d,

    //Entradas do datapath
    

    //Saídas do controle


    //saídas do datapath
    output [15:0] c_out
);


    //sinais de comando
    wire op, c_ld, c_clr;

    //sinais de status
    wire z, m;
	 
	 //divisor de clock
	 
	 wire slow_clk;

    //Instanciamento de datapath e controle
	 
	 clk_divider clk_div(
	 .clk(clk),
	 .reset(reset),
	 .slow_clk(slow_clk),
	 );


    control_unit fsm(
        .clk(slow_clk),
        .reset(reset),
        .op(op),
        .c_clr(c_clr),
        .c_ld(c_ld),
        .z(z),
        .m(m),
        .u(u),
        .d(d)
    );

    datapath dp(
        .clk(slow_clk),
        .reset(reset),
        .op(op),
        .c_clr(c_clr),
        .c_ld(c_ld),
        .z(z),
        .m(m),
        .c_out(c_out)
    );

endmodule