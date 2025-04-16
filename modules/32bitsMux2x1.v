module 32bitsMUX2x1(

    input [31:0] A, B, // 5-bit inputs A and B
    input S,         // 1-bit selector
    output reg [31:0] Y // 5-bit output Y
);
    always @(*) begin
        case (S)
            1'b0: Y = A; // If S is 0, output A
            1'b1: Y = B; // If S is 1, output B
            default: Y = 32'b0; // Default case (unused ops)
        endcase
    end 
