module adder_sub_1bit(
    input a, b, cin
    output sum, cout
    );

    wire b_eff = b^op;
    
    assign sum = a^b_eff^cin;
    assign cout = (a & b_eff) | (cin & a) | (b_eff & a);

endmodule