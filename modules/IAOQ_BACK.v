//Program Counter module
//Author: Gabriel Sanchez

module IAOQ_BACK (
    input clk,
    input reset,
    input LE,                // Load Enable
    input [7:0] D,          // Data input
    output reg [7:0] Q      // Output (current PC value)
);

    always @(posedge clk) begin
        if (reset)
            Q <= 8'b00000100;           // Reset the PC to 0
        else if (LE)
            Q <= D;               // Load D into PC if LE is active
    end

endmodule
