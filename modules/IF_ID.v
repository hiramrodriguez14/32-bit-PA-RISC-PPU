//ID/IF Register Module
//Author: Alex J. Strubbe Martinez

module IF_ID(
    input  [31:0] Inst_in ,
    input  [31:0] PC_Front,
    input  LE,
    input  Reset,
    input  clk,

    output reg [31:0] Inst_out,
    output reg [31:0] PC_Front_out
);

    always @(posedge clk) begin
        if(Reset) begin
            Inst_out <= 32'b0;
            PC_Front_out <= 32'b0;
        end
        else if(LE) begin
            Inst_out <= Inst_in;
            PC_Front_out <= PC_Front;
        end
    end
endmodule
