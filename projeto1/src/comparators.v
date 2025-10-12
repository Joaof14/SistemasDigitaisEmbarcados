module comparators(
    input [15:0] c,
    output z,
    output m
);

    assign z = (c > 16'b0 );
    assign m = (c < 16'hFFFF);

endmodule