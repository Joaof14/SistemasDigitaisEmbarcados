module adder_sub_1bit (
    input a,
    input b,
    input cin,
    input op,
    output sum,
    output cout
);

    wire b_eff = b^op; //se op for 1, subtração, inverte b
    wire cin_eff = cin^op; //Se op for 1, inverte cin

    //FULL Adder
    assign sum = a^b_eff^cin_eff;
    assign cout = (a & b_eff) | (cin_eff & b_eff) | (a & cin_eff);

    
endmodule