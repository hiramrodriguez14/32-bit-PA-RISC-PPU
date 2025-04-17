//Program Counter module
//Author: Gabriel Sanchez

module IAOQ_BACK (
    input clk,
    input reset,
    input LE,                // Load Enable
    input [31:0] D,          // Data input
    output reg [31:0] Q      // Output (current PC value)
);

    always @(posedge clk) begin
        if (reset)
            Q <= 32'b00000000000000000000000000000100;           // Reset the PC to 4
        else if (LE)
            Q <= D;               // Load D into PC if LE is active
    end

endmodule
