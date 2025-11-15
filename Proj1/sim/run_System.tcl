vlib work
vmap work work

vlog ../src/adder_sub_1bit.v
vlog ../src/adder_sub_16bit.v  
vlog ../src/comparators.v
vlog ../src/register_16bit.v
vlog ../src/datapath.v
vlog ../src/control_unit.v
vlog ../src/top_system.v
vlog ../test/test_system.v

vsim test_system
add wave -radix decimal /test_system/dut/c_out
add wave /test_system/dut/fsm/current_state
add wave /test_system/dut/fsm/c_ld
add wave /test_system/dut/fsm/c_clr
add wave /test_system/dut/fsm/op
add wave /test_system/u
add wave /test_system/d
add wave /test_system/dut/dp/z
add wave /test_system/dut/dp/m

run 1000ns
