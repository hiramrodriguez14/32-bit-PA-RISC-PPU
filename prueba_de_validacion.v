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
        // $monitor("Time=%0t | PCFront=%0d | MUX PA=%b PA=%b ALU=%b MEM=%b WB=%b ctrl=%b| GR1=%0b | GR2=%0d | GR3=%0d | GR5=%0d | GR6=%0d",
        //     $time,
        //     uut.PCFrontOut,
        //     uut.ID_MUX_PA_OUT,
        //     uut.ID_PA_OUT,
        //     uut.ALU_Out,
        //     uut.MEM_PD_OUT,
        //     uut.WB_PD_out,
        //     uut.AS_OUT,
        //     uut.RF.reg_file[1],
        //     uut.RF.reg_file[2],
        //     uut.RF.reg_file[3],
        //     uut.RF.reg_file[5],
        //     uut.RF.reg_file[6]
        // );
            $monitor("Time=%0t | PCFrontin=%d PCFrontout=%d |  GR1=%b | GR2=%d | GR3=%d | GR5=%d | GR6=%d",
            $time,
            uut.PCFrontIn,
            uut.PCFrontOut,
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
