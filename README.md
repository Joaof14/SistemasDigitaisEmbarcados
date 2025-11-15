

# Sistemas Digitais EmbarcadosRepositório com projetos da disciplina de **Sistemas Digitais Embarcados**, implementados em **Verilog (HDL)** com fluxos de simulação e síntese para FPGA.## 📋 Conteúdo do repositório### Projetos- **projeto0/** — Escala de Pixel (RTL)  - Escalonador de pixel para processamento de imagem.  - Fluxo: Yosys + nextpnr / Quartus.  - Alvo: Tang Nano / Cyclone.  - [Veja readme](projeto0/readme.md)- **projeto1/** — Contador U/D (RTL)  - Contador bidirecional 16 bits com detecção de overflow/underflow.  - Entradas: U (incrementa), D (decrementa).  - Saída: C (16 bits, valor do contador).  - Implementação: datapath + control unit (FSM).  - [Veja readme](projeto1/readme.md)- **projeto2/** — Máquina de Doces (RTL)  - Sistema gerenciador de moedas e dispensa de doces.  - Entradas: C1C0 (tipo de moeda), S (botão de solicitação).  - Saídas: D (acumulador 12 bits), R (pulso de liberação).  - Lógica: soma moedas, autoriza venda quando saldo ≥ 80¢.  - [Veja readme](projeto2/readme.md)- **PerceptronEmbarcado/** — Perceptron (RTL)  - Implementação de rede neural perceptron em hardware.  - Fluxo: Quartus.  - [Veja readme](PerceptronEmbarcado/readme.md)## 🚀 Como começar### Simular um projeto (ModelSim / Questa)1. Navegue até a pasta do projeto (ex.: `projeto1/`).2. Compile:   ````bash   vlog src/*.v test/*.v
Simule:

vsim work.test_system
(Opcional) Use scripts TCL para adicionar waveforms:

do sim/run_System.tcl
Sintetizar para FPGA
Projeto 0 (Makefile + Yosys/nextpnr):


cd projeto0make              # gera bitstreammake load         # programa a placamake clean        # limpa builds
Projeto 1 e 2 (Quartus):

Abra arquivo .qpf em Quartus Prime.
Compile e programe via Quartus Programmer.
🔧 Requisitos
Simulação:

ModelSim / Questa / Vivado Simulator / iverilog + gtkwave
Síntese:

Projeto 0: Yosys, nextpnr, gowin_pack, openFPGALoader (fluxo aberto) OU Quartus Prime
Projeto 1-2: Quartus Prime
PerceptronEmbarcado: Quartus Prime
Hardware (opcional):

Tang Nano 1K / Tang Nano 4K (Gowin FPGA)
Intel Cyclone / Altera (Quartus)
📚 Estrutura comum dos projetos

projetoX/├── src/                 # Fontes Verilog│   ├── *.v             # Módulos principais│   └── ...├── test/               # Testbenches│   ├── test_*.v        # Testbenches para simulação│   └── ...├── sim/                # Scripts de simulação│   ├── *.tcl           # Scripts para ModelSim/Questa│   └── *.vcd           # Waveforms (saídas de simulação)├── output_files/       # Saídas de síntese (bitstream, `.sof`, `.fs`)├── db/ / incremental_db/  # Diretórios de build (ignorar)├── makefile            # Script de build (se aplicável)├── *.cst / *.lpf / *.pcf  # Constraints (pinos)├── *.qpf / *.qsf       # Projeto Quartus (se aplicável)└── readme.md           # Documentação específica do projeto
⚠️ Dicas importantes
Alta impedância (z) em sinais: verifique se a porta está conectada no módulo superior (ex.: top_system.c_out).
Botões não reagem: inspecione se a FSM detecta borda corretamente (u && !u_prev).
Debounce: a detecção de borda não é debounce; para aplicações reais, implemente filtro temporal.
nextpnr com himbaechel: remova --cst do NEXTPNR_FLAGS se não suportado.
Erros de compilação: verifique sintaxe Verilog, nomes de módulos/portas e que testbenches referenciam instâncias corretas (uut, não dut).
📖 Documentação
Cada projeto tem seu próprio readme.md com detalhes específicos.
Para fluxo de síntese detalhado, veja projeto0/readme.md.
Para simular e depurar, veja projeto1/readme.md (referência de boas práticas).
📄 Licença
Todos os projetos neste repositório são licenciados sob a MIT License.




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

