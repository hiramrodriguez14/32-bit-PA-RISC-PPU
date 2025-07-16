module DataMemory (
    input wire clk,           // Clock
    input wire [7:0] A,       // Dirección de memoria (8 bits para 256 bytes)
    input wire [31:0] DI,     // Datos de entrada
    output reg [31:0] DO,     // Datos de salida
    input wire [1:0] Size,    // Tamaño: 00 = byte, 01 = halfword, 10 = word
    input wire RW,            // 0 = Read, 1 = Write
    input wire E              // Enable de escritura
);

    reg [7:0] Mem [0:255]; // Memoria de 256 bytes


    integer file, i, code;
    reg [7:0] temp;

    initial begin
        file = $fopen("Test_2_PA-RISC.txt", "r");
        if (file == 0) begin
            $display("ERROR: No se pudo abrir Test_2_PA-RISC.txt");
            $finish;
        end
        
      
        for (i = 0; i < 256; i = i + 1) begin
            code = $fscanf(file, "%b\n", temp); 
            if (code == 1) begin
                Mem[i] = temp;
            end else begin
                Mem[i] = 8'b0;
            end
        end

        $fclose(file);

 
    end

   
    always @(*) begin
        if (RW == 0) begin
            case (Size)
                2'b00: DO = {24'b0, Mem[A]}; // Leer un byte
                2'b01: DO = {16'b0, Mem[A], Mem[A+1]}; // Leer un halfword
                2'b10: DO = {Mem[A], Mem[A+1], Mem[A+2], Mem[A+3]}; // Leer un word
                default: DO = 32'b0;
            endcase
        end else begin
            DO = 32'b0; // Cuando RW=1 (escritura), salida a 0
        end
    end

   
    always @(posedge clk) begin
        if (RW == 1 && E == 1) begin 
            case (Size)
                2'b00: Mem[A] <= DI[7:0]; // Escribir un byte
                2'b01: begin // Escribir un halfword (big-endian)
                    Mem[A]   <= DI[15:8];
                    Mem[A+1] <= DI[7:0];
                end
                2'b10: begin // Escribir un word (big-endian)
                    Mem[A]   <= DI[31:24];
                    Mem[A+1] <= DI[23:16];
                    Mem[A+2] <= DI[15:8];
                    Mem[A+3] <= DI[7:0];
                end
            endcase
        end
    end

endmodule
