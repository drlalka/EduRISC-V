import riscv_pkg::*;
module simul_Extr();
    logic [XLEN-1:0] Instr;
    immscr_e ImmScr;
    logic [XLEN-1:0] ImmExt;
    logic [31:0]answ = 32'b11111111111111111111010010100100;
    Extractor DUT (Instr, ImmScr, ImmExt);
    initial begin
        $display("test begin");
        #10
        /*ImmScrs={IMM_I, IMM_S, IMM_B, IMM_U, IMM_J};
        Instrs={8'hFFA9A383, 8'h01429BA3, 8'h01E40863, 8'h8CDEFAB7, 8'h7F8A60EF};
        answs={8'b11111010, 8'b00010111, 8'b11110001, 32'b10001100110111101111000000000000, 8'hA67F8};*/
        Instr<=32'hFFA9A383;
        ImmScr<=IMM_I;
        #25
        assert((32'b11111111111111111111111111111010)==ImmExt)
        else $error("Error in I");
        Instr<=32'h01429BA3;
        ImmScr<=IMM_S;
        #25
        assert((32'b00000000000000000000000000010111)==ImmExt)
        else $error("Error in S");
        Instr<=32'hCB9C1263;
        ImmScr<=IMM_B;
        answ <=32'b11111111111111111111010010100100;
        #25
        assert((32'b11111111111111111111010010100100)==ImmExt)
        else $error("Error in B");
        $display("Test end");
        Instr<=32'h8CDEFAB7;
        ImmScr<=IMM_U;
        answ <=32'b10001100110111101111000000000000;
        #25
        assert((32'b10001100110111101111000000000000)==ImmExt)
        else $error("Error in U");
        Instr<=32'h7F8A60EF;
        ImmScr<=IMM_J;
        answ <=32'hA67F8;
        #25
        assert(32'hA67F8==ImmExt)
        else $error("Error in J");
        $display("Test end");
        $stop;
    end
endmodule
