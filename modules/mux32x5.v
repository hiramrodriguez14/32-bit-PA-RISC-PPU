//5 to 32 MUX module
//Author: Hiram R. Rodriguez Hernandez

module mux32x5 (
    input [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9,
                 R10, R11, R12, R13, R14, R15, R16, R17, R18, R19,
                 R20, R21, R22, R23, R24, R25, R26, R27, R28, R29,
                 R30, R31,  
    input [4:0] S,          // 5-bit selector
    output reg [31:0] N     // Selected output
);

    always @(*) begin 
        case (S)
            5'b00000: N = R0;
            5'b00001: N = R1;
            5'b00010: N = R2;
            5'b00011: N = R3;
            5'b00100: N = R4;
            5'b00101: N = R5;
            5'b00110: N = R6;
            5'b00111: N = R7;
            5'b01000: N = R8;
            5'b01001: N = R9;
            5'b01010: N = R10;
            5'b01011: N = R11;
            5'b01100: N = R12;
            5'b01101: N = R13;
            5'b01110: N = R14;
            5'b01111: N = R15;
            5'b10000: N = R16;
            5'b10001: N = R17;
            5'b10010: N = R18;
            5'b10011: N = R19;
            5'b10100: N = R20;
            5'b10101: N = R21;
            5'b10110: N = R22;
            5'b10111: N = R23;
            5'b11000: N = R24;
            5'b11001: N = R25;
            5'b11010: N = R26;
            5'b11011: N = R27;
            5'b11100: N = R28;
            5'b11101: N = R29;
            5'b11110: N = R30;
            5'b11111: N = R31;
            default: N = 32'b0; 
        endcase
    end
endmodule
