vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 "+incdir+../../../../lab_2.srcs/sources_1/ip/vio_1/hdl/verilog" "+incdir+../../../../lab_2.srcs/sources_1/ip/vio_1/hdl" \
"../../../../lab_2.srcs/sources_1/ip/vio_1/sim/vio_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

