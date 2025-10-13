# Define o diretório de trabalho
set work work

# Define os caminhos relativos
set src_dir "../src"
set test_dir "../test"

# Cria a library work
vlib $work

# Compila todos os módulos do sistema
vlog -reportprogress 300 -work work $src_dir/datapath.v
vlog -reportprogress 300 -work work $src_dir/control_unit.v
vlog -reportprogress 300 -work work $src_dir/top_system.v
vlog -reportprogress 300 -work work $test_dir/test_system.v

# Simula o testbench
vsim -voptargs="+acc" test_system

# Adiciona todas as ondas do sistema
add wave -position insertpoint \
sim:/test_system/uut/* \
sim:/test_system/uut/fsm/* \
sim:/test_system/uut/dp/* \
sim:/test_system/uut/dp/reg_c/* \
sim:/test_system/uut/dp/alu/* \
sim:/test_system/uut/dp/comp/*

# Configura a visualização
wave zoom full

# Roda a simulação
run -all

# Mantém a janela aberta
wave clock clk