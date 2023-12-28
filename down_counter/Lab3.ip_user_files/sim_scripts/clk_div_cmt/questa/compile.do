vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../ipstatic" \
"C:/Users/Saarthak/Desktop/Academia/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Users/Saarthak/Desktop/Academia/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" \
"../../../../Lab3.srcs/sources_1/ip/clk_div_cmt/clk_div_cmt_clk_wiz.v" \
"../../../../Lab3.srcs/sources_1/ip/clk_div_cmt/clk_div_cmt.v" \

vlog -work xil_defaultlib \
"glbl.v"

