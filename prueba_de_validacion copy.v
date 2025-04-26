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
        #155;
        $display("Mem[44]= %b",uut.datamemory.Mem[44]);
        $display("Mem[45]= %b",uut.datamemory.Mem[45]);
        $display("Mem[46]= %b",uut.datamemory.Mem[46]);
        $display("Mem[47]= %b",uut.datamemory.Mem[47]);
    end

  

    // Monitor principal: PCFront y registros GR1, GR2, GR3, GR5, GR6
    initial begin
        $monitor("Time=%0t | PCBack=%d PCFrontIn=%d PCFrontOut=%d | J=%b COMB=%b| GR1=%d | GR2=%d | GR3=%d | GR5=%d ",
            $time,
            uut.PCBackOut,
            uut.PCFrontIn,
            uut.PCFrontOut,
            uut.EX_J,
            uut.EX_COMB,
            uut.RF.reg_file[1],
            uut.RF.reg_file[2],
            uut.RF.reg_file[3],
            uut.RF.reg_file[5]
        );
    end

   
    initial begin
        #160 $finish; 
    end

endmodule
