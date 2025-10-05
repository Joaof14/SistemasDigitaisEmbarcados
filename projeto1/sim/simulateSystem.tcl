# Cria biblioteca de trabalho
vlib work
vmap work work

# Compila todos os módulos
vlog ../src/adder_sub_1bit.v
vlog ../src/adder_sub_16bit.v  
vlog ../src/comparators.v
vlog ../src/register_16bit.v
vlog ../src/datapath.v
vlog ../src/control_unit.v
vlog ../src/top_system.v
vlog ../test/test_system.v

# Simula o testbench
vsim test_system

# Adiciona sinais à janela de onda
add wave -radix decimal /test_system/dut/c_out
add wave /test_system/dut/fsm/current_state
add wave /test_system/dut/fsm/op
add wave /test_system/dut/fsm/c_ld
add wave /test_system/dut/fsm/c_clr
add wave /test_system/u
add wave /test_system/d
add wave /test_system/dut/dp/z
add wave /test_system/dut/dp/m

# Roda a simulação
run 1000ns