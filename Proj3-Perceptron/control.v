module control (
    input clk,
    input rst,
    input Epm,    // status vindo do datapath (E < Epocas?)
    input Nm,     // status vindo do datapath (N < 4?)
    output reg ld_N,
    output reg clr_N,
    output reg ld_Ep,
    output reg clr_Ep,
    output reg ld_w,
    output reg clr_w,
    output reg ld_e,
    output reg clr_e
);

    reg [1:0] estado_atual, estado_proximo;

    parameter Start = 2'b00,
              Wait  = 2'b01,
              Forward = 2'b10,
              Backpropagation = 2'b11;

    // Estado atual
    always @(posedge clk or posedge rst) begin
        if (rst)
            estado_atual <= Start;
        else
            estado_atual <= estado_proximo;
    end

    // Lógica combinacional de controle
    always @(*) begin
        // Valores padrão
        estado_proximo = estado_atual;
        ld_N = 1'b0; clr_N = 1'b0;
        ld_Ep = 1'b0; clr_Ep = 1'b0;
        ld_w = 1'b0; clr_w = 1'b0;
        ld_e = 1'b0; clr_e = 1'b0;

        case (estado_atual)
            Start: begin
                clr_Ep = 1'b1;
                clr_w  = 1'b1;
                clr_e  = 1'b1;
                estado_proximo = Wait;
            end

            Wait: begin
                clr_N = 1'b1;  // mantém N zerado
                ld_Ep = 1'b1;  // incrementa época se permitido
                if (Epm)
                    estado_proximo = Forward;
                else
                    estado_proximo = Wait;
            end

            Forward: begin
                // Calcula soma, y_pred e erro_wire; carrega erro
                ld_e = 1'b1;
                estado_proximo = Backpropagation;
            end

            Backpropagation: begin
                // Usa o erro armazenado para atualizar os pesos
                ld_w = 1'b1;
                ld_N = 1'b1;
                if (Nm)
                    estado_proximo = Forward;
                else
                    estado_proximo = Wait;
            end

            default: estado_proximo = Start;
        endcase
    end
endmodule