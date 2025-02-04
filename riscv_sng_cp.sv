`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2024 15:48:01
// Design Name: 
// Module Name: riscv_sng_cp
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

module riscv_sng_cp
    import riscv_pkg::*;
(
    input logic[XLEN-1:0] i_inst,
    input logic i_zero_f,
    output logic o_pc_src,
    output logic o_tar_src,
    output logic o_rg_wr,
    output immsrc_e o_immsrc,
    output logic o_mem_wr,
    output logic o_alu_src_sel,
    output alu_cmd_t o_alu_cmd,
    output logic[2:0] o_res_src_sel,
    output logic o_alu_inv
);
/*main decoder*/
logic [1:0] ALUOp;
logic [1:0] branch; 
cmd_t cmd;
assign cmd = i_inst;
always_comb begin
    case(cmd.r.opcode)
        LOAD: begin
            o_tar_src<=1'b0;
            o_rg_wr<=1'b1;
            o_immsrc<=IMM_I;
            o_alu_src_sel<=1'b1;
            o_mem_wr<=1'b0;
            o_res_src_sel <= 3'b001;
            branch <= 2'b00;
            ALUOp<=2'b00;
        end
        STORE: begin
            o_tar_src<=1'b0;
            o_rg_wr<=1'b0;
            o_immsrc<=IMM_S;
            o_alu_src_sel<=1'b1;
            o_mem_wr<=1'b1;
            o_res_src_sel <= 3'bxxx;
            branch <= 2'b00;
            ALUOp<=2'b00;
        end
        BRANCH: begin
            o_tar_src<=1'b0;
            o_rg_wr<=1'b0;
            o_immsrc<=IMM_B;
            o_alu_src_sel<=1'b0;
            o_mem_wr<=1'b0;
            o_res_src_sel <= 3'bxxx;
            branch <= 2'b01;
            ALUOp<=2'b01;
        end
        OP: begin
            o_tar_src<=1'bx;
            o_rg_wr<=1'b1;
            o_immsrc<=immsrc_e'('x);
            o_alu_src_sel<=1'b0;
            o_mem_wr<=1'b0;
            o_res_src_sel <= 3'b000;
            branch <= 2'b00;
            ALUOp <= 2'b10;
        end
        OPIMM: begin
            o_tar_src<=1'bx;
            o_rg_wr<=1'b1;
            o_immsrc<=IMM_I;
            o_alu_src_sel<=1'b1;
            o_mem_wr<=1'b0;
            o_res_src_sel <= 3'b000;
            branch <= 2'b00;
            ALUOp <= 2'b10;
        end
        JAL: begin
            o_tar_src<=1'b0;
            o_rg_wr<=1'b1;
            o_immsrc<=IMM_J;
            o_alu_src_sel<=1'bx;
            o_mem_wr<=1'b0;
            o_res_src_sel <= 3'b010;
            branch <= 2'b11;
            ALUOp <= 2'bxx;
        end
        JALR: begin
            o_tar_src<=1'b1;
            o_rg_wr<=1'b1;
            o_immsrc<=IMM_I;
            o_alu_src_sel<=1'bx;
            o_mem_wr<=1'b0;
            o_res_src_sel <= 3'b010;
            branch <= 2'b11;
            ALUOp <= 2'bxx;
        end
        LUI: begin
            o_tar_src<=1'bx;
            o_rg_wr<=1'b1;
            o_immsrc<=IMM_U;
            o_alu_src_sel<=1'bx;
            o_mem_wr<=1'b0;
            o_res_src_sel <= 2'b011;
            branch <= 2'b00;
            ALUOp <= 2'bxx;
        end
        AUIPC: begin
            o_tar_src<=1'b0;
            o_rg_wr<=1'b1;
            o_immsrc<=IMM_U;
            o_alu_src_sel<=1'bx;
            o_mem_wr<=1'b0;
            o_res_src_sel <= 3'b100;
            branch <= 2'b00;
            ALUOp <= 2'bxx;
        end
        default: begin 
            o_tar_src<=1'bx;
            o_rg_wr<=1'bx;
            o_immsrc<=immsrc_e'('x);
            o_alu_src_sel<=1'bx;
            o_mem_wr<=1'bx;
            o_res_src_sel <= 3'bxxx;
            branch <= 2'bxx;
            ALUOp <= 2'bxx;
        end
    endcase 
end
/*ALU decod*/
    always_comb begin
        if({ALUOp, cmd.r.func7[30]}==3'b100) begin
            o_alu_inv <= 0;
        end
        casez({ALUOp, cmd.r.func3, cmd.r.opcode[5], cmd.r.func7[30]})
            7'b00?????: o_alu_cmd <= ALU_ADD;
            7'b010????: o_alu_cmd <= ALU_SUB;
            7'b1000011: begin
                o_alu_inv <= 0;
                o_alu_cmd <= ALU_SUB;
            end
            7'b10000??: o_alu_cmd <= ALU_ADD;
            7'b10010??: o_alu_cmd <= ALU_SLT;
            7'b0110???: o_alu_cmd <= ALU_SLT;
            7'b10001??: o_alu_cmd <= ALU_SLL;
            7'b10011??: o_alu_cmd <= ALU_SLTU;
            7'b0111???: o_alu_cmd <= ALU_SLTU;
            7'b10100?0: o_alu_cmd <= ALU_XOR;
            7'b10100?1: begin 
                o_alu_inv <= 1;
                o_alu_cmd <= ALU_XOR;
            end
            7'b1010110: o_alu_cmd <= ALU_SRL;
            7'b1010111: o_alu_cmd <= ALU_SRA;
            7'b10110??: o_alu_cmd <= ALU_OR;
            7'b10111??: o_alu_cmd <= ALU_AND;
            default : o_alu_cmd<= alu_cmd_t'('x);
        endcase
    end
/*branch mult*/
    always_comb begin
        case(branch)
            2'b00:
                o_pc_src<=0;
            2'b11:
                o_pc_src<=1;
            2'b01:
                o_pc_src<=i_zero_f ^ cmd.r.func3[14];
        endcase
    end
endmodule
