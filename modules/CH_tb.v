`timescale 1ns / 1ns
`include "../modules/CH.v"
module CH_tb;

    reg BL;
    reg COMB;
    reg COMB_TF;
    reg [2:0] C;
    reg [3:0] ACC;
    wire J;

    // Instanciamos el módulo CH
    CH uut (
        .BL(BL),
        .COMB(COMB),
        .COMB_TF(COMB_TF),
        .C(C),
        .ACC(ACC),
        .J(J)
    );

    initial begin
        $display("Inicio Testbench CH");
        
        // Inicializamos
        BL = 0; COMB = 0; COMB_TF = 0; C = 3'b000; ACC = 4'b0000;
        #5;

        // 1. Branch and Link debe brincar siempre
        BL = 1; COMB = 0; #5;
        $display("BL=1, J=%b (esperado 1)", J);
        BL = 0; #5;

        // 2. Compare and Branch TRUE (Equal) Z=1 → brinca
        COMB = 1; COMB_TF = 0; C = 3'b001; ACC = 4'b1000; #5;
        $display("COMB=1, TF=0, Z=1, J=%b (esperado 1)", J);

        // 3. Compare and Branch TRUE (Equal) Z=0 → no brinca
        ACC = 4'b0000; #5;
        $display("COMB=1, TF=0, Z=0, J=%b (esperado 0)", J);

        // 4. Compare and Branch FALSE (Equal) Z=0 → brinca
        COMB_TF = 1; ACC = 4'b0000; #5;
        $display("COMB=1, TF=1, Z=0, J=%b (esperado 1)", J);

        // 5. Compare and Branch FALSE (Equal) Z=1 → no brinca
        ACC = 4'b1000; #5;
        $display("COMB=1, TF=1, Z=1, J=%b (esperado 0)", J);

        // 6. Nunca saltar (C = 000)
        COMB = 1; COMB_TF = 0; C = 3'b000; ACC = 4'b0000; #5;
        $display("COMB=1, TF=0, C=000, J=%b (esperado 0)", J);

        $finish;
    end

endmodule
