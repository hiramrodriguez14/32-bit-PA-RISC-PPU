

module TAG(
    input [20:0] Instruction,
    input [7:0] IAOQ_FRONT,
    input BL,
    input COMB,
    output reg [7:0] TA
);

always @(*) begin
    if (BL) begin
        // Branch and Link: w2 = Instruction[12:2], w1 = Instruction[20:16], w = Instruction[0]
        // IAOQBACK <- IAOQFRONT + 8 + 4*signext(w1, w2, w)
        // Sign-extend w2 (11 bits) and w1 (5 bits) to 16 bits
        TA = IAOQ_FRONT + 8'b00001000 + 4*({{11{Instruction[0]}}, Instruction[20:16], Instruction[12:2], Instruction[0]});
    end
    else if (COMB) begin
        // Compare and Branch: w1 = Instruction[12:2], w = Instruction[0], no w2
        // IAOQBACK <- IAOQFRONT + 8 + 4*signext(w1, w)
        // Sign-extend w1 (11 bits) and w (1 bit) to 16 bits
        TA = IAOQ_FRONT + 8'b00001000 + 4*({{18{Instruction[0]}}, Instruction[12:2], Instruction[0]});
    end
end

endmodule
