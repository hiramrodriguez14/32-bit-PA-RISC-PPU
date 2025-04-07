// Description: 4-bit adder module
//Author: Gabrile Sanchez
module adder4 (
    input [7:0] in,
    output [7:0] out
);
    assign out = in + 8'd4;
endmodule
