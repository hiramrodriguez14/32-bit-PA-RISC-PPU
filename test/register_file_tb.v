//Register file testbench
//Author: Hiram R. Rodriguez Hernandez

`timescale 1ns / 1ns
`include "../modules/register_file.v"

module register_file_tb;

   
 reg [31:0] PW;
reg [4:0] RA;
reg [4:0] RB;
reg [4:0] RW;
reg EN;
reg CLK;


    // Register file outputs
    wire [31:0] PA;     // Output register in port A
    wire [31:0] PB;     // Output register in port B
    wire [31:0] decoder_out;  // Output of the decoder


    register_file rf (
        .PD(PW),
        .RA(RA),
        .RB(RB),
        .RD(RW),
        .EN(EN),
        .CLK(CLK),
        .PA(PA),
        .PB(PB)
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
        $display("  Time  |  CLK    |   PW           |  RW    |  RA   |  RB     |  PA            |  PB            |  R1  ");
        $display("--------+---------+----------------+--------+--------+---------+---------------+----------------+--------------------------");
        $monitor("Time = %0t , CLK = %d, PW = %d, RW = %d, RA = %d, RB = %d, PA = %d, PB = %d, R1 = %d ",
        $time, CLK, PW, RW, RA, RB, PA, PB, rf.reg_file[0]);

    end

endmodule
