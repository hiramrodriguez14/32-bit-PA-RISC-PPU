module ALU (
    input  [31:0] A, B,  // 32-bit inputs A and B
    input  [3:0] OP,     // 4-bit operation selector
    input  Ci,           // Carry-in input
    output reg [31:0] Out,  // 32-bit output
    output reg [3:0] Flags  // Flags: {Z, N, C, V}
);

    reg C, V;  // Internal Carry and Overflow flags

    always @(*) begin
        case (OP)
            4'b0000: {C, Out} = A + B;          // A + B
            4'b0001: {C, Out} = A + B + Ci;     // A + B + Carry-in
            4'b0010: {C, Out} = A - B;          // A - B
            4'b0011: {C, Out} = A - B - Ci;     // A - B - Carry-in
            4'b0100: {C, Out} = B - A;          // B - A
            4'b0101: Out = A | B;               // A OR B
            4'b0110: Out = A ^ B;               // A XOR B
            4'b0111: Out = A & B;               // A AND B
            4'b1000: Out = A;                   // Pass A
            4'b1001: Out = A + 8;               // A + 8
            4'b1010: Out = B;                   // Pass B
            default: Out = 32'b0;               // Default case (unused ops)
        endcase

        // Setting Flags
        Flags[3] = (Out == 32'b0) ? 1 : 0;  // Zero flag (Z)
        Flags[2] = Out[31];                 // Negative flag (N) (sign bit)
        Flags[1] = C;                        // Carry flag (C)
        Flags[0] = ((A[31] == B[31]) && (Out[31] > A[31])) ? 1 : 0;  // Overflow
    end

endmodule