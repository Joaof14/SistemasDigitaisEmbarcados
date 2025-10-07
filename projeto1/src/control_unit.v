module control_unit(
    input clk,
    input reset,
    

    ///Entradas da unidadde de controle
    input u, d,
    //sinais de status
    input z, m,
    //saídas de comandos para o datapath
    output reg op,
    output reg c_clr,
    output reg c_ld
);


//Definição dos estados
    parameter [2:0] INICIO = 3'b000,
                    ESPERA  = 3'b001,
                    VERIFICA = 3'b010,
                    INC = 3'b011,
                    ESPERA_INC = 3'b100,
                    DEC = 3'b101,
                    ESPERA_DEC = 3'b110;

    reg [2:0] current_state, next_state;

    //Registro de estado
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= INICIO;
        else
            current_state <= next_state;
    end

    //Lógica de próximo estado
    always @(*) begin
        case (current_state)
            INICIO:
                next_state = ESPERA;
            
            ESPERA:
                next_state = VERIFICA;
            
            VERIFICA: begin
                // Incremento: não está no máximo e botão U pressionado
                if (~m & u & ~d)
                    next_state = INC;
                // Decremento: não está no zero e botão D pressionado  
                else if (~z & ~u & d)
                    next_state = DEC;
                // Ambos botões: vai para ESPERA (clear)
                else if (u & d)
                    next_state = ESPERA;
                // Nenhuma condição: mantém em VERIFICA
                else
                    next_state = VERIFICA;
            end


            INC:
                next_state = ESPERA_INC;
            

            ESPERA_INC: begin
                if (~u)
                    next_state = VERIFICA;
                else
                    next_state = ESPERA_INC;

            end

            DEC:
                next_state = ESPERA_DEC;


            ESPERA_DEC: begin
                if (~d)
                    next_state = VERIFICA;
                else 
                    next_state = ESPERA_DEC;
            end


            default:
                next_state = INICIO;
            
        endcase
    end



    //Lógica de saída do controle
    always@(*) begin
        //Valores padrão
        op = 0;
        c_clr = 0;
        c_ld = 0;

        case (current_state)
            INICIO: begin 
                op = 0;
                c_clr = 0;
                c_ld = 0;
            end

            ESPERA: begin 
                op = 0;
                c_clr = 1;
                c_ld = 0;
            end

            VERIFICA: begin 
                op = 0;
                c_clr = 0;
                c_ld = 0;            
            end

            INC: begin 
                op = 0;
                c_clr = 0;
                c_ld = 1;
            end

            ESPERA_INC: begin 
                op = 0;
                c_clr = 0;
                c_ld = 0;
            end

            DEC: begin
                op = 1;
                c_clr = 0;
                c_ld = 1;         
            end

            ESPERA_DEC: begin 
                op = 0;
                c_clr = 0;
                c_ld = 0;
            end

            default: begin
                op = 0;
                c_clr = 0;
                c_ld = 0;
            end
        endcase
    end
endmodule
