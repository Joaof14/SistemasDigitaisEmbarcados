module register_16bit(
    input clk,
    input reset,
    input c_ld,
    input c_clr,
    input [15:0] d_in,
    output reg [15:0] q
    );

    //sempre na subida do clock ou quando for feito reset assíncrono
    always @(posedge clk or posedge reset) begin 
        if (reset)
            q <= 16'b0;
        else if(c_clr)
            q<= 16'b0;
        else if(c_ld)
            q <= d_in;

        //Caso contrário mantem valor atual
    end
endmodule
