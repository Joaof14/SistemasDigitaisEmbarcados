# Project 1 — Up/Down Counter (RTL)

## Description
- RTL system in Verilog: inputs U and D (buttons), output C (16 bits).
- C starts at 0; U increments, D decrements. No overflow or underflow allowed.
- Button press = 0 → 1 transition (system must detect edge).

## Structure
- src/ — sources: adder_sub_1bit.v, adder_sub_16bit.v, datapath.v, control_unit.v, register_16bit.v, clk_divider.v, comparators.v, top_system.v
- test/ — testbenches: test_datapath.v, test_system.v
- sim/ — simulation scripts: simulateDatapath.tcl, run_System.tcl and VCDs
- readme.md — this file

## How to Simulate (ModelSim/Questa)
1. Compile:
   - vlog ../src/*.v ../test/*.v
2. Run testbench:
   - vsim work.test_datapath
   - vsim work.test_system
3. Use TCL scripts:
   - In ModelSim: do sim/simulateDatapath.tcl or do sim/run_System.tcl
   - Note: scripts use the `uut` instance in the testbench (corrected).

## Important signals for debugging
- Expose and monitor: c_out, current_c, next_c, c_ld, c_clr, op, z, m, slow_clk, reset.
- If c_out shows as `z`: check connections in top_system (datapath.c_out → top_system.c_out) and that the testbench declares c_out as `wire`.
- If register does not update, monitor `c_ld` and `next_c` to ensure control_unit triggers load on edge.

## Implementation notes
- Edge detection (u && !u_prev) is NOT debounce. For real buttons, implement a temporal filter (counter) in the slow_clk domain.
- Register only loads when `c_ld` = 1; `c_clr` and `reset` clear to zero.

## Useful scripts/files
- sim/simulateDatapath.tcl — adds datapath signals to waveform and runs simulation.
- sim/run_System.tcl — adds system signals (FSM + datapath) to waveform.
- test/test_system.v — testbench printing variables; check `uut` for internal signals.

## Quick tips
- Use `$display` or `$monitor` in the testbench to capture values per clock.
- To check the FSM, expose `current_state`, `c_ld`, `op` and see when they are activated.
- If using nextpnr (other project), adjust flags for backend (himbaechel vs gowin).

## License
This project is licensed under the MIT License.



# Projeto 1 — Contador U/D (RTL)

## Descrição
- Sistema RTL em Verilog: entradas U e D (botões), saída C (16 bits).
- C inicia em 0; U incrementa, D decrementa. Não permite overflow nem underflow.
- Pressionar = transição 0 → 1 (sistema deve detectar borda).

## Estrutura
- src/ — fontes: adder_sub_1bit.v, adder_sub_16bit.v, datapath.v, control_unit.v, register_16bit.v, clk_divider.v, comparators.v, top_system.v
- test/ — testbenches: test_datapath.v, test_system.v
- sim/ — scripts de simulação: simulateDatapath.tcl, run_System.tcl e VCDs
- readme.md — este arquivo

## Como simular (ModelSim/Questa)
1. Compile:
   - vlog ../src/*.v ../test/*.v
2. Rodar testbench:
   - vsim work.test_datapath
   - vsim work.test_system
3. Usar scripts TCL:
   - Dentro ModelSim: do sim/simulateDatapath.tcl ou do sim/run_System.tcl
   - Observação: os scripts usam a instância `uut` no testbench (corrigido).

## Sinais importantes para debug
- Expor e monitorar: c_out, current_c, next_c, c_ld, c_clr, op, z, m, slow_clk, reset.
- Se c_out aparece como `z`: verifique conexões no top_system (datapath.c_out → top_system.c_out) e se o testbench declara c_out como `wire`.
- Se registrador não atualiza, monitore `c_ld` e `next_c` para garantir que control_unit gera carga na borda.

## Notas de implementação
- A detecção de borda (u && !u_prev) NÃO é debounce. Para botões reais, implemente filtro temporal (contador) no domínio do slow_clk.
- O registrador só carrega quando `c_ld` = 1; `c_clr` e `reset` limpam para zero.

## Scripts / arquivos úteis
- sim/simulateDatapath.tcl — adiciona sinais do datapath ao waveform e executa simulação.
- sim/run_System.tcl — adiciona sinais do sistema completo (FSM + datapath) ao waveform.
- test/test_system.v — testbench que imprime variáveis; revise `uut` ao acessar sinais internos.

## Dicas rápidas
- Use `$display` ou `$monitor` no testbench para capturar valores por clock.
- Para checar a FSM, exponha `current_state`, `c_ld`, `op` e veja if/when são ativados.
- Se for usar nextpnr (projeto diferente), ajuste flags conforme backend (himbaechel vs gowin).

## Licença

Este repositório está licenciado sob a **MIT License**: