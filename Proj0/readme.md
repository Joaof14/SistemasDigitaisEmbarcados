# Projeto 0 — Escala de Pixel (RTL)

Descrição
- Projeto FPGA em Verilog que implementa um escalonador de pixel para aplicações de processamento de imagem.
- Fluxo de síntese com Yosys + nextpnr ou Quartus, alvo Tang Nano / Cyclone.
- Inclui fontes, constraints, makefile e scripts de simulação.

Estrutura do projeto
- piscaled.v — fonte principal do módulo.
- makefile — script para síntese/implementação (ajustar conforme ferramentas instaladas).
- tangnano.cst / tangnano.lpf / tangnano.pcf — arquivos de constraints/pinos para diferentes plataformas.
- piscaled.qpf / piscaled.qsf / piscaled.qws — projeto Quartus (opcional, alternativa ao makefile).
- db/ — diretório de build do Quartus (gerado automaticamente).
- incremental_db/ — diretório incremental do Quartus (gerado automaticamente).
- output_files/ — saídas finais (bitstream `.fs` ou `.sof`).
- simulation/questa/ — arquivos de simulação (Questa/ModelSim).
- readme.md — este arquivo.

Como simular (ModelSim / Questa)
1. Navegue até a pasta simulation/questa/.
2. Compile as fontes:
   - vlog ../../piscaled.v
3. Simule:
   - vsim work.piscaled
4. Carregue waveforms ou VCDs existentes conforme necessário.

Como sintetizar
Opção 1: Makefile (recomendado para fluxo aberto)
- Edite o makefile e certifique-se de que as ferramentas (Yosys, nextpnr, gowin_pack, openFPGALoader) estão instaladas.
- Atualizar `NEXTPNR` conforme backend:
  - `nextpnr-gowin` suporta `--cst <file>` (constraints).
  - `nextpnr-himbaechel` **não** reconhece `--cst`; remova `--cst $(PINS)` do `NEXTPNR_FLAGS` se usar himbaechel.
- Execute:
  - `make` — gera `.json` → PNR → `.fs`
  - `make load` — programa a placa via openFPGALoader
  - `make clean` — remove arquivos gerados

Opção 2: Quartus (GUI ou linha de comando)
- Abra piscaled.qpf em Quartus Prime.
- Compile: Compile → Start Compilation.
- Saída bitstream em output_files/piscaled.sof.

Como programar a placa
Com openFPGALoader (se usar makefile + Gowin):
````bash
openFPGALoader -b tangnano output_files/piscaled.fs