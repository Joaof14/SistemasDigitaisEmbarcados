# Embedded Digital Systems

This repository contains projects developed for the **Embedded Digital Systems** course, using **Verilog (HDL)** for FPGA simulation and synthesis.

## Included Projects

- **projeto0/** — Pixel Scaling (RTL)
  - Pixel scaler for image processing.
  - Flow: Yosys + nextpnr or Quartus.
  - Target: Tang Nano / Cyclone.

- **projeto1/** — Up/Down Counter (RTL)
  - 16-bit bidirectional counter with overflow/underflow detection.
  - Inputs: U (increment), D (decrement).
  - Output: C (16 bits).
  - Implementation: datapath + control unit (FSM).

- **projeto2/** — Candy Machine (RTL)
  - Coin manager and candy dispenser system.
  - Inputs: C1C0 (coin type), S (request button).
  - Outputs: D (12-bit accumulator), R (release pulse).
  - Logic: sums coins, authorizes sale when balance ≥ 80¢.

- **PerceptronEmbarcado/** — Perceptron (RTL)
  - Hardware implementation of a perceptron neural network.
  - Flow: Quartus.

## How to Simulate

1. Enter the desired project folder.
2. Compile source and testbench files:
   ```bash
   vlog src/*.v test/*.v
   ```
3. Run the testbench:
   ```bash
   vsim work.test_system
   ```
4. (Optional) Use TCL scripts to add signals to the waveform:
   ```bash
   do sim/run_System.tcl
   ```

## How to Synthesize

- **Project 0 (Makefile + Yosys/nextpnr):**
  ```bash
  cd projeto0
  make              # generates bitstream
  make load         # programs the board
  make clean        # cleans build files
  ```
  > Note: If using `nextpnr-himbaechel`, remove the `--cst` option from the Makefile.

- **Projects with Quartus:**
  - Open the `.qpf` project in Quartus Prime.
  - Compile and program using Quartus Programmer.

## Typical Project Structure

```
projetoX/
├── src/                 # Verilog sources
├── test/                # Testbenches
├── sim/                 # Simulation scripts
├── output_files/        # Synthesis outputs
├── db/ / incremental_db/  # Build directories (ignore)
├── makefile             # Build script (if applicable)
├── *.cst / *.lpf / *.pcf  # Pin constraints
├── *.qpf / *.qsf        # Quartus project (if applicable)
└── readme.md            # Project documentation
```

## Quick Tips

- High impedance signals (`z`): check if the port is connected in the top module.
- Buttons: edge detection (`u && !u_prev`) **is not debounce**; for real hardware, implement a temporal filter.
- Compilation errors: review instance names and module connections.
- For flow questions, see the specific project readme.

## License

This repository is licensed under the **MIT License**:




# Sistemas Digitais Embarcados

Este repositório reúne projetos desenvolvidos na disciplina de **Sistemas Digitais Embarcados**, utilizando **Verilog (HDL)** para simulação e síntese em FPGA.

## Projetos incluídos

- **projeto0/** — Escala de Pixel (RTL)
  - Escalonador de pixel para processamento de imagem.
  - Fluxo: Yosys + nextpnr ou Quartus.
  - Alvo: Tang Nano / Cyclone.

- **projeto1/** — Contador U/D (RTL)
  - Contador bidirecional de 16 bits com detecção de overflow/underflow.
  - Entradas: U (incrementa), D (decrementa).
  - Saída: C (16 bits).
  - Implementação: datapath + unidade de controle (FSM).

- **projeto2/** — Máquina de Doces (RTL)
  - Sistema gerenciador de moedas e dispensa de doces.
  - Entradas: C1C0 (tipo de moeda), S (botão de solicitação).
  - Saídas: D (acumulador 12 bits), R (pulso de liberação).
  - Lógica: soma moedas, autoriza venda quando saldo ≥ 80¢.

- **PerceptronEmbarcado/** — Perceptron (RTL)
  - Implementação de rede neural perceptron em hardware.
  - Fluxo: Quartus.

## Como simular

1. Entre na pasta do projeto desejado.
2. Compile os arquivos fonte e testbench:
   ```bash
   vlog src/*.v test/*.v
   ```
3. Execute o testbench:
   ```bash
   vsim work.test_system
   ```
4. (Opcional) Use scripts TCL para adicionar sinais ao waveform:
   ```bash
   do sim/run_System.tcl
   ```

## Como sintetizar

- **Projeto 0 (Makefile + Yosys/nextpnr):**
  ```bash
  cd projeto0
  make              # gera bitstream
  make load         # programa a placa
  make clean        # limpa builds
  ```
  > Atenção: Se usar `nextpnr-himbaechel`, remova a opção `--cst` do Makefile.

- **Projetos com Quartus:**
  - Abra o projeto `.qpf` no Quartus Prime.
  - Compile e programe via Quartus Programmer.

## Estrutura típica dos projetos

```
projetoX/
├── src/                 # Fontes Verilog
├── test/                # Testbenches
├── sim/                 # Scripts de simulação
├── output_files/        # Saídas de síntese
├── db/ / incremental_db/  # Diretórios de build (ignorar)
├── makefile             # Script de build (se aplicável)
├── *.cst / *.lpf / *.pcf  # Constraints (pinos)
├── *.qpf / *.qsf        # Projeto Quartus (se aplicável)
└── readme.md            # Documentação específica do projeto
```

## Dicas rápidas

- Sinais em alta impedância (`z`): verifique se a porta está conectada no módulo superior.
- Botões: a detecção de borda (`u && !u_prev`) **não é debounce**; para hardware real, implemente filtro temporal.
- Erros de compilação: revise nomes de instâncias e conexões entre módulos.
- Para dúvidas sobre fluxo, consulte o readme específico de cada projeto.

## Licença

Este repositório está licenciado sob a **MIT License**:

