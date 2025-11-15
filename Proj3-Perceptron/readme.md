# PerceptronEmbarcado

Projeto FPGA (RTL) que implementa um perceptron embarcado alvo Tang Nano / Cyclone/Quartus (arquivos do projeto e fluxo de síntese estão incluídos).

## Conteúdo da pasta
- top.v, control.v, datapath.v — fontes Verilog principais (há backups `.bak`).
- makefile — script para fluxo de síntese/geração (ajustar dependendo da ferramenta instalada).
- tangnano1k.cst — arquivo de restrições/pinos (constraints) para placa Tang Nano 1K.
- top.json, top.qpf, top.qsf, top.qws — arquivos de projeto (Quartus / fluxo alternativo).
- output_files/ — resultados da síntese/implementação (inclui `top.sof` quando compilado).
- simulation/questa/ — arquivos de simulação (Questa/ModelSim) (scripts, objetos pré-compilados).
- db/, incremental_db/ — diretórios gerados pela ferramenta de síntese (não versionar).

## Requisitos
- Ferramenta de síntese/implementação (Quartus Prime / Yosys + nextpnr / ferramenta específica do seu fluxo).
- Simulador RTL (ModelSim / Questa / iverilog + gtkwave).
- Programador para a placa (OpenFPGALoader, Quartus Programmer, conforme fluxo).


