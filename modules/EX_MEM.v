//EX/MEM Register Module
//Author: Alex J. Strubbe Martinez

module EX_MEM(

    input Reset,
    input  clk,

    input [31:0] EX_RB_in,
    input [31:0] EX_ALU_OUT_in,
    input [4:0] EX_RD_in,
    
    input [3:0] EX_RAM_CTRL_in,
    input EX_L_in,
    input EX_RF_LE_in,

    output reg [31:0] MEM_RB_out,
    output reg [31:0] MEM_ALU_OUT_out,
    output reg [4:0] MEM_RD_out,
    
    output reg [3:0] MEM_RAM_CTRL_out,
    output reg MEM_L_out,
    output reg MEM_RF_LE_out
);   

    always @(posedge clk) begin
        if (Reset) begin
            MEM_RB_out       <= 32'b0;
            MEM_ALU_OUT_out  <= 32'b0;
            MEM_RD_out       <= 26'b0;
    
            MEM_RAM_CTRL_out <= 4'b0000;
            MEM_L_out        <= 1'b0;
            MEM_RF_LE_out    <= 1'b0;
        end
        else begin 
            MEM_RB_out       <= EX_RB_in;
            MEM_ALU_OUT_out  <= EX_ALU_OUT_in;
            MEM_RD_out       <= EX_RD_in;
    
            MEM_RAM_CTRL_out <= EX_RAM_CTRL_in;
            MEM_L_out        <= EX_L_in;
            MEM_RF_LE_out    <= EX_RF_LE_in;
        end
    end
endmodule
