vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../ipstatic" \
"C:/Users/Saarthak/Desktop/Academia/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Users/Saarthak/Desktop/Academia/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic" \
"../../../../Lab3.srcs/sources_1/ip/clk_div_cmt/clk_div_cmt_clk_wiz.v" \
"../../../../Lab3.srcs/sources_1/ip/clk_div_cmt/clk_div_cmt.v" \

vlog -work xil_defaultlib \
"glbl.v"

