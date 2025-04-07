`timescale 1ns / 1ps
`include "SOH.v"
module test_op_handler;
    reg [31:0] RB;
    reg [20:0] I;
    reg [4:0] p;
    reg [2:0] S;
    wire [31:0] N;
    parameter sim_time = 20;
    
   
    operand_handler op(RB, I, S, N);

    
    initial #sim_time $finish;

   
    initial begin

        $dumpfile("SOH.vcd");
        $dumpvars(0, test_op_handler);

        RB = 32'b10000100001100011111111111101011; 
        I = 21'b100000100011101100001;            
        S = 3'b000;                               
        
        
        repeat(7) #2 S = S + 3'b001;  
    end

    
   initial begin
    $display("  Time  |  RB  |   I    |  S  |  N  ");
    $display("-------+-------+-------+-----+-----+------");
    $monitor("%0t | %b | %b | %b | %b", $time, RB, I, S, N);
end


endmodule

