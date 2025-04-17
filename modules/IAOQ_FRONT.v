//Program Counter module
//Author: Gabriel Sanchez

module IAOQ_FRONT (
    input clk,
    input reset,
    input LE,                // Load Enable
    input [31:0] D,          // Data input
    output reg [31:0] Q      // Output (current PC value)
);

always @(posedge clk or posedge reset) begin
    if (reset)
        Q <= 32'd0; 
    else if (LE)
        Q <= D;
end
endmodule
