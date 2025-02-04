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
module mx5(
    input[XLEN-1:0] A0,
    input[XLEN-1:0] A1,
    input[XLEN-1:0] A2,
    input[XLEN-1:0] A3,
    input[XLEN-1:0] A4,
    input[2:0] S,
    output logic[XLEN-1:0] F
    );
    always_comb begin
        case(S)
            3'b000:
                F<=A0;
            3'b001:
                F<=A1;
            3'b010:
                F<=A2;
            3'b011:
                F<=A3;
            3'b100:
                F<=A4;
            default:
                F<='x;
        endcase
    end
endmodule
