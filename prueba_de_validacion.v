`timescale 1s / 1s
`include "PA_RISC.v"

module PA_RISC_tb;

    reg clk;
    reg reset;

    // Instancia del procesador
    PA_RISC uut (
        .clk(clk),
        .reset(reset)
    );

    // Generador de reloj: cambia cada 2 unidades de tiempo
    initial begin
        clk = 0;
        forever #2 clk = ~clk;
    end

    // Inicialización de reset
    initial begin
        reset = 1;
        #3 reset = 0;
    end

    // Monitor principal: PCFront y registros GR1, GR2, GR3, GR5, GR6
    initial begin
        $monitor("Time=%0t | PCFront=%0d | GR1=%0d | GR2=%0d | GR3=%0d | GR5=%0d | GR6=%0d",
            $time,
            uut.ID_IAOQ_FRONT,
            uut.RF.reg_file[1],
            uut.RF.reg_file[2],
            uut.RF.reg_file[3],
            uut.RF.reg_file[5],
            uut.RF.reg_file[6]
        );
    end

   
    initial begin
        #80 $finish; 
    end

endmodule
