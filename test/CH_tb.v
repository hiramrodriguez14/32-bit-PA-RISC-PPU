`include "../modules/CH.v"
`timescale 1ns / 1ns

module CH_tb;

    // Registros de entrada
    reg BL;
    reg COMB;
    reg COMB_TF;
    reg n_in;
    reg [2:0] C;
    reg [3:0] ACC;
    
    // Salidas del módulo
    wire J;
    wire n_out;
    
    // Instanciar el módulo CH
    CH uut (
        .BL(BL),
        .COMB(COMB),
        .COMB_TF(COMB_TF),
        .n_in(n_in),
        .C(C),
        .ACC(ACC),
        .J(J),
        .n_out(n_out)
    );
    
    // Establecer estímulos
    initial begin
        // Establecer valores iniciales
        BL = 0;
        COMB = 0;
        COMB_TF = 0;
        n_in = 0;
        C = 3'b000;
        ACC = 4'b0000;

        // Simulación de test
        #10 ACC = 4'b0001; C = 3'b001; // Test Equal condition
        #10 COMB = 1; COMB_TF = 0; // Test Compare and branch true
        #10 C = 3'b010; // Test Less than (signed)
        #10 ACC = 4'b0011; C = 3'b001; // Test Equal condition
        #10 C = 3'b011; // Test Less than or equal (signed)
        #10 C = 3'b100; // Test Less than (unsigned)
        #10 C = 3'b101; // Test Less than or equal (unsigned)
        #10 ACC = 4'b0101; C = 3'b001; // Test Equal condition
        #10 C = 3'b110; // Test Overflow
        #10 C = 3'b111; // Test Odd
        
        // Test BL behavior
        #10 BL = 1; n_in = 1; // Force Jump (J = 1)
        #10 BL = 0; COMB_TF = 1; // Test Compare and branch false

        // Fin de la simulación
        #20 $finish;
    end
    
    // Monitor de resultados
    initial begin
        $monitor("Time: %0t | BL: %b | COMB: %b | C: %b | ACC: %b | J: %b | n_out: %b | n_in: %b", $time, BL, COMB, C, ACC, J, n_out, n_in);
    end

endmodule
