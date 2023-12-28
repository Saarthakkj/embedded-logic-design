vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../Lab3.srcs/sources_1/ip/vio_0/hdl/verilog" "+incdir+../../../../Lab3.srcs/sources_1/ip/vio_0/hdl" \
"C:/Users/Saarthak/Desktop/Academia/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Users/Saarthak/Desktop/Academia/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../Lab3.srcs/sources_1/ip/vio_0/hdl/verilog" "+incdir+../../../../Lab3.srcs/sources_1/ip/vio_0/hdl" \
"../../../../Lab3.srcs/sources_1/ip/vio_0/sim/vio_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

