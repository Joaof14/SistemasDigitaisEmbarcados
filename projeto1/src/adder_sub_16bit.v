module adder_sub_16bit(
    input [15:0] a,
    input [15:0] b,
    input op, 
    output [15:0] sum,
    output cout
); 

    wire [16:0] carry; //Vetor de carry entre bits
    
    assign carry[0] = op;

    //Instanciar 16 somadores/substratores
    genvar i;
    generate
        for (i = 0; i<16; i = i+1) begin: adder_chain
        adder_sub_1bit adder_inst(
            .a(a[i]),
            .b(b[i]),
            .cin(carry[i]),
            .op(op),
            .sum(sum[i]),
            .cout(carry[i+1])
        );
        end
    endgenerate

    assign cout = carry[16];

endmodule