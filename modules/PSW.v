// Description: 2-bit PSW module with nullification and carry tracking
// Author: Alex J. Strubbe
module PSW (
    input  clk,
    input  PSW_EN,
    input  C_B,         // Carry from ALU
    output reg Co      // Output carry bit
);

    always @(posedge clk) begin
        if (PSW_EN) begin
                Co <= C_B;      // Store carry from ALU
        end
    end

endmodule
