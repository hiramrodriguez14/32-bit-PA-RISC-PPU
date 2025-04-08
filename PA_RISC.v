// Description: Main PPU module

`include "modules/control_unit.v"
`include "modules/cu_mux.v"
`include "modules/IAOQ_FRONT.v"
`include "modules/IAOQ_BACK.v"
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
wire [7:0] Branch = 8'b0; // Not used in this phase
wire [4:0] RD = Instruction [4:0]; //Sale de un mux que no se hara en esta fase
//pero por ahora diremos que sale de ahi


// Control Unit outputs
wire SH;
wire [1:0] RD_F;
wire BL;
wire [2:0] SOH_OP;
wire [3:0] ALU_OP;
wire [3:0] RAM_CTRL;
wire L;
wire [1:0] SR;
wire RF_LE;
wire PSW_EN;
wire CO_EN;
wire [1:0] COMB;

// MUX outputs (post-control unit)
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

// ID/EX signals
wire EX_BL;
wire [2:0] EX_SOH_OP;
wire [3:0] EX_ALU_OP;
wire [3:0] EX_RAM_CTRL;
wire EX_L;
wire [1:0] EX_SR;
wire EX_RF_LE;
wire EX_PSW_EN;
wire EX_CO_EN;
wire [1:0] EX_COMB;
wire [31:0] Ain = 32'b0; // Not used in this phase
wire [31:0] Bin = 32'b0; // Not used in this phase
wire [4:0] EX_RD_Out = 5'b0; // Not used in this phase
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

IAOQ_BACK IAOQ_BACK(
    .clk(clk),
    .reset(reset),
    .LE(LE),
    .Q(PCBackOut),
    .D(PCBackIn)
);

IAOQ_FRONT IAOQ_FRONT(
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
    .PC_Front_out(Branch)
);

control_unit CU(
    .instruction(InstructionOut),
    .SH(SH),
    .RD_F(RD_F),
    .BL(BL),
    .SOH_OP(SOH_OP),
    .ALU_OP(ALU_OP),
    .RAM_CTRL(RAM_CTRL),
    .L(L),
    .ID_SR(SR),
    .RF_LE(RF_LE),
    .PSW_EN(PSW_EN),
    .CO_EN(CO_EN),
    .COMB(COMB)
);

control_unit_mux CUMux(
    .S(S),
    .BL_in(BL),
    .SOH_OP_in(SOH_OP),
    .ALU_OP_in(ALU_OP),
    .RAM_CTRL_in(RAM_CTRL),
    .L_in(L),
    .ID_SR_in(SR),
    .RF_LE_in(RF_LE),
    .PSW_EN_in(PSW_EN),
    .CO_EN_in(CO_EN),
    .COMB_in(COMB),
    //OUTPUTS
    .BL_out(ID_BL),
    .SOH_OP_out(ID_SOH_OP),
    .ALU_OP_out(ID_ALU_OP),
    .RAM_CTRL_out(ID_RAM_CTRL),
    .L_out(ID_L),
    .ID_SR_out(ID_SR),
    .RF_LE_out(ID_RF_LE),
    .PSW_EN_out(ID_PSW_EN),
    .CO_EN_out(ID_CO_EN),
    .COMB_out(ID_COMB)
);

ID_EX ID_EX(
    .Reset(reset),
    .clk(clk),
    .TA_in(TAin),
    .A_in(Ain),
    .RB_in(Bin),
    .SOH_inst_in(Instruction[20:0]),
    .Cond_in(Instruction[15:13]),
    //Signals from mux
    .RD_in(RD),
    .ID_BL_in(ID_BL),
    .ID_SOH_OP_in(ID_SOH_OP),
    .ID_ALU_OP_in(ID_ALU_OP),
    .ID_RAM_CTRL_in(ID_RAM_CTRL),
    .ID_L_in(ID_L),
    .ID_SR_in(ID_SR),
    .ID_RF_LE_in(ID_RF_LE),
    .ID_PSW_EN_in(ID_PSW_EN),
    .ID_CO_EN_in(ID_CO_EN),
    .ID_COMB_in(ID_COMB),
    //
    .EX_BL_out(EX_BL),
    .EX_SOH_OP_out(EX_SOH_OP),
    .EX_ALU_OP_out(EX_ALU_OP),
    .EX_RAM_CTRL_out(EX_RAM_CTRL),
    .EX_L_out(EX_L),
    .EX_SR_out(EX_SR),
    .EX_RF_LE_out(EX_RF_LE),
    .EX_PSW_EN_out(EX_PSW_EN),
    .EX_CO_EN_out(EX_CO_EN),
    .EX_COMB_out(EX_COMB),
    .TA_out(TA_out),
    .A_out(A_out),
    .RB_out(RB_out),
    .SOH_inst_out(SOH_inst_out),
    .Cond_out(Cond_out),
    .RD_out(EX_RD_Out)
);

EX_MEM EX_MEM(
    .Reset(reset),
    .clk(clk),
    .EX_RB_in(RB_out),
    .EX_ALU_OUT_in(ALUOut),
    .EX_RD_in(EX_RD_Out),
    .EX_RAM_CTRL_in(EX_RAM_CTRL),
    .EX_L_in(EX_L),
    .EX_RF_LE_in(EX_RF_LE),
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
    .WB_RF_LE_out(WB_RF_LE_out) //Esta
);

endmodule
