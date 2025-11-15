module registerD12bit(
    input clk, rst, d_ld, d_clr,
    input [11:0] d_in,
    output reg [11:0] q);

    always@(posedge clk or posedge rst) begin 
        if (rst) q<= 12'b0;

        else if (d_clr) q<= 12'b0;
        
        else if (d_ld) q<= d_in;
            
    end
endmodule