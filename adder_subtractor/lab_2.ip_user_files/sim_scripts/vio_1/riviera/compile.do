vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../lab_2.srcs/sources_1/ip/vio_1/hdl/verilog" "+incdir+../../../../lab_2.srcs/sources_1/ip/vio_1/hdl" \
"../../../../lab_2.srcs/sources_1/ip/vio_1/sim/vio_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

