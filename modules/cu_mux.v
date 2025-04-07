//Control Unit MUX Module
//Author: Hiram R. Rodriguez Hernandez
module control_unit_mux(
    input S, // Flush signal

    // Inputs from Control Unit 
    input BL_in,
    input [2:0] SOH_OP_in,
    input [3:0] ALU_OP_in,
    input [3:0] RAM_CTRL_in,
    input L_in,
    input [1:0] ID_SR_in,
    input RF_LE_in,
    input PSW_EN_in,
    input CO_EN_in,
    input [1:0] COMB_in,
    
    // Outputs to pipeline
    output reg BL_out,
    output reg [2:0] SOH_OP_out,
    output reg [3:0] ALU_OP_out,
    output reg [3:0] RAM_CTRL_out,
    output reg L_out,
    output reg [1:0] ID_SR_out,
    output reg RF_LE_out,
    output reg PSW_EN_out,
    output reg CO_EN_out,
    output reg [1:0] COMB_out
);

    always @(*) begin
        if (S) begin // Cancel ID stage
            BL_out       = 1'b0;
            SOH_OP_out   = 3'b000;
            ALU_OP_out   = 4'b0000;
            RAM_CTRL_out = 4'b0000;
            L_out        = 1'b0;
            ID_SR_out    = 2'b00;
            RF_LE_out    = 1'b0;
            PSW_EN_out   = 1'b0;
            CO_EN_out    = 1'b0;
            COMB_out     = 2'b00;
        end
        else begin // Normal control
            BL_out       = BL_in;
            SOH_OP_out   = SOH_OP_in;
            ALU_OP_out   = ALU_OP_in;
            RAM_CTRL_out = RAM_CTRL_in;
            L_out        = L_in;
            ID_SR_out    = ID_SR_in;
            RF_LE_out    = RF_LE_in;
            PSW_EN_out   = PSW_EN_in;
            CO_EN_out    = CO_EN_in;
            COMB_out     = COMB_in;
        end
    end

endmodule
