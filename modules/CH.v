module CH (
    input wire BL,
    input wire COMB,
    input wire COMB_TF,
    input wire n_in,
    input wire [2:0] C,
    input wire [3:0] ACC, // {V, C, N, Z}
    output reg J,
    output reg n_out
);

// Flags del ACC
//Z = ACC[3];        // Zero
//N = ACC[2];        // Sign
//C  = ACC[1]; 1  // Carry (unsigned)
//V = ACC[0];        // Overflow (signed)

reg cond;

// Evaluación de condición
always @(*) begin
    case (C)
        3'b000: cond = 1'b0;             // Never
        3'b001: cond = ACC[3];                // Equal
        3'b010: cond = ACC[2] ^ ACC[0];            // Less than (signed)
        3'b011: cond = (ACC[2] ^ ACC[0]) | ACC[3];      // Less than or equal (signed)
        3'b100: cond = ACC[1];           // Less than (unsigned)
        3'b101: cond = ACC[1] | ACC[3];       // Less than or equal (unsigned)
        3'b110: cond = ACC[0];                // Overflow
        3'b111: cond = ~ACC[3];               // Odd → Out ≠ 0 → Z = 0
        default: cond = 1'b0;
    endcase
end

// Lógica de salto
always @(*) begin
    if (BL) begin
        J = 1;
    end else if (COMB) begin
        if (COMB_TF == 1'b0) begin // Compare and branch true
            J = cond ? 1'b1 : 1'b0;
        end else begin            // Compare and branch false
            J = cond ? 1'b0 : 1'b1;
        end
    end else begin
        J = 0;
    end
    n_out = J & n_in;
end



endmodule
