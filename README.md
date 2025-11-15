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

```
MIT License

Copyright (c) 2025 João

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---
**Última atualização:** 15 de novembro de 2025
