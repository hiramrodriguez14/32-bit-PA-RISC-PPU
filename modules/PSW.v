// Description: 2-bit PSW module with nullification and carry tracking
// Author: Alex J. Strubbe
module PSW (
    input  clk,
    input  Reset,
    input  PSW_EN,
    input  C_B,         // Carry from ALU
    output reg Co       // Output carry bit
);

    always @(posedge clk) begin
        if (Reset) begin
            Co <= 1'b0;        // Clear Carry on Reset
        end else if (PSW_EN) begin
            Co <= C_B;         // Store carry from ALU
        end
    end

endmodule
