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
module sum(
    input[XLEN-1:0] A0,
    input[XLEN-1:0] A1,
    output logic[XLEN-1:0] F
    );
    always_comb begin
        F<=A0+A1;
    end
endmodule
