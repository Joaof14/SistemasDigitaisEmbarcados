# Define o diretório de trabalho
set work work

# Define os caminhos relativos
set src_dir "../src"
set test_dir "../test"

# Cria a library work
vlib $work

# Compila os módulos do datapath
vlog -reportprogress 300 -work work $src_dir/datapath.v
vlog -reportprogress 300 -work work $test_dir/test_datapath.v

# Simula o testbench
vsim -voptargs="+acc" test_datapath

# Adiciona todas as ondas do datapath
add wave -position insertpoint \
sim:/test_datapath/uut/* \
sim:/test_datapath/uut/reg_c/* \
sim:/test_datapath/uut/alu/* \
sim:/test_datapath/uut/comp/*

# Configura a visualização
wave zoom full

# Roda a simulação
run -all

# Mantém a janela aberta
wave clock clk