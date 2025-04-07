`timescale 1ns / 1ns
`include "ALU.v"

module ALU_tb;
    // Testbench Signals
    reg [31:0] A, B;
    reg [3:0] OP;
    reg Ci;
    wire [31:0] Out;
    wire [3:0] Flags;

    // Instantiate ALU
    ALU uut (
        .A(A),
        .B(B),
        .OP(OP),
        .Ci(Ci),
        .Out(Out),
        .Flags(Flags)
    );

    initial begin

        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);

        // Initialize inputs
        A = 32'b10011100000000000000000000111000; //  Decimal: 2617245752
        B = 32'b01110000000000000000000000000011; //  Decimal: 1879048195
        Ci = 0;
        
        // Monitor output
        $monitor("Time=%0t | OP=%b | A=%d (%b) | B=%d (%b) | Out=%d (%b) | Flags=%b", 
                  $time, OP, A, A, B, B, Out, Out, Flags);

        // Iterate OP from 0000 to 1100 (0 to 12 in decimal)
        for (OP = 4'b0000; OP <= 4'b1100; OP = OP + 1) begin
            #2; // Wait 2 time units before next OP value
        end

        // Change Ci to 1 and repeat OP from 0000 to 0011
        Ci = 1;
        for (OP = 4'b0000; OP <= 4'b0011; OP = OP + 1) begin
            #2; // Wait 2 time units before next OP value
        end

        $finish; // End simulation
    end
endmodule
