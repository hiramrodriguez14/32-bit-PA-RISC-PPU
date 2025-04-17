//32 bit Register module
//Author: Hiram R. Rodriguez Hernandez

module Register32(output reg [31:0] Q, input [31:0] D, input LE, CLK);
    
    initial begin
        Q = 0; // <-- esta línea es la clave
    end

    always @(posedge CLK) begin
        if (LE)
            Q <= D;
    end

endmodule

