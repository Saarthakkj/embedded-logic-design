`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2023 09:04:23
// Design Name: 
// Module Name: Counter_8bit
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


module Counter_8bit(
    input clk_1hz,
    input rst,
    input [7:0] count
    );
    reg[7:0] count_reg = 255;
    reg[7:0] count_next = 0;
    always@(posedge clk_1hz )
        begin
            if(rst)
                count_reg <= 0;
            else
                count_reg <= count_next-1;
        end
    always@(*)
        begin
            count_next = count_reg;
        end
    assign count = count_reg;
      
endmodule
