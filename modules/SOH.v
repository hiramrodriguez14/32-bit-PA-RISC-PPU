
//SOH module
module operand_handler (
    input  [31:0] RB, // Register B
    input  [20:0] I,  // Immediate
    input  [2:0]  S,  // Selector
    output reg [31:0] N // Output
);

    always @(*) begin
        case (S)
            3'b000: N = RB;
            3'b001: N = {{22{I[0]}}, I[10:1]}; // Sign extension I[10:0]
            3'b010: N = {{19{I[0]}}, I[13:1]}; // Sign extension de I[13:0]
            3'b011: N = {I[20:0], 11'b0};       // Zero extension
            3'b100: N = RB >> (31 - I[9:5]);         // Shift right
            3'b101: N = $signed(RB) >>> (31 - I[9:5]); // Shift right arithmetic
            3'b110: N = RB << (31 - I[9:5]);         // Shift left                
            default: N = 32'b0; // Default case 
        endcase
    end

endmodule
