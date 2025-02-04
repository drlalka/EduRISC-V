`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.12.2024 15:53:56
// Design Name: 
// Module Name: regmem
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


module regmem #(
    parameter DWIDTH=XLEN,
    localparam AWIDTH = REG_AWIDTH
)(
    input clk,
    input[DWIDTH-1:0] Din,
    input[AWIDTH-1:0] RAddr_a,
    input[AWIDTH-1:0] RAddr_b,
    input[AWIDTH-1:0] WAddr,
    input Wr,
    output reg [DWIDTH-1:0] Dout_a,
    output reg [DWIDTH-1:0] Dout_b );
    reg [REG_CNT-1:1][DWIDTH-1:0] mem;
    /*initial begin
        for(int i=0; i<REG_CNT;i++) begin
            mem[i]<='0;
        end
    end*/
    always_comb begin
        if(RAddr_a == 0) begin
            Dout_a <= '0;
        end
        else begin
            Dout_a <= mem[RAddr_a];
        end
        if(RAddr_b == 0) begin
            Dout_b <= '0;
        end
        else begin
            Dout_b <= mem[RAddr_b];
        end
    end
    always_ff @(posedge clk) begin
        if(Wr && WAddr!='0) begin
            mem[WAddr] <= Din;
        end
    end
endmodule