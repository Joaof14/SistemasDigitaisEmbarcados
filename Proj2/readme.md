# Project 2 — Candy Machine (RTL)

## Description
- RTL system in Verilog that manages inserted coins and dispenses candies.
- Inputs:
  - C1, C0 : 2 bits representing the inserted coin (00 = none, 01 = 5¢, 10 = 10¢, 11 = 25¢). The input changes to indicate the coin for a few cycles and then returns to 00.
  - S : request button (release).
- Outputs:
  - D : accumulator of inserted value (12 bits).
  - R : 1-cycle pulse indicating candy release (when balance ≥ 80¢ and S is pressed).
- Behavior:
  - On detecting a valid coin, adds its value to accumulator D.
  - On detecting S with balance ≥ 80¢, generates R=1 for 1 cycle and subtracts 80¢ from accumulator.
  - Allows buying multiple candies in sequence.
  - Button debounce is not implemented; for real hardware, add a filter.

## Project structure
- src/
  - adder_12bit.v — 12-bit adder/subtractor.
  - adder_1bit.v — 1-bit block used by the adder.
  - comparators.v — condition signals (e.g., enough for purchase).
  - control_unit.v — FSM managing coin detection, S, and command generation.
  - datapath.v — registers, ALU, mux for coin values.
  - muxValor.v — converts C1C0 to coin value (5, 10, 25).
  - registerD12bit.v — 12-bit accumulator register.
  - top_system.v — system top, connects datapath and FSM.
- test/
  - test_datapath.v — datapath testbench.
  - test_system.v — full system testbench.
- sim/
  - simulate_datapath.tcl — script to open datapath waveform in ModelSim/Questa.
  - run_System.tcl — script to open full system waveform.
- readme.md — this file.

## How to simulate (ModelSim / Questa)
1. Compile sources and testbenches:
   - vlog src/*.v test/*.v
2. Run testbench:
   - vsim work.test_datapath
   - vsim work.test_system
3. Use TCL scripts in ModelSim:
   - do sim/simulate_datapath.tcl
   - do sim/run_System.tcl
   (scripts add relevant signals to waveform and run `run -all`)

## Important signals to monitor
- External: C1, C0, S, D (12 bits), R.
- Useful internal: accumulator current_value / next_value, register load signal (c_ld), clear/reset signal, muxValor output (coin_value), comparison signals (enough_for_sale).
- If D shows as `z`, check connection in top_system and declaration in testbench.

## Recommended tests
- Insert a sequence of coins (e.g., 25,25,25,5) and press S to verify release and subtraction of 80¢.
- Test coin-held (coin remains for several cycles) and ensure it is counted only once (edge detection).
- Test attempt to release with insufficient balance — R should remain 0.
- Print in testbenches: time, C1C0, S, D, R, internal values (use `$display` on clock edge).

## Notes and tips
- Detecting 0→X transition for C1C0 should be robust to count only once per insertion; ideally detect edge (prev_coin ≠ 00 -> new_coin ≠ 00) and/or use handshake.
- Buttons (S) and real-world inputs require debounce; consider implementing stability counter on slow clock.
- Always check initial register reset to ensure D starts at zero.
- For quick debugging, expose internal signals in the testbench with `assign` and add to waveform.

## License
This project is licensed under the MIT License.


# Projeto 2 — Máquina de Doces (RTL)

## Descrição
- Sistema RTL em Verilog que gerencia moedas inseridas e libera doces.
- Entradas:
  - C1, C0 : 2 bits que representam a moeda inserida (00 = nenhuma, 01 = 5¢, 10 = 10¢, 11 = 25¢). A entrada muda para indicar a moeda por alguns ciclos e depois volta a 00.
  - S : botão de solicitação (release).
- Saídas:
  - D : acumulador do valor inserido (12 bits).
  - R : pulso de 1 ciclo indicando liberação de um doce (quando há saldo ≥ 80¢ e S é pressionado).
- Comportamento:
  - Ao detectar uma moeda válida, soma seu valor ao acumulador D.
  - Ao detectar S com saldo ≥ 80¢, gera R=1 por 1 ciclo e subtrai 80¢ do acumulador.
  - Deve permitir comprar vários doces sequencialmente.
  - Debounce de botões não está implementado; para hardware real, adicionar filtro.

## Estrutura do projeto
- src/
  - adder_12bit.v — somador/subtrator de 12 bits.
  - adder_1bit.v — bloco de 1 bit usado pelo somador.
  - comparators.v — sinais de condição (ex.: suficiente para compra).
  - control_unit.v — FSM que gerencia detecção de moeda, S e geração de comandos.
  - datapath.v — registradores, ALU, mux para valores de moedas.
  - muxValor.v — converte C1C0 em valor de moeda (5, 10, 25).
  - registerD12bit.v — registrador de 12 bits do acumulador.
  - top_system.v — top do sistema, conecta datapath e FSM.
- test/
  - test_datapath.v — testbench do datapath.
  - test_system.v — testbench do sistema completo.
- sim/
  - simulate_datapath.tcl — script para abrir waveform do datapath em ModelSim/Questa.
  - run_System.tcl — script para abrir waveform do sistema completo.
- readme.md — este arquivo.

## Como simular (ModelSim / Questa)
1. Compilar fontes e testbenches:
   - vlog src/*.v test/*.v
2. Rodar testbench:
   - vsim work.test_datapath
   - vsim work.test_system
3. Usar scripts TCL dentro do ModelSim:
   - do sim/simulate_datapath.tcl
   - do sim/run_System.tcl
   (os scripts adicionam sinais relevantes ao waveform e executam `run -all`)

## Sinais importantes para monitorar
- Externos: C1, C0, S, D (12 bits), R.
- Internos úteis: acumulador current_value / next_value, sinal de carga do registrador (c_ld), sinal de clear/reset, saída da muxValor (valor_moeda), sinais de comparação (suficiente_para_venda).
- Se D aparecer como `z`, verifique conexão em top_system e declaração no testbench.

## Testes recomendados
- Inserir uma sequência de moedas (ex.: 25,25,25,5) e pressionar S para verificar liberação e subtração de 80¢.
- Testar coin-held (moeda permanecendo por vários ciclos) e assegurar que é contada apenas uma vez (detectar borda).
- Testar tentativa de liberação com saldo insuficiente — R deve permanecer 0.
- Printar nos testbenches: tempo, C1C0, S, D, R, valores internos (use `$display` em borda de clock).

## Observações e dicas
- A detecção de transição 0→X para C1C0 deve ser robusta para contar uma única vez por inserção; idealmente detectar borda (prev_coin ≠ 00 -> new_coin ≠ 00) e/ou usar handshake.
- Botões (S) e entradas do mundo real requerem debounce; considerar implementar contador de estabilidade no slow clock.
- Verifique sempre reset inicial do registrador para garantir D começa em zero.
- Para depuração rápida, exponha sinais internos no testbench com `assign` e adicione ao waveform.

## Licença

Este repositório está licenciado sob a **MIT License**: