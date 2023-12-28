`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2023 09:51:44
// Design Name: 
// Module Name: vio_wrapper
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


module vio_wrapper(
    input clk_100mhz
    );
    wire rst;
    wire[7:0] count;
    vio_0 v1 (
      .clk(clk_100mhz),                // input wire clk
      .probe_in0(count),    // input wire [7 : 0] probe_in0
      .probe_out0(rst)  // output wire [0 : 0] probe_out0
    );  
    top_counter tc( .clk_100mhz(clk_100mhz), .rst(rst), .count(count) );
endmodule
