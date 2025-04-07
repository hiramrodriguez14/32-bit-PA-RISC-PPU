//MEM_WB Register Module
//Author: Alex J. Strubbe Martinez

module MEM_WB(
    input Reset,
    input clk,
   
    
    input [31:0] MEM_PD_in,
    input [4:0] MEM_RD_in,
    input MEM_RF_LE_in,

    output reg [31:0] WB_PD_out,
    output reg [4:0] WB_RD_out,
    output reg WB_RF_LE_out
);

    always @(posedge clk) begin
        if (Reset) begin
            WB_PD_out   <= 32'b0;
            WB_RD_out   <= 26'b0;
            WB_RF_LE_out<= 1'b0;
        end
        else begin
            WB_PD_out   <= MEM_PD_in;
            WB_RD_out   <= MEM_RD_in;
            WB_RF_LE_out<= MEM_RF_LE_in;
        end
    end
endmodule
