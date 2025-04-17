module TAG(
    input [20:0] Instruction,
    input [31:0] IAOQ_FRONT,
    input BL,
    input COMB,
    output reg [31:0] TA
);

    wire signed [31:0] offset_bl;
    wire signed [31:0] offset_comb;

    // Branch and Link offset: 16-bit sign-extended immediate from w2|w1|w
    assign offset_bl = {{16{Instruction[20]}}, Instruction[20:16], Instruction[12:2], Instruction[0]};

    // Compare and Branch offset: 14-bit sign-extended immediate from w1|w
    assign offset_comb = {{18{Instruction[12]}}, Instruction[12:2], Instruction[0]};

    always @(*) begin
        if (BL)
            TA = IAOQ_FRONT + 32'd8 + (offset_bl << 2); // shift-left by 2 = *4
        else if (COMB)
            TA = IAOQ_FRONT + 32'd8 + (offset_comb << 2);
        else
            TA = 32'd0;
    end

endmodule
