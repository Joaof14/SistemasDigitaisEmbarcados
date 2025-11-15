module datapath(
    input clk,
    input ld_N, clr_N,
    input ld_Ep, clr_Ep,
    input ld_w, clr_w,
    input ld_e, clr_e,
    input [3:0] Epocas,
    output Epm,
    output Nm,
    output reg signed [7:0] w0,
    output reg signed [7:0] w1
);

    reg [3:0] N;
    reg [3:0] EP;
    reg signed [1:0] Erro;  // <-- registrador de erro

    // Tabela OR
    reg [1:0] x [0:3];
    reg y_target [0:3];

    // Sinais combinacionais
    wire signed [8:0] soma;
    wire y_pred;
    wire signed [1:0] erro_wire;

    parameter signed limiar = 1;

    // Inicialização da tabela
    initial begin
        x[0] = 2'b00; y_target[0] = 1'b0;
        x[1] = 2'b01; y_target[1] = 1'b1;
        x[2] = 2'b10; y_target[2] = 1'b1;
        x[3] = 2'b11; y_target[3] = 1'b1;
        w0 = 8'sd0;
        w1 = 8'sd0;
        N = 4'd0;
        EP = 4'd0;
        Erro = 2'sd0;
    end

    // Predição combinacional
    wire signed [7:0] part0 = (x[N][0] ? w0 : 8'sd0);
    wire signed [7:0] part1 = (x[N][1] ? w1 : 8'sd0);
    assign soma = part0 + part1;
    assign y_pred = (soma >= limiar) ? 1'b1 : 1'b0;

    // Erro combinacional
    assign erro_wire = $signed({1'b0, y_target[N]}) - $signed({1'b0, y_pred});

    // Status
    assign Epm = (EP < Epocas) ? 1'b1 : 1'b0;
    assign Nm  = (N  < 4) ? 1'b1 : 1'b0;

    // Sequencial
    always @(posedge clk) begin
        // N
        if (clr_N)
            N <= 4'd0;
        else if (ld_N)
            N <= N + 4'd1;

        // EP
        if (clr_Ep)
            EP <= 4'd0;
        else if (ld_Ep)
            EP <= EP + 4'd1;

        // Erro (registrador)
        if (clr_e)
            Erro <= 2'sd0;
        else if (ld_e)
            Erro <= erro_wire;

        // Atualização dos pesos
        if (clr_w) begin
            w0 <= 8'sd0;
            w1 <= 8'sd0;
        end
        else if (ld_w) begin
            w0 <= w0 + (Erro * x[N][0]);
            w1 <= w1 + (Erro * x[N][1]);
        end
    end
endmodule