//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 17:09:49
// Design Name: 
// Module Name: ALU
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
module riscv_sng_top
    ( input i_clk, i_rst,
      output logic [7:0] led,
      input logic [7:0] switch );
    logic [XLEN-1 : 0] inst_addr;
    logic [XLEN-1 : 0] inst;
    logic [XLEN-1 : 0] data_addr;
    logic [XLEN-1 : 0] wr_data;
    logic [XLEN-1 : 0] rd_data;
    logic zero_f;
    logic pc_src;
    logic tar_src;
    logic rg_wr;
    logic alu_inv;
    immsrc_e immsrc;
    logic alu_src_sel;
    alu_cmd_t alu_cmd;
    logic [2:0] res_src_sel;
    instr_mem instr_mem_inst (
        .a (inst_addr[XLEN-1 : 2]),
        .spo (inst)
        );
    data_mem data_mem_inst (
        .a (data_addr[XLEN-1 : 2]),
        .d (wr_data),
        .clk (i_clk),
        .we (mem_wr & (~data_addr[XLEN-1])),
        .spo (rd_data)
        );
    riscv_sng_dp dp_inst
    (
        .i_clk (i_clk ),
        .i_rst (i_rst ),
        .o_inst_addr (inst_addr ),
        .i_inst (inst ),
        .o_data_addr (data_addr ),
        .o_wr_data (wr_data ),
        .i_rd_data (dp_rd_data ),
        .o_zero_f (zero_f ),
        .i_pc_src (pc_src ),
        .i_tar_src (tar_src),
        .i_rg_wr (rg_wr ),
        .i_immsrc (immsrc ),
        .i_alu_src_sel (alu_src_sel),
        .i_alu_inv (alu_inv),
        .i_alu_cmd (alu_cmd ),
        .i_res_src_sel (res_src_sel)
    );
    riscv_sng_cp cp_inst
    (
        .i_inst (inst),
        .i_zero_f (zero_f ),
        .o_pc_src (pc_src ),
        .o_tar_src (tar_src),
        .o_rg_wr (rg_wr ),
        .o_immsrc (immsrc ),
        .o_mem_wr (mem_wr ),
        .o_alu_src_sel (alu_src_sel),
        .o_alu_cmd (alu_cmd ),
        .o_res_src_sel (res_src_sel),
        .o_alu_inv (alu_inv)
    );
    ila_0 ila_inst (
        .clk(i_clk), // input wire clk
        .probe0(inst_addr), // input wire [31:0] probe0 
        .probe1(inst), // input wire [31:0] probe1 
        .probe2(data_addr), // input wire [31:0] probe2 
        .probe3(wr_data), // input wire [31:0] probe3 
        .probe4(rd_data), // input wire [31:0] probe4 
        .probe5(mem_wr), // input wire [0:0] probe5 
        .probe6(i_rst) // input wire [0:0] probe6
    );

    logic [XLEN-1 : 0] dp_rd_data;
    always_comb begin : io_alw
    dp_rd_data <= data_addr[XLEN-1] ? {0, switch} : rd_data;
    end : io_alw
    always_ff @(posedge i_clk) begin : led_alw
    if (data_addr[XLEN-1] == 1'b1 && mem_wr == 1'b1)
    led <= wr_data;
    end : led_alw
    
    
endmodule