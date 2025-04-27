`include "../modules/data_memory.v"
`timescale 1ns / 1ps

module data_memory_tb;

    reg [7:0] A;
    reg [31:0] DI;
    wire [31:0] DO;
    reg [1:0] Size;
    reg RW;
    reg E;
    reg clk;
    // Instancia de la memoria
    DataMemory RAM (
        .A(A),
        .DI(DI),
        .DO(DO),
        .Size(Size),
        .RW(RW),
        .E(E)
    );

    // Reloj
    always #5 clk = ~clk;

    initial begin

        $dumpfile("data_memory.vcd");
        $dumpvars(0, data_memory_tb);
        
        clk = 0;
        RW = 0; E = 0;

        // Leer word de localizaciones 0, 4, 8 y 12
        A = 8'h00; Size = 2'b10; #10;
        $display("A=%d, DO=%b, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);
        A = 8'h04; Size = 2'b10; #10;
        $display("A=%d, DO=%b, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);
        A = 8'h08; Size = 2'b10; #10;
        $display("A=%d, DO=%b, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);
        A = 8'h0C; Size = 2'b10; #10;
        $display("A=%d, DO=%b, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);

        // Leer byte de localizaciones 0 y 3
        A = 8'd48; Size = 2'b00; #10;
        $display("A=%d, DO=%b, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);
        A = 8'd52; Size = 2'b00; #10;
        $display("A=%d, DO=%b, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);

        // Leer halfword de localizaciones 4 y 6
        A = 8'h04; Size = 2'b01; #10;
        $display("A=%d, DO=%h, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);
        A = 8'h06; Size = 2'b01; #10;
        $display("A=%d, DO=%h, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);

        // Escrituras
        RW = 1; E = 1;
        A = 8'h00; DI = 32'h000000A6; Size = 2'b00; #10;
        A = 8'h02; DI = 32'h000000DD; Size = 2'b00; #10;
        A = 8'h04; DI = 32'h0000ABCD; Size = 2'b01; #10;
        A = 8'h06; DI = 32'h0000EF01; Size = 2'b01; #10;
        A = 8'h0C; DI = 32'h33445566; Size = 2'b10; #10;

        

        // Leer nuevamente word de 0, 4 y 12 para verificar escritura
        RW = 0; E = 0;
        A = 8'h00; Size = 2'b10; #10;
        $display("A=%d, DO=%h, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);
        A = 8'h04; Size = 2'b10; #10;
        $display("A=%d, DO=%h, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);
        A = 8'h0C; Size = 2'b10; #10;
        $display("A=%d, DO=%h, Size=%b, RW=%b, E=%b", A, DO, Size, RW, E);

        $finish;
    end
endmodule
