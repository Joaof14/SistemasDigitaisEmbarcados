module register_16bit(
    input clk,
    input reset,
    input c_ld,
    input c_clr,
    input [15:0] d_in,
    output reg[15:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) q <= 16'b0;
            
        else if (c_clr) q <= 16'b0;
            
        else if (c_ld) q <= d_in;
    end
endmodule