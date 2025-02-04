`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2024 16:21:20
// Design Name: 
// Module Name: mx2
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
module mx2(
    input[XLEN-1:0] A0,
    input[XLEN-1:0] A1,
    input PC,
    output logic[XLEN-1:0] F
    );
    always_comb begin
        F<=PC?A1:A0;
    end
endmodule
