//Register file module
//Author: Hiram R. Rodriguez Hernandez

`timescale 1s / 1s
`include "decoder5x32.v"
`include "mux32x5.v"
`include "register32.v"

module register_file (
   input [31:0] PW,      // Write data
   input [4:0] RA,       // Read address A (Mux 1)
   input [4:0] RB,       // Read address B (Mux 2)
   input [4:0] RW,       // Write address (Decoder)
   input EN,             // Enable signal (Decoder)
   input CLK,            // Clock signal
   output [31:0] PA,     // Output register in port A
   output [31:0] PB,     // Output register in port B
   output [31:0] decoder_out  // Output of the decoder (enables registers)
);

  
   wire [31:0] reg_file [31:0]; //32 wires of 32 bits each that will carry the data of the registers to the MUXes
 
   // Decoder to enable the write of the registers
   Decoder5x32 decoder (
       .RW(RW),
       .EN(EN),
       .OUT(decoder_out)
   );

    //R0
    Register32 reg_inst (
               .Q(reg_file[0]),      // Register output
               .D(32'b0),               // Register 0 will always have the value 0
               .LE(decoder_out[0]),  // Write enable comes from the first bit of the decoder
               .CLK(CLK)
           );
           
   // Instantiating the remaining 31 registers
   genvar i;
   generate
       for (i = 1; i < 32; i = i + 1) begin : register_array
           Register32 reg_inst (
               .Q(reg_file[i]),      // Register output will be conected to the reg_file array
               .D(PW),               // Data to write
               .LE(decoder_out[i]),  // Write enable comes from decoder
               .CLK(CLK)
           );
       end
   endgenerate

// MUXes to select the registers to read

//MUX to select the register to read in port A
mux32x5 mux1 (
    .R0(reg_file[0]),  .R1(reg_file[1]),  .R2(reg_file[2]),  .R3(reg_file[3]),  .R4(reg_file[4]),
    .R5(reg_file[5]),  .R6(reg_file[6]),  .R7(reg_file[7]),  .R8(reg_file[8]),  .R9(reg_file[9]),
    .R10(reg_file[10]), .R11(reg_file[11]), .R12(reg_file[12]), .R13(reg_file[13]), .R14(reg_file[14]),
    .R15(reg_file[15]), .R16(reg_file[16]), .R17(reg_file[17]), .R18(reg_file[18]), .R19(reg_file[19]),
    .R20(reg_file[20]), .R21(reg_file[21]), .R22(reg_file[22]), .R23(reg_file[23]), .R24(reg_file[24]),
    .R25(reg_file[25]), .R26(reg_file[26]), .R27(reg_file[27]), .R28(reg_file[28]), .R29(reg_file[29]),
    .R30(reg_file[30]), .R31(reg_file[31]),
    .S(RA), .N(PA)
);


//MUX to select the register to read in port B
mux32x5 mux2 (
    .R0(reg_file[0]),  .R1(reg_file[1]),  .R2(reg_file[2]),  .R3(reg_file[3]),  .R4(reg_file[4]),
    .R5(reg_file[5]),  .R6(reg_file[6]),  .R7(reg_file[7]),  .R8(reg_file[8]),  .R9(reg_file[9]),
    .R10(reg_file[10]), .R11(reg_file[11]), .R12(reg_file[12]), .R13(reg_file[13]), .R14(reg_file[14]),
    .R15(reg_file[15]), .R16(reg_file[16]), .R17(reg_file[17]), .R18(reg_file[18]), .R19(reg_file[19]),
    .R20(reg_file[20]), .R21(reg_file[21]), .R22(reg_file[22]), .R23(reg_file[23]), .R24(reg_file[24]),
    .R25(reg_file[25]), .R26(reg_file[26]), .R27(reg_file[27]), .R28(reg_file[28]), .R29(reg_file[29]),
    .R30(reg_file[30]), .R31(reg_file[31]),
    .S(RB), .N(PB)
);




endmodule
