`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2023 09:40:42
// Design Name: 
// Module Name: top_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_counter(
    input clk_100mhz,
    input rst,
    output [5:0] sec_count ,
    output [5:0] min_count
    );
    wire clk_8mhz , clk_1hz;
    clk_wiz_0 cm1
   (
    // Clock out ports
    .clk_in1(clk_100mhz),     // output clk_8mhz
   // Clock in ports
    .clk_out1(clk_8mhz)
    );  
    
    clk_div_rtl cd1(.clk_8mhz(clk_8mhz), .clk_1hz(clk_1hz));
     //dig_clock dc(.clk_1hz(clk_1hz),.rst(rst),.sec_count(sec_count) , .min_count(min_count));
endmodule
