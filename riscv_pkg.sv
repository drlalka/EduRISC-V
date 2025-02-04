`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 17:03:13
// Design Name: 
// Module Name: riscv_pkg
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

package riscv_pkg;
    typedef enum {ALU_ADD,
                  ALU_SUB,
                  ALU_XOR,
                  ALU_OR,
                  ALU_AND,
                  ALU_SLL,
                  ALU_SRL,
                  ALU_SRA,
                  ALU_SLT,
                  ALU_SLTU
                 } alu_cmd_t;
    typedef enum {
                 IMM_I,
                 IMM_S,
                 IMM_B,
                 IMM_J,
                 IMM_U
                 } immsrc_e;
    typedef enum logic[6:0] {
                 LOAD =7'b0000011,
                 STORE=7'b0100011,
                 BRANCH=7'b1100011,
                 JALR=7'b1100111,
                 JAL=7'b1101111,
                 OPIMM=7'b0010011,
                 AUIPC=7'b0010111,
                 LUI=7'b0110111,
                 OP=7'b0110011
    } cmd_op;
    typedef struct packed {
        logic[31:25] func7;
        logic[24:20] rs2;
        logic[19:15] rs1;
        logic[14:12] func3;
        logic[11:7] rd;
        logic[6:0] opcode;
    } r_cmd_t;
    typedef struct packed {
        logic[31:20] imm_11_0;
        logic[19:15] rs1;
        logic[14:12] func3;
        logic[11:7] rd;
        logic[6:0] opcode;
    } i_cmd_t;
    typedef struct packed {
        logic[31:25] imm_11_5;
        logic[24:20] rs2;
        logic[19:15] rs1;
        logic[14:12] func3;
        logic[11:7] imm_4_0;
        logic[6:0] opcode;
    } s_cmd_t;
    typedef struct packed {
        logic imm_12;
        logic[30:25] imm_10_5;
        logic[24:20] rs2;
        logic[19:15] rs1;
        logic[14:12] func3;
        logic[11:8] imm_4_1;
        logic imm_11;
        logic[6:0] opcode;
    } b_cmd_t;
    typedef struct packed {
        logic[31:12] imm_31_12;
        logic[11:7] rd;
        logic[6:0] opcode;
    } u_cmd_t;
    typedef struct packed {
        logic imm_20;
        logic[30:21] imm_10_1;
        logic imm_11;
        logic[19:12] imm_19_12;
        logic[11:7] rd;
        logic[6:0] opcode;
    } j_cmd_t;
    typedef union packed{
        struct packed{
        logic[31:7] bits;
        logic[6:0] opcode;
        } raw;
        r_cmd_t r;
        i_cmd_t i;
        s_cmd_t s;
        b_cmd_t b;
        u_cmd_t u;
        j_cmd_t j;
    } cmd_t;
    localparam XLEN = 32;
    localparam REG_CNT = 32;
    localparam REG_AWIDTH = $clog2(REG_CNT);
    /*typedef enum logic[6:0] {} RV_OPCODE;*/
endpackage : riscv_pkg
