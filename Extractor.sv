`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2024 17:00:37
// Design Name: 
// Module Name: Extractor
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
module Extractor(
    input cmd_t Instr,
    input immsrc_e ImmSrc,
    output logic [XLEN-1:0] ImmExt
    );
    always_comb begin
        case(ImmSrc)
            IMM_I: begin
                 ImmExt <= { {20{Instr[31]}}, Instr.i.imm_11_0};
            end
            IMM_S: begin
                 ImmExt <= { {20{Instr[31]}},
                 Instr.s.imm_11_5,
                 Instr.s.imm_4_0};
            end
            IMM_B: begin
                 ImmExt <= { {19{Instr[31]}}, Instr.b.imm_12, Instr.b.imm_11,
                 Instr.b.imm_10_5, Instr.b.imm_4_1, 1'b0};
            end
            IMM_U: begin
                 ImmExt <= {Instr.u.imm_31_12, {12{1'b0}}};
            end
            IMM_J: begin
                 ImmExt <= { {12{Instr[31]}}, Instr.j.imm_20, Instr.j.imm_19_12, Instr.j.imm_11,
                 Instr.j.imm_10_1,1'b0};
            end
            default: 
                 ImmExt<='X;
        endcase
    end
endmodule
