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
        $monitor("Time=%t | PCFront=%d | GR1=%d | GR2=%d | GR3=%d | GR5=%d | GR6=%d | ALU=%b | ctrl=%b | PD=%b | MEM_data=%b | MEM[80]=%b | MEM[81]=%b | MEM[82]=%b | MEM[83]=%b",
            $time,
            uut.PCFrontOut,
            uut.RF.reg_file[1],
            uut.RF.reg_file[2],
            uut.RF.reg_file[3],
            uut.RF.reg_file[5],
            uut.RF.reg_file[6],
            uut.MEM_ALU_OUT_out,
            uut.MEM_L_out,
            uut.MEM_PD_OUT,
            uut.MEM_DATA_OUT,
            uut.datamemory.Mem[80],
            uut.datamemory.Mem[81],
            uut.datamemory.Mem[82],
            uut.datamemory.Mem[83]
        );
    end

   
    initial begin
        #80 $finish; 
    end

endmodule
