`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2024 14:41:38
// Design Name: 
// Module Name: riscv_sng_dp
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


module riscv_sng_dp
    import riscv_pkg::*;
(
    input logic i_clk,i_rst,
    //Prog Mem
    output logic[XLEN-1:0] o_inst_addr,
    input logic[XLEN-1:0] i_inst,
    //Data Mem
    output logic [XLEN-1:0] o_data_addr,
    output logic [XLEN-1:0] o_wr_data,
    input logic [XLEN-1 :0] i_rd_data,
    //Rule signals and flags
    output logic o_zero_f,
    input logic i_pc_src,
    input logic i_tar_src,
    input logic i_rg_wr,
    input immsrc_e i_immsrc,
    input logic i_alu_src_sel,
    input i_alu_inv,
    input alu_cmd_t i_alu_cmd,
    input logic[2:0] i_res_src_sel
    );
    /*counter*/
    logic [XLEN-1:0] pc;
    logic [XLEN-1:0] pc_next;
    logic [XLEN-1:0] pc_tar;
    logic [XLEN-1:0] pc_plus4;
    logic [XLEN-1:0] tar_base;
    sum Sum_cnt(pc, 4, pc_plus4);
    mx2 mx_cnt(pc_plus4, {pc_tar[XLEN-1:1],1'b0}, i_pc_src, pc_next);
    reg_c reg_cnt(i_clk, i_rst, pc_next, pc);
    mx2 mx_tar(pc, SrcA, i_tar_src, tar_base);
    sum Sum_targ(tar_base, ImmExt, pc_tar);
    /*prog_mem*/
    assign o_inst_addr = pc;
    /*reg_mem*/
    logic[XLEN-1:0] SrcA;
    logic[XLEN-1:0] SrcB0;
    regmem Reg_file(i_clk, result, i_inst[19:15], i_inst[24:20], i_inst[11:7], i_rg_wr, SrcA, SrcB0);
    /*Extraction*/
    logic[XLEN-1:0] ImmExt;
    Extractor Ext(i_inst, i_immsrc, ImmExt);
    /*ALU*/
    logic[XLEN-1:0] ALUresult0;
    logic[XLEN-1:0] ALUresult;
    logic[XLEN-1:0] SrcB1;
    mx2 mx_alu(SrcB0, ImmExt, i_alu_src_sel, SrcB1);
    ALU Alu(i_alu_cmd, SrcA, SrcB1, ALUresult0, o_zero_f);
    assign ALUresult = i_alu_inv?~ALUresult0:ALUresult0;
    /*data_mem*/
    logic[XLEN-1:0] result;
    assign o_data_addr = ALUresult;
    assign o_wr_data = SrcB0;
    mx5 mx_data(ALUresult, i_rd_data, pc_plus4, ImmExt, pc_tar, i_res_src_sel, result);
    always_ff @(posedge i_clk) begin
        if(i_inst == 32'h4020C1B3) begin
            $display("");
        end
    end
endmodule
