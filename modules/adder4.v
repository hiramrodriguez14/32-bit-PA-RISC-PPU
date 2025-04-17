// Description: 4-bit adder module
//Author: Gabrile Sanchez
module adder4 (
    input [31:0] in,
    output [31:0] out
);
    assign out = in + 32'd4;
endmodule
