

module instruction_memory (
    input [7:0] A,      // Dirección de 8 bits (256 ubicaciones)
    output reg [31:0] I // Salida de 32 bits (instrucción completa)
);

    reg [7:0] Mem [0:255]; // Memoria de 256 bytes

    initial begin
        $readmemb("Fase_III_code.txt", Mem); // Leer binario en lugar de hex
    end

    always @(*) begin
        I = {Mem[A], Mem[A+1], Mem[A+2], Mem[A+3]}; // Lectura en Big-Endian
    end

endmodule
