module MUX4x1_5bits(
    input [4:0] A, B, C, // 32-bit inputs A, B, C, and D
    input [1:0] S,         // 2-bit selector
    output reg [4:0] Y // 32-bit output Y
);
    always @(*) begin
        case (S)
            2'b00: Y = A; // If S is 00, output A
            2'b01: Y = B; // If S is 01, output B
            2'b10: Y = C; // If S is 10, output C
            2'b11: Y = 5'b0; // If S is 11, output 0
            default: Y = 5'b0; // Default case (unused ops)
        endcase
    end
endmodule
