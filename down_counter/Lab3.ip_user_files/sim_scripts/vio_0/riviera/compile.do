vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../Lab3.srcs/sources_1/ip/vio_0/hdl/verilog" "+incdir+../../../../Lab3.srcs/sources_1/ip/vio_0/hdl" \
"C:/Users/Saarthak/Desktop/Academia/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Users/Saarthak/Desktop/Academia/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Lab3.srcs/sources_1/ip/vio_0/hdl/verilog" "+incdir+../../../../Lab3.srcs/sources_1/ip/vio_0/hdl" \
"../../../../Lab3.srcs/sources_1/ip/vio_0/sim/vio_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

