`timescale 1s / 1s
`include "PA_RISC.v"

module PA_RISC_tb;

    reg clk;
    reg reset;

    PA_RISC uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock toggles every 2ns → full period = 4ns
    initial begin
        clk = 0;
        forever #2 clk = ~clk;
    end

    initial begin
        reset = 1;
        #3 reset = 0;
        #60 $finish; // Aumenté tiempo para permitir ejecución larga si es necesario
    end

    reg [127:0] keyword;

    // Display block every 1ns
    always #1 begin
        case (uut.InstructionOut[31:26])
            6'b000010: begin
                case (uut.InstructionOut[11:6])
                    6'b011000: keyword = "ADD";
                    6'b011100: keyword = "ADDC";
                    6'b101000: keyword = "ADDL";
                    6'b010000: keyword = "SUB";
                    6'b010100: keyword = "SUBB";
                    6'b001001: keyword = "OR";
                    6'b001010: keyword = "XOR";
                    6'b001000: keyword = "AND";
                    default: keyword = "UNK_ARITH";
                endcase
            end
            6'b010010: keyword = "LDW";
            6'b000000: keyword = "NOP";
            6'b010001: keyword = "LDH";
            6'b010000: keyword = "LDB";
            6'b011010: keyword = "STW";
            6'b011001: keyword = "STH";
            6'b011000: keyword = "STB";
            6'b001101: keyword = "LDO";
            6'b001000: keyword = "LDI";
            6'b111010: keyword = "BL";
            6'b100000: keyword = "COMBT";
            6'b100010: keyword = "COMBF";
            6'b101101: keyword = "ADDI";
            6'b100101: keyword = "SUBI";
            6'b110100: begin
                case (uut.InstructionOut[12:10])
                    3'b110: keyword = "EXTRU";
                    3'b111: keyword = "EXTRS";
                    default: keyword = "UNK_SHR";
                endcase
            end
            6'b110101: begin
                case (uut.InstructionOut[12:10])
                    3'b010: keyword = "ZDEP";
                    default: keyword = "UNK_SHL";
                endcase
            end
            default: keyword = "xxx";
        endcase

        $display("\nTime=%0t | Inst=%s | PCFront=%d | CLK=%b", $time, keyword, uut.ID_IAOQ_FRONT, clk);
        $display("CU  : SH=%b RD_F=%b BL=%b SOH_OP=%b ALU_OP=%b RAM_CTRL=%b L=%b ID_SR=%b RF_LE=%b PSW_EN=%b CO_EN=%b COMB=%b",
            uut.SH, uut.RD_F, uut.BL, uut.SOH_OP, uut.ALU_OP, uut.RAM_CTRL, uut.L,
            uut.SR, uut.RF_LE, uut.PSW_EN, uut.CO_EN, uut.COMB);
        $display("EX : BL=%b SOH_OP=%b ALU_OP=%b RAM_CTRL=%b L=%b SR=%b RF_LE=%b PSW_EN=%b CO_EN=%b COMB=%b",
            uut.EX_BL, uut.EX_SOH_OP, uut.EX_ALU_OP, uut.EX_RAM_CTRL, uut.EX_L, uut.EX_SR,
            uut.EX_RF_LE, uut.EX_PSW_EN, uut.EX_CO_EN, uut.EX_COMB);

        $display("MEM: RAM_CTRL=%b L=%b RF_LE=%b",
            uut.MEM_RAM_CTRL_out, uut.MEM_L_out, uut.MEM_RF_LE_out);

        $display("WB: RF_LE=%b\n", uut.WB_RF_LE_out);

        
        $display("VALIDATION LINE: \nTime=%0t | PCFront=%0d | GR1=%0d | GR2=%0d | GR3=%0d | GR5=%0d | GR6=%0d | PD=%0d | RD=%0d | ALU_OUT=%0d |SOH_in=%0d| SOH_out=%0d | Intruction_IN=%0b | Instruction_OUT=%0b | TA_OUT=%0d | Flags=%0b, | J=%d0 | TA_IN = %0d | COND=%0b ",
            $time,
            uut.ID_IAOQ_FRONT,
            uut.RF.reg_file[1],
            uut.RF.reg_file[2],
            uut.RF.reg_file[3],
            uut.RF.reg_file[5],
            uut.RF.reg_file[6],
            uut.WB_PD_out,
            uut.WB_RD_out,
            uut.ALU_Out,
            uut.SOH_inst_out,
            uut.EX_SOH_N,
            uut.Instruction,
            uut.InstructionOut,
            uut.TA_OUT,
            uut.EX_Flags,
            uut.EX_J,
            uut.TA_out,
            uut.Cond_out
            );
    end

    initial begin
        $dumpfile("PA_RISC_tb.vcd");
        $dumpvars(0, PA_RISC_tb);
    end

endmodule
