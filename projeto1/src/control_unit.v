module control_unit(
    input clk, 
    input reset,

    //entradas do controle
    input u, d,
    //Entradas de sinais de status
    input z, m,

    //Saídas de comandos
    output reg op, c_clr, c_ld

);

    parameter [1:0] inicio = 2'b00,
                    verifica = 2'b01,
                    incrementa = 2'b10,
                    decrementa = 2'b11;

    reg [1:0] current_state, next_state;

    //Registro de inicialização/mudança de estado
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= inicio;
        else 
            current_state <= next_state;
    end

    //Lógica de transição de estados e saídas
    always @(*) begin
        op = 0;
        c_clr = 0;
        c_ld = 0;

        case(current_state)

                inicio: begin 
                    op = 0;
                    c_clr = 1;
                    c_ld = 0;
                    next_state = verifica;
                end
                    

                verifica: begin 
                    op = 0;
                    c_clr = 0;
                    c_ld = 0;

                    if (u & m & ~d)
                        next_state = incrementa;
                    else if (~u &z &d)
                        next_state = decrementa;
                    else 
                        next_state = verifica;
                end

                incrementa: begin 
                    op = 0;
                    c_clr = 0;
                    c_ld = 1;
                    next_state = verifica;
                end

                decrementa: begin
                    op = 0;
                    c_clr = 0;
                    c_ld = 1;
                    next_state = verifica;
                end
        endcase
    end


endmodule