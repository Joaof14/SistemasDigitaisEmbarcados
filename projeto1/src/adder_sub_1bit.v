module adder_sub_1bit(
    input a, b, cin, op,
    output sum, cout
    );

    wire b_eff = b^op;
    
    assign sum = a^b_eff^cin;
    assign cout = (a & b_eff) | (a & cin) | (b_eff & cin);

endmodule