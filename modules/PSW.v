// Description: 2-bit PSW module with nullification and carry tracking
// Author: Alex J. Strubbe
module PSW (
    input  clk,
    input  PSW_EN,
    input  C_B,         // Carry from ALU
    input  N_in,        // Nullification signal from condition logic
    output reg Co,      // Output carry bit
    output reg N_out
);

    always @(posedge clk) begin
        if (PSW_EN) begin

            N_out <= N_in;      // Store Nullify until updated again

            if (N_in)
                Co <= 1'b0;     // Nullify the instruction result
            else
                Co <= C_B;      // Store carry from ALU
        end
    end

endmodule
