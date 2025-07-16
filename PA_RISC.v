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
`include "modules/CH.v"
`include "modules/5bitsMux2x1.v"
`include "modules/5bitsMux4x1.v"
`include "modules/32bitsMux2x1.v"
`include "modules/32bitsMux4x1.v"
`include "modules/8bitsMux2x1.v"
`include "modules/mux1x2.v"
`include "modules/PSW.v"
`include "modules/DHDU.v"
`include "modules/register_file.v"
`include "modules/ALU.v"
`include "modules/data_memory.v"
`include "modules/SOH.v"
`include "modules/TAG.v"



module PA_RISC(
    input clk,
    input reset
);

// ------------------------
// Internal wires
// ------------------------

//IF wires
wire [31:0] PCBackIn;
wire [31:0] PCBackOut;
wire [31:0] PCFrontOut;
wire [31:0] PCFrontIn;
wire [31:0] Instruction;
wire [31:0] InstructionOut; 
wire [4:0] RD = Instruction [4:0];


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

// ID and MUX outputs (post-control unit)
wire [31:0] ID_IAOQ_FRONT;
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
wire [4:0] ID_RB_IN;
wire [4:0] ID_RD_OUT;
wire [31:0] ID_PA_OUT;
wire [31:0] ID_PB_OUT;
wire [31:0] ID_MUX_PA_OUT;
wire [31:0] ID_MUX_PB_OUT;
wire [31:0] TA_OUT;




// EX signals
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
wire [31:0] Ain; 
wire [4:0] EX_RD_out;
wire [31:0] A_out;
wire [31:0] RB_out;
wire [31:0] TA_out;
wire [20:0] SOH_inst_out;
wire [2:0] Cond_out;
wire [31:0] ALU_Out;
wire [3:0] EX_Flags;
wire EX_N_in;
wire EX_N_out;
wire PSW_N_out;
wire EX_J;
wire EX_Co;
wire EX_Ci;
wire [31:0] EX_SOH_N;


// MEM wires
wire [31:0] MEM_RB_out;
wire [31:0] MEM_ALU_OUT_out;
wire [4:0] MEM_RD_out;
wire [3:0] MEM_RAM_CTRL_out;
wire MEM_L_out;
wire MEM_RF_LE_out;
wire [31:0] MEM_DATA_OUT;
wire [31:0] MEM_PD_OUT;

// WB wires
wire [31:0] WB_PD_out;
wire [4:0] WB_RD_out;
wire WB_RF_LE_out;

//DHDU Wires
wire [1:0] BS_OUT;
wire [1:0] AS_OUT;
wire LE = 1'b1;
wire NOP;



// ------------------------
// Module Instantiations
// ------------------------

adder4 add4(
    .in(PCFrontIn),
    .out(PCBackIn)
);

IAOQ_BACK IAOQ_BACK(
    .clk(clk),
    .reset(reset),
    .LE(LE),
    .Q(PCBackOut),
    .D(PCBackIn)
);

MUX2x1_32bits IF_MUX(
    .A(PCBackOut),
    .B(TA_out),
    .S(EX_J),
    .Y(PCFrontIn)
);

IAOQ_FRONT IAOQ_FRONT(
    .clk(clk),
    .reset(reset),
    .LE(LE),
    .Q(PCFrontOut),
    .D(PCFrontIn)
);

instruction_memory im(
    .A(PCFrontOut[7:0]),
    .I(Instruction)
);

 //Chicken Jockey!!!
IF_ID IF_ID(
    .Inst_in(Instruction),
    .PC_Front(PCFrontOut),
    .LE(LE),
    .Reset(EX_J || reset),
    .clk(clk),
    .Inst_out(InstructionOut),
    .PC_Front_out(ID_IAOQ_FRONT)
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
    .S(NOP),
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

TAG TAG(
    .Instruction(InstructionOut[20:0]),
    .IAOQ_FRONT(ID_IAOQ_FRONT),
    .BL(ID_BL),
    .COMB(ID_COMB[1]),
    .TA(TA_OUT)
);

MUX2x1_5bits MUX(
    .A(InstructionOut[20:16]),
    .B(InstructionOut[25:21]),
    .S(SH),
    .Y(ID_RB_IN)
);

MUX4x1_5bits MUXRD(
    .A(InstructionOut[20:16]),
    .B(InstructionOut[25:21]),
    .C(InstructionOut[4:0]),
    .S(RD_F),
    .Y(ID_RD_OUT)
);

register_file RF(
    .PD(WB_PD_out),
    .RA(InstructionOut[25:21]),
    .RB(ID_RB_IN),
    .RD(WB_RD_out),
    .EN(WB_RF_LE_out),
    .CLK(clk),
    .PA(ID_PA_OUT),
    .PB(ID_PB_OUT)
);

MUX4x1_32bits MUXPA(
    .A(ID_PA_OUT),
    .B(ALU_Out),
    .C(MEM_PD_OUT),
    .D(WB_PD_out),
    .S(AS_OUT),
    .Y(ID_MUX_PA_OUT)
);

MUX4x1_32bits MUXPB(
    .A(ID_PB_OUT),
    .B(ALU_Out),
    .C(MEM_PD_OUT),
    .D(WB_PD_out),
    .S(BS_OUT),
    .Y(ID_MUX_PB_OUT)
);

MUX2x1_32bits MUXBL(
    .A(ID_MUX_PA_OUT),
    .B(ID_IAOQ_FRONT),
    .S(BL),
    .Y(Ain)
);

ID_EX ID_EX(
    .Reset(reset),
    .clk(clk),
    .TA_in(TA_OUT),
    .A_in(Ain),
    .RB_in(ID_MUX_PB_OUT),
    .SOH_inst_in(InstructionOut[20:0]),
    .Cond_in(InstructionOut[15:13]),
    //Signals from mux
    .RD_in(ID_RD_OUT),
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
    .RD_out(EX_RD_out)
);

ALU ALU(
    .A(A_out),
    .B(EX_SOH_N),
    .OP(EX_ALU_OP),
    .Ci(EX_Ci),
    .Out(ALU_Out),
    .Flags(EX_Flags)
);

operand_handler SOH(
    .RB(RB_out),
    .I(SOH_inst_out),
    .S(EX_SOH_OP),
    .N(EX_SOH_N)
);

MUX2x1_1bits mux1x2(
    .A(1'b0),
    .B(EX_Co),
    .S(EX_CO_EN),
    .Y(EX_Ci)
);

PSW PSW(
    .clk(clk),
    .Reset(reset),
    .PSW_EN(EX_PSW_EN),
    .C_B(EX_Flags[1]),
    .Co(EX_Co)
);

CH CH(
    .BL(EX_BL),
    .COMB(EX_COMB[1]),
    .COMB_TF(EX_COMB[0]),
    .C(Cond_out),
    .ACC(EX_Flags), 
    .J(EX_J)
);

DHDU DHDU(
    .EX_RF_LE(EX_RF_LE),
    .MEM_RF_LE(MEM_RF_LE_out),
    .WB_RF_LE(WB_RF_LE_out),
    .EX_RD(EX_RD_out),
    .MEM_RD(MEM_RD_out),
    .WB_RD(WB_RD_out),
    .RA(InstructionOut[25:21]),
    .RB(ID_RB_IN),
    .SR(SR),
    .EX_L(EX_L),
    .LE(LE),
    .NOP(NOP),
    .B_S(BS_OUT),
    .A_S(AS_OUT)
);

EX_MEM EX_MEM(
    .Reset(reset),
    .clk(clk),
    .EX_RB_in(RB_out),
    .EX_ALU_OUT_in(ALU_Out),
    .EX_RD_in(EX_RD_out),
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

DataMemory datamemory(
    .clk(clk),
    .A(MEM_ALU_OUT_out[7:0]),
    .DI(MEM_RB_out),
    .DO(MEM_DATA_OUT),
    .Size(MEM_RAM_CTRL_out[3:2]),
    .RW(MEM_RAM_CTRL_out[1]),
    .E(MEM_RAM_CTRL_out[0])
);

MUX2x1_32bits MUXMEM(
    .A(MEM_ALU_OUT_out),
    .B(MEM_DATA_OUT),
    .S(MEM_L_out),
    .Y(MEM_PD_OUT)
);

MEM_WB MEM_WB(
    .Reset(reset),
    .clk(clk),
    .MEM_PD_in(MEM_PD_OUT),
    .MEM_RD_in(MEM_RD_out),
    .MEM_RF_LE_in(MEM_RF_LE_out),
    .WB_PD_out(WB_PD_out),
    .WB_RD_out(WB_RD_out),
    .WB_RF_LE_out(WB_RF_LE_out)
);

endmodule
