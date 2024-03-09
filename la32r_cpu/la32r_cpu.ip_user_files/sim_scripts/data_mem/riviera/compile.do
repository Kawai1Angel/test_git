transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/Users/15049/Desktop/work/la32r_cpu/la32r_cpu.cache/compile_simlib/riviera}
vlib riviera/blk_mem_gen_v8_4_6
vlib riviera/xil_defaultlib

vlog -work blk_mem_gen_v8_4_6  -incr -v2k5 -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l blk_mem_gen_v8_4_6 -l xil_defaultlib \
"../../../../la32r_cpu.gen/sources_1/ip/data_mem/sim/data_mem.v" \


vlog -work xil_defaultlib \
"glbl.v"

