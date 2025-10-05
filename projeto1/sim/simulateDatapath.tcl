# Cria biblioteca de trabalho
vlib work
vmap work work

# Compila todos os módulos
vlog ../src/adder_sub_1bit.v
vlog ../src/adder_sub_16bit.v  
vlog ../src/comparators.v
vlog ../src/register_16bit.v
vlog ../src/datapath.v
vlog ../test/test_datapath.v

# Simula o testbench
vsim test_datapath

# Adiciona sinais à janela de onda
add wave -radix decimal /test_datapath/dut/current_c
add wave /test_datapath/dut/op
add wave /test_datapath/dut/c_ld
add wave /test_datapath/dut/c_clr
add wave /test_datapath/dut/z
add wave /test_datapath/dut/m

# Roda a simulação
run 500ns