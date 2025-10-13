module adder_sub_12bit(
    input [11:0] a, b, cin,
    output [11:0] sum, cout
);

    wire carry[12:0];
    assign carry[0] = 0;

    genvar i;
    generate 
        for (i = 0, i<12, i = i+ 1) begin adder_chain 
            adder_sub_1bit adder_inst(
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                cout(carry[i+1])
            )
        end

    endgenerate

    assign cout = carry[16];

endmodule