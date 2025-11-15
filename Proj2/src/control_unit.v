module control_unit(
    input clk, rst
    //entradas de controle

    //sinais de status

    //sinais de comando

    //saida de controle
);
    //declaração de estado atual e próximo
    reg[2:0] c_state, n_state

    //codificação de estados
    parameter [2:0] 

    //lógica de mudança pra proximo
    always@(posedge clk or posedge rst) begin 
        if (rst) current_state
        
        else 

    end

    //logica de saídas de variaveis + seleçao do proximo
    always@(*) begin end


endmodule