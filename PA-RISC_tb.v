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
        #202 $finish; 
    end

      integer i;
initial begin
    #200;
    for (i = 0; i <= 175; i = i + 4) begin
        $write("Mem[%0d-%0d] = ", i, i+3);
        $write("%b %b %b %b\n", 
            uut.datamemory.Mem[i],
            uut.datamemory.Mem[i+1],
            uut.datamemory.Mem[i+2],
            uut.datamemory.Mem[i+3]
        );
    end
end

    reg [127:0] keyword;

    // Display block every 1ns
    always #2 begin
        case (uut.Instruction[31:26])
            6'b000010: begin
                case (uut.Instruction[11:6])
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
                case (uut.Instruction[12:10])
                    3'b110: keyword = "EXTRU";
                    3'b111: keyword = "EXTRS";
                    default: keyword = "UNK_SHR";
                endcase
            end
            6'b110101: begin
                case (uut.Instruction[12:10])
                    3'b010: keyword = "ZDEP";
                    default: keyword = "UNK_SHL";
                endcase
            end
            default: keyword = "xxx";
        endcase

        $display("\nTime=%0t | Inst=%s | PCFront=%d | CLK=%b", $time, keyword, uut.PCFrontOut, clk);
        $display("CU  : SH=%b RD_F=%b BL=%b SOH_OP=%b ALU_OP=%b RAM_CTRL=%b L=%b ID_SR=%b RF_LE=%b PSW_EN=%b CO_EN=%b COMB=%b",
            uut.SH, uut.RD_F, uut.BL, uut.SOH_OP, uut.ALU_OP, uut.RAM_CTRL, uut.L,
            uut.SR, uut.RF_LE, uut.PSW_EN, uut.CO_EN, uut.COMB);
        $display("EX : BL=%b SOH_OP=%b ALU_OP=%b RAM_CTRL=%b L=%b SR=%b RF_LE=%b PSW_EN=%b CO_EN=%b COMB=%b",
            uut.EX_BL, uut.EX_SOH_OP, uut.EX_ALU_OP, uut.EX_RAM_CTRL, uut.EX_L, uut.EX_SR,
            uut.EX_RF_LE, uut.EX_PSW_EN, uut.EX_CO_EN, uut.EX_COMB);

        $display("MEM in : RAM_CTRL=%b L=%b RF_LE=%b",
            uut.MEM_RAM_CTRL_out, uut.MEM_L_out, uut.MEM_RF_LE_out);

        $display("WB in : RF_LE=%b\n", uut.WB_RF_LE_out);

          $monitor(
    "VALITADION LINE: Time=%0t | PCFront=%d | GR1=%d | GR2=%d | GR3=%d | GR4=%d | GR5=%b | GR10=%d | GR11=%d | GR12=%d | GR14=%d|",
    $time,
    uut.PCFrontOut,
    uut.RF.reg_file[1],
    uut.RF.reg_file[2],
    uut.RF.reg_file[3],
    uut.RF.reg_file[4],
    uut.RF.reg_file[5],
    uut.RF.reg_file[10],
    uut.RF.reg_file[11],
    uut.RF.reg_file[12],
    uut.RF.reg_file[14]
);
    end

    initial begin
        $dumpfile("PA_RISC_tb.vcd");
        $dumpvars(0, PA_RISC_tb);
    end

endmodule
