//Register file testbench
//Author: Hiram R. Rodriguez Hernandez

`timescale 1ns / 1ns
`include "register_file.v"

module register_file_tb;

   
    reg [31:0] PW;      // Write data
    reg [4:0] RA;       // Read address A
    reg [4:0] RB;       // Read address B
    reg [4:0] RW;       // Write address
    reg EN;             // Enable signal
    reg CLK;            // Clock signal

    // Register file outputs
    wire [31:0] PA;     // Output register in port A
    wire [31:0] PB;     // Output register in port B
    wire [31:0] decoder_out;  // Output of the decoder


    register_file rf (
        .PW(PW),
        .RA(RA),
        .RB(RB),
        .RW(RW),
        .EN(EN),
        .CLK(CLK),
        .PA(PA),
        .PB(PB),
    );

   
    always begin
        #2 CLK = ~CLK; 
    end

    
    initial  begin
       
        $dumpfile("register_file_tb.vcd");
        $dumpvars(0, register_file_tb);

        CLK = 1'b0;          // CLK cleared
        PW  = 32'b00000000000000000000000000010100; // 20b
        RA  = 5'b00000;
        RB  = 5'b11111;      // 31b
        RW  = 5'b00000;
        EN  = 1'b1;         // Enable set

        
        
        repeat (31) begin
            #4;  
            
         
         PW = PW + 1;
         RW = RW + 1;
         RA = RA + 1;
         RB = RB + 1;


            
        end
        #4;
         // Ya que el repeat termino RA esta en 1111, y se cambia LE a 0 y PW a 55
        
        EN = 1'b0;  // Enable cleared
        PW = 32'b00000000000000000000000000110111; // 55b
        
            repeat (32) begin
            #4;  

         
         PW = PW + 1;
         RW = RW + 1;
         RA = RA + 1;
         RB = RB + 1;  


            
        end
      
        $finish;  
    end


    initial begin
        $display("  Time  |  CLK    |   PW           |  RW    |  RA   |  RB     |  PA            |  PB            |  decoder_out  ");
        $display("--------+---------+----------------+--------+--------+---------+---------------+----------------+--------------------------");
        $monitor("Time = %0t , CLK = %d, PW = %d, RW = %d, RA = %d, RB = %d, PA = %d, PB = %d",
        $time, CLK, PW, RW, RA, RB, PA, PB);

    end

endmodule
