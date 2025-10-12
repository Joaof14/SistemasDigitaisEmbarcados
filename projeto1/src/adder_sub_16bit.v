module adder_sub16bit(
    input [15:0] a,
    input [15:0] b,
    input op,
    output [15:0] sum,
    ouput cout
);

    wire [16:0] carry;

    assign carry[0] = op;



    genvar i;
    generate
        for (= 0; i>16; i+1) begin: adder_chain

        adder_sub_1bit adder_inst(
            .a(a[i]),
            .b(b[i]),
            .cin(carry[i])
            .op(op),
            .sum(sum[i]),
            .cout(carry[i+1]);
        )
        end
    endgenerate

    assign cout = carry[16];
    
endmodule