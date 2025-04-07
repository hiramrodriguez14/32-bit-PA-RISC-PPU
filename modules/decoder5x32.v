//5 to 32 Decoder module
//Author: Hiram R. Rodriguez Hernandez

module Decoder5x32 (
    input [4:0] RW,
    input EN,
    output reg [31:0] OUT  
);

    always @(*) begin
        if (EN ) 
            OUT = 32'b1 << RW; // Out is 0x0001 and that 1 will be shifted RW times to the left to calculate 
                               // the register that will be enabled. Ex: if RW=0x000 then OUT=0x0001, if RW=0x001 then OUT=0x0002
        else
            OUT = 32'b0; // If EN is 0 then no register will be selected 
        
    end

endmodule
