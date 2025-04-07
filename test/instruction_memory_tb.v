`timescale 1ns / 1ps
`include "instruction_memory.v"
module instruction_memory_tb;

    reg [7:0] A;      // Dirección de entrada
    wire [31:0] I;    // Salida de la memoria

    // Instancia del módulo de la memoria de instrucciones
    instruction_memory uut (
        .A(A),
        .I(I)
    );

    initial begin

        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);
        // Esperar que la memoria cargue los datos
        #10;
        
        // Leer las posiciones 0, 4, 8 y 12
        A = 8'd0;  #10;
        $display("A = %d, I = 0x%h", A, I);

        A = 8'd4;  #10;
        $display("A = %d, I = 0x%h", A, I);

        A = 8'd8;  #10;
        $display("A = %d, I = 0x%h", A, I);

        A = 8'd12; #10;
        $display("A = %d, I = 0x%h", A, I);

        // Terminar la simulación
        $stop;
    end

endmodule
