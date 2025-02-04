`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2024 16:31:36
// Design Name: 
// Module Name: sum
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


import riscv_pkg::*;
module reg_c(
    logic clk,
    logic reset,
    input[XLEN-1:0] A0,
    output logic[XLEN-1:0] F
    );
    always_ff @(posedge clk) begin
        F<=reset?0:A0;
    end
endmodule