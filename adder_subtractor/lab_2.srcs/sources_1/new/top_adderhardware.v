`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2023 09:55:43
// Design Name: 
// Module Name: top_adderhardware
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


module top_adderhardware(
    input clk
    );
    wire M;
    wire[4:0] OutSum;
    wire[3:0] InA,InB;
    vio_1 v1 (
  .clk(clk),                // input wire clk
  .probe_in0(OutSum),    // input wire [4 : 0] probe_in0
  .probe_out0(InA),  // output wire [3 : 0] probe_out0
  .probe_out1(InB),  // output wire [3 : 0] probe_out1
  .probe_out2(M)  // output wire [0 : 0] probe_out2
);

    top_adder ta(.M(M) , .InA(InA) , .InB(InB), .OutSum(OutSum) );
endmodule
