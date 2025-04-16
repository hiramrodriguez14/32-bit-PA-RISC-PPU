module DHDU(
    input EX_RF_LE,
    input MEM_RF_LE,
    input WB_RF_LE,
    input [4:0] EX_RD,
    input [4:0] MEM_RD,
    input [4:0] WB_RD,
    input [4:0] RA,
    input [4:0] RB,
    input [1:0] SR,  // SR[1] = SR_A & SR[0] = SR_B
    input EX_L,
    output reg LE,
    output reg NOP,
    output reg [1:0] B_S,
    output reg [1:0] A_S
);

always @(*) begin
 
    if (EX_L == 1'b1 && ((SR[1] == 1'b1 && RA == EX_RD) || (SR[0] == 1'b1 && RB == EX_RD))) begin
        LE = 1'b0;
        NOP = 1'b1;
    end else begin
        NOP = 1'b0;
        LE = 1'b1;

        
        if (SR[1] == 1'b1) begin
            if (EX_RF_LE == 1'b1 && EX_RD == RA) begin
                A_S = 2'b01;
            end else if (MEM_RF_LE == 1'b1 && MEM_RD == RA) begin
                A_S = 2'b10;
            end else if (WB_RF_LE == 1'b1 && WB_RD == RA) begin
                A_S = 2'b11;
            end else begin
                A_S = 2'b00;
            end
        end

       
        if (SR[0] == 1'b1) begin
            if (EX_RF_LE == 1'b1 && EX_RD == RB) begin
                B_S = 2'b01;
            end else if (MEM_RF_LE == 1'b1 && MEM_RD == RB) begin
                B_S = 2'b10;
            end else if (WB_RF_LE == 1'b1 && WB_RD == RB) begin
                B_S = 2'b11;
            end else begin
                B_S = 2'b00;
            end
        end
    end
end

endmodule
