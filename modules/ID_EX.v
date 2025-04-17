//ID/EX Register Module
//Author: Alex J. Strubbe Martinez
module ID_EX(    
    input  Reset,
    input  clk,
    input  [31:0] TA_in ,
    input  [31:0] A_in,
    input  [31:0] RB_in,
    input  [20:0] SOH_inst_in,
    input  [2:0] Cond_in,
    input  [4:0] RD_in,

    //CU in signals (from ID stage)
    input ID_BL_in,
    input [2:0] ID_SOH_OP_in,
    input [3:0] ID_ALU_OP_in,
    input [3:0] ID_RAM_CTRL_in,
    input ID_L_in,
    input [1:0] ID_SR_in,
    input ID_RF_LE_in,
    input ID_PSW_EN_in,
    input ID_CO_EN_in,
    input [1:0] ID_COMB_in,
   

    // CU out signals (to EX stage)
    output reg EX_BL_out,
    output reg [2:0] EX_SOH_OP_out,
    output reg [3:0] EX_ALU_OP_out,
    output reg [3:0] EX_RAM_CTRL_out,
    output reg EX_L_out,
    output reg [1:0] EX_SR_out,
    output reg EX_RF_LE_out,
    output reg EX_PSW_EN_out,
    output reg EX_CO_EN_out,
    output reg [1:0] EX_COMB_out,

    output reg [31:0] TA_out ,
    output reg [31:0] A_out,
    output reg [31:0] RB_out,
    output reg [20:0] SOH_inst_out,
    output reg [2:0] Cond_out,
    output reg [4:0] RD_out
   
    );

    always @(posedge clk) begin
        if(Reset) begin
            EX_BL_out       <= 1'b0;
            EX_SOH_OP_out   <= 3'b000;
            EX_ALU_OP_out   <= 4'b0000;
            EX_RAM_CTRL_out <= 4'b0000;
            EX_L_out        <= 1'b0;
            EX_SR_out       <= 2'b00;
            EX_RF_LE_out    <= 1'b0;
            EX_PSW_EN_out   <= 1'b0;
            EX_CO_EN_out    <= 1'b0;
            EX_COMB_out     <= 2'b00;
            TA_out          <= 32'b0;
            A_out           <= 32'b0;
            RB_out          <= 32'b0;
            SOH_inst_out    <= 21'b0;
            Cond_out        <= 3'b000;
            RD_out          <= 26'b0;
        end
        else begin
            EX_BL_out       <= ID_BL_in;
            EX_SOH_OP_out   <= ID_SOH_OP_in;
            EX_ALU_OP_out   <= ID_ALU_OP_in;
            EX_RAM_CTRL_out <= ID_RAM_CTRL_in;
            EX_L_out        <= ID_L_in;
            EX_SR_out       <= ID_SR_in;
            EX_RF_LE_out    <= ID_RF_LE_in;
            EX_PSW_EN_out   <= ID_PSW_EN_in;
            EX_CO_EN_out    <= ID_CO_EN_in;
            EX_COMB_out     <= ID_COMB_in;
            TA_out          <= TA_in;
            A_out           <= A_in;
            RB_out          <= RB_in;
            SOH_inst_out    <= SOH_inst_in;
            Cond_out        <= Cond_in;
            RD_out          <= RD_in;
        end
    end
endmodule
