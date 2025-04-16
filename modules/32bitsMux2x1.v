module MUX2x1_32bits(
    input [31:0] A, 
    input [7:0]  B,    // 8-bit input B
    input S,           // 1-bit selector
    output reg [31:0] Y // 32-bit output Y
);
    always @(*) begin
        case (S)
            1'b0: Y = A;        // If S is 0, output A
            1'b1: Y = {24'b0, B}; // Zero-extend B to 32 bits and output
            default: Y = 32'b0; // Default case (unused ops)
        endcase
    end

endmodule
