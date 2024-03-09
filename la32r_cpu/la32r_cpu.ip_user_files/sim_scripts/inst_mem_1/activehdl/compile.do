transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/Users/15049/Desktop/work/la32r_cpu/la32r_cpu.cache/compile_simlib/activehdl}
vlib activehdl/blk_mem_gen_v8_4_6
vlib activehdl/xil_defaultlib

vlog -work blk_mem_gen_v8_4_6  -v2k5 -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"../../../../la32r_cpu.gen/sources_1/ip/inst_mem_1/sim/inst_mem.v" \


vlog -work xil_defaultlib \
"glbl.v"

