//32 bit Register module
//Author: Hiram R. Rodriguez Hernandez

module Register32(output reg [31:0] Q, input[31:0] D, input LE,CLK);
    always @(posedge CLK) begin
        if (LE)
            Q <= D;
    end
    endmodule
