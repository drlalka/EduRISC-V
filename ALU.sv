`timescale 1ns / 1ps
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

module ALU(cmd, a, b, c, f/*, fov*/);
    parameter size = XLEN;
    input alu_cmd_t cmd;
    input reg[size-1:0] a;
    input reg[size-1:0] b;
    output reg[size-1:0] c;
    output logic f;
    //output logic fov;
    logic[size-1:0] bs;
    logic[size-1:0] as;
    logic[size-1:0] cs;
    always_comb begin 
        bs<=(cmd==ALU_SUB)||(cmd==ALU_SLT)?-b:b;
        as<=a;
    end
    always_comb begin
    case (cmd)
        ALU_ADD:
            c<=as+bs;
        ALU_SUB:
            c<=as+bs;
        ALU_XOR:
            c<=a ^ b;
        ALU_OR:
            c<= a | b;
        ALU_AND:
            c<= a & b;
        ALU_SLL:
            c<= a << b;
        ALU_SRL:
            c<= a >> b;
        ALU_SRA:
            c<= a >>> b;
        ALU_SLT: begin
            cs<=as+bs;
            c<=(cs[size-1] == 1'b1);
        end
        ALU_SLTU: begin
            c={1'b0,a}<{1'b0, b};
        end
    endcase
    end
    always_comb begin
    /*if(c[size-1:size-2]==2'b10 || c[size-1:size-2]==2'b01) begin
        fov<=1;
    end
    else begin
        fov<=0;
    end*/
    if(c == '0) begin
        f<=1;
    end 
    else begin
        f<=0;
    end
end
endmodule