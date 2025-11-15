# Project 0 — Pixel Scaling (RTL)

## Description
- FPGA project in Verilog implementing a pixel scaler for image processing applications.
- Synthesis flow with Yosys + nextpnr or Quartus, targeting Tang Nano / Cyclone.
- Includes sources, constraints, makefile, and simulation scripts.

## Project Structure
- piscaled.v — main module source.
- makefile — synthesis/build script (adjust for your installed tools).
- tangnano.cst / tangnano.lpf / tangnano.pcf — pin constraint files for different platforms.
- piscaled.qpf / piscaled.qsf / piscaled.qws — Quartus project files (optional, alternative to makefile).
- db/ — Quartus build directory (auto-generated).
- incremental_db/ — Quartus incremental build directory (auto-generated).
- output_files/ — final outputs (bitstream `.fs` or `.sof`).
- simulation/questa/ — simulation files (Questa/ModelSim).
- readme.md — this file.

## How to Simulate (ModelSim / Questa)
1. Go to simulation/questa/.
2. Compile sources:
   - vlog ../../piscaled.v
3. Simulate:
   - vsim work.piscaled
4. Load existing waveforms or VCDs as needed.

## How to Synthesize
Option 1: Makefile (recommended for open flow)
- Edit the makefile and ensure tools (Yosys, nextpnr, gowin_pack, openFPGALoader) are installed.
- Update `NEXTPNR` according to backend:
  - `nextpnr-gowin` supports `--cst <file>` (constraints).
  - `nextpnr-himbaechel` **does not** recognize `--cst`; remove `--cst $(PINS)` from `NEXTPNR_FLAGS` if using himbaechel.
- Run:
  - `make` — generates `.json` → PNR → `.fs`
  - `make load` — programs the board via openFPGALoader
  - `make clean` — removes generated files

Option 2: Quartus (GUI or command line)
- Open piscaled.qpf in Quartus Prime.
- Compile: Compile → Start Compilation.
- Bitstream output in output_files/piscaled.sof.

##  How to Program the Board
With openFPGALoader (if using makefile + Gowin):
```bash
openFPGALoader -b tangnano output_files/piscaled.fs
```

With Quartus Programmer:
- Open Quartus → Tools → Programmer.
- Load output_files/piscaled.sof.
- Select the board and program.

##  Tips & Troubleshooting
- If make returns "nextpnr-himbaechel: unrecognised option '--cst'", switch `NEXTPNR` to `nextpnr-gowin` or remove `--cst` from `NEXTPNR_FLAGS`.
- Check constraints (tangnano.cst / .lpf / .pcf) for your board.
- For debugging, expose internal signals in simulation and inspect VCDs.
- If compilation fails, check piscaled.v syntax and generated logs.

## License
This project is licensed under the MIT License.



# Projeto 0 — Escala de Pixel (RTL)

## Descrição
- Projeto FPGA em Verilog que implementa um escalonador de pixel para aplicações de processamento de imagem.
- Fluxo de síntese com Yosys + nextpnr ou Quartus, alvo Tang Nano / Cyclone.
- Inclui fontes, constraints, makefile e scripts de simulação.

## Estrutura do projeto
- piscaled.v — fonte principal do módulo.
- makefile — script para síntese/implementação (ajustar conforme ferramentas instaladas).
- tangnano.cst / tangnano.lpf / tangnano.pcf — arquivos de constraints/pinos para diferentes plataformas.
- piscaled.qpf / piscaled.qsf / piscaled.qws — projeto Quartus (opcional, alternativa ao makefile).
- db/ — diretório de build do Quartus (gerado automaticamente).
- incremental_db/ — diretório incremental do Quartus (gerado automaticamente).
- output_files/ — saídas finais (bitstream `.fs` ou `.sof`).
- simulation/questa/ — arquivos de simulação (Questa/ModelSim).
- readme.md — este arquivo.

## Como simular (ModelSim / Questa)
1. Navegue até a pasta simulation/questa/.
2. Compile as fontes:
   - vlog ../../piscaled.v
3. Simule:
   - vsim work.piscaled
4. Carregue waveforms ou VCDs existentes conforme necessário.

## Como sintetizar
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

##  Como programar a placa
Com openFPGALoader (se usar makefile + Gowin):
````bash
openFPGALoader -b tangnano output_files/piscaled.fs
````

## Licença

Este repositório está licenciado sob a **MIT License**: