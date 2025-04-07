// Description: Main PPU module
`include "modules/control_unit.v"
`include "modules/cu_mux.v"
`include "modules/programCounter.v"
`include "modules/adder4.v"
`include "modules/instruction_memory.v"
`include "modules/IF_ID.v"
`include "modules/ID_EX.v"
`include "modules/EX_MEM.v"
`include "modules/MEM_WB.v"

module PA_RISC(
    input clk,
    input reset,
    input LE,
    input S
);

// ------------------------
// Internal wires
// ------------------------
//IF/ID
wire [7:0] PCBackIn;
wire [7:0] PCBackOut;
wire [7:0] PCFrontOut;
wire [31:0] Instruction;
wire [31:0] InstructionOut; 
wire [7:0] IF_Branch = 8'b0; // Not used in this phase
wire [4:0] IF_RD = Instruction [4:0]; //Sale de un mux que no se hara en esta fase
//pero por ahora diremos que sale de ahi


// Control Unit outputs
wire IF_SH;
wire [1:0] IF_RD_F;
wire IF_BL;
wire [2:0] IF_SOH_OP;
wire [3:0] IF_ALU_OP;
wire [3:0] IF_RAM_CTRL;
wire IF_L;
wire [1:0] IF_ID_SR;
wire IF_RF_LE;
wire IF_PSW_EN;
wire IF_CO_EN;
wire [1:0] IF_COMB;

// MUX outputs (post-control unit)
wire CU_BL;
wire [2:0] CU_SOH_OP;
wire [3:0] CU_ALU_OP;
wire [3:0] CU_RAM_CTRL;
wire CU_L;
wire [1:0] CU_SR;
wire CU_RF_LE;
wire CU_PSW_EN;
wire CU_CO_EN;
wire [1:0] CU_COMB;

// ID/EX signals
wire ID_BL;
wire [2:0] ID_SOH_OP;
wire [3:0] ID_ALU_OP;
wire [3:0] ID_RAM_CTRL;
wire ID_L;
wire [1:0] ID_SR;
wire ID_RF_LE;
wire ID_PSW_EN;
wire ID_CO_EN;
wire [1:0] ID_COMB;
wire [31:0] Ain = 32'b0; // Not used in this phase
wire [31:0] Bin = 32'b0; // Not used in this phase
wire [4:0] ID_RD_Out = 5'b0; // Not used in this phase
wire [31:0] TAin = 7'b0; // Not used in this phase
wire [31:0] A_out;
wire [31:0] RB_out;
wire [31:0] TA_out;
wire [20:0] SOH_inst_out;
wire [2:0] Cond_out;
wire [31:0] ALUOut; // Not used in this phase

// EX/MEM wires
wire [31:0] MEM_RB_out;
wire [31:0] MEM_ALU_OUT_out;
wire [4:0] MEM_RD_out;
wire [3:0] MEM_RAM_CTRL_out;
wire MEM_L_out;
wire MEM_RF_LE_out;

// MEM/WB wires
wire [31:0] WB_PD_out;
wire [4:0] WB_RD_out;
wire WB_RF_LE_out;

// ------------------------
// Module Instantiations
// ------------------------

adder4 add4(
    .in(PCBackOut),
    .out(PCBackIn)
);

programCounter IAOQ_BACK(
    .clk(clk),
    .reset(reset),
    .LE(LE),
    .Q(PCBackOut),
    .D(PCBackIn)
);

programCounter IAOQ_FRONT(
    .clk(clk),
    .reset(reset),
    .LE(LE),
    .Q(PCFrontOut),
    .D(PCBackOut)
);

instruction_memory im(
    .A(PCFrontOut),
    .I(Instruction)
);

IF_ID IF_ID(
    .Inst_in(Instruction),
    .PC_Front(PCFrontOut),
    .LE(LE),
    .Reset(reset),
    .clk(clk),
    .Inst_out(InstructionOut),
    .PC_Front_out(IF_Branch)
);

control_unit CU(
    .instruction(InstructionOut),
    .SH(IF_SH),
    .RD_F(IF_RD_F),
    .BL(IF_BL),
    .SOH_OP(IF_SOH_OP),
    .ALU_OP(IF_ALU_OP),
    .RAM_CTRL(IF_RAM_CTRL),
    .L(IF_L),
    .ID_SR(IF_ID_SR),
    .RF_LE(IF_RF_LE),
    .PSW_EN(IF_PSW_EN),
    .CO_EN(IF_CO_EN),
    .COMB(IF_COMB)
);

control_unit_mux CUMux(
    .S(S),
    .BL_in(IF_BL),
    .SOH_OP_in(IF_SOH_OP),
    .ALU_OP_in(IF_ALU_OP),
    .RAM_CTRL_in(IF_RAM_CTRL),
    .L_in(IF_L),
    .ID_SR_in(IF_ID_SR),
    .RF_LE_in(IF_RF_LE),
    .PSW_EN_in(IF_PSW_EN),
    .CO_EN_in(IF_CO_EN),
    .COMB_in(IF_COMB),
    .BL_out(CU_BL),
    .SOH_OP_out(CU_SOH_OP),
    .ALU_OP_out(CU_ALU_OP),
    .RAM_CTRL_out(CU_RAM_CTRL),
    .L_out(CU_L),
    .ID_SR_out(CU_SR),
    .RF_LE_out(CU_RF_LE),
    .PSW_EN_out(CU_PSW_EN),
    .CO_EN_out(CU_CO_EN),
    .COMB_out(CU_COMB)
);

ID_EX ID_EX(
    .Reset(reset),
    .clk(clk),
    .TA_in(TAin),
    .A_in(Ain),
    .RB_in(Bin),
    .SOH_inst_in(Instruction[20:0]),
    .Cond_in(Instruction[15:13]),
    .RD_in(IF_RD),
    .ID_BL_in(CU_BL),
    .ID_SOH_OP_in(CU_SOH_OP),
    .ID_ALU_OP_in(CU_ALU_OP),
    .ID_RAM_CTRL_in(CU_RAM_CTRL),
    .ID_L_in(CU_L),
    .ID_SR_in(CU_SR),
    .ID_RF_LE_in(CU_RF_LE),
    .ID_PSW_EN_in(CU_PSW_EN),
    .ID_CO_EN_in(CU_CO_EN),
    .ID_COMB_in(CU_COMB),
    //
    .EX_BL_out(ID_BL),
    .EX_SOH_OP_out(ID_SOH_OP),
    .EX_ALU_OP_out(ID_ALU_OP),
    .EX_RAM_CTRL_out(ID_RAM_CTRL),
    .EX_L_out(ID_L),
    .EX_SR_out(ID_SR),
    .EX_RF_LE_out(ID_RF_LE),
    .EX_PSW_EN_out(ID_PSW_EN),
    .EX_CO_EN_out(ID_CO_EN),
    .EX_COMB_out(ID_COMB),
    .TA_out(TA_out),
    .A_out(A_out),
    .RB_out(RB_out),
    .SOH_inst_out(SOH_inst_out),
    .Cond_out(Cond_out),
    .RD_out(ID_RD_Out)
);

EX_MEM EX_MEM(
    .Reset(reset),
    .clk(clk),
    .EX_RB_in(RB_out),
    .EX_ALU_OUT_in(ALUOut),
    .EX_RD_in(ID_RD_Out),
    .EX_RAM_CTRL_in(ID_RAM_CTRL),
    .EX_L_in(ID_L),
    .EX_RF_LE_in(ID_RF_LE),
    .MEM_RB_out(MEM_RB_out),
    .MEM_ALU_OUT_out(MEM_ALU_OUT_out),
    .MEM_RD_out(MEM_RD_out),
    .MEM_RAM_CTRL_out(MEM_RAM_CTRL_out),
    .MEM_L_out(MEM_L_out),
    .MEM_RF_LE_out(MEM_RF_LE_out)
);

MEM_WB MEM_WB(
    .Reset(reset),
    .clk(clk),
    .MEM_PD_in(MEM_ALU_OUT_out), //Esto esta mal pero no es parte de la fase
    .MEM_RD_in(MEM_RD_out),
    .MEM_RF_LE_in(MEM_RF_LE_out),
    .WB_PD_out(WB_PD_out),
    .WB_RD_out(WB_RD_out),
    .WB_RF_LE_out(WB_RF_LE_out)
);

endmodule
