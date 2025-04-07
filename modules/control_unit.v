//Control Unit Module
//Author: Hiram R. Rodriguez Hernandez
module control_unit(
    input [31:0] instruction,
    output reg SH,
    output reg [1:0] RD_F,
    output reg BL,
    output reg [2:0] SOH_OP,
    output reg [3:0] ALU_OP,
    output reg [3:0] RAM_CTRL,
    output reg L,
    output reg [1:0] ID_SR,
    output reg RF_LE,
    output reg PSW_EN,
    output reg CO_EN,
    output reg [1:0] COMB
    
);

    always @(*) begin
        // Decode instruction
        case (instruction[31:26]) //opcode
            6'b000010: begin //Three-Register Arithmetic and Logical instructions opcode
                case(instruction[11:0])//opcode 2
                6'b011000:begin//ADD 
                ALU_OP = 4'b0000;
                RD_F = 2'b10;
                BL = 1'b0;
                SOH_OP = 3'b000;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b11;
                RF_LE = 1'b1;
                PSW_EN = 1'b1;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
                
            end
             6'b011100: begin //ADDC
                ALU_OP = 4'b0001;
                RD_F = 2'b10;
                BL = 1'b0;
                SOH_OP = 3'b000;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b11;
                RF_LE = 1'b1;
                PSW_EN = 1'b1;
                CO_EN = 1'b1;
              COMB = 2'b00;
              SH = 1'b0;
            end
             6'b101000: begin //ADDL
                ALU_OP = 4'b0000;
                RD_F = 2'b10;
                BL = 1'b0;
                SOH_OP = 3'b000;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b11;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
            6'b010000: begin //SUB
                ALU_OP = 4'b0010;
                RD_F = 2'b10;
                BL = 1'b0;
                SOH_OP = 3'b000;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b11;
                RF_LE = 1'b1;
                PSW_EN = 1'b1;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
            6'b010100: begin //SUBB
                ALU_OP = 4'b0011;
                RD_F = 2'b10;
                BL = 1'b0;
                SOH_OP = 3'b000;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b11;
                RF_LE = 1'b1;
                PSW_EN = 1'b1;
                CO_EN = 1'b1;
                COMB = 2'b00;
                SH = 1'b0;
            end
            6'b001001: begin //OR
                ALU_OP = 4'b0101;
                RD_F = 2'b10;
                BL = 1'b0;
                SOH_OP = 3'b000;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b11;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
            6'b001010: begin //XOR
                ALU_OP = 4'b0110;
                RD_F = 2'b10;
                BL = 1'b0;
                SOH_OP = 3'b000;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b11;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
            6'b001000: begin //AND
                ALU_OP = 4'b0111;
                RD_F = 2'b10;
                BL = 1'b0;
                SOH_OP = 3'b000;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b11;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        endcase
    end
        6'b010010: begin //Load Word
                ALU_OP = 4'b0000;
                RD_F = 2'b00;
                BL = 1'b0;
                SOH_OP = 3'b010;
                RAM_CTRL = 4'b1000;
                L = 1'b1;
                ID_SR = 2'b10;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b010001: begin //Load Half Word
                ALU_OP = 4'b0000;
                RD_F = 2'b00;
                BL = 1'b0;
                SOH_OP = 3'b010;
                RAM_CTRL = 4'b0100;
                L = 1'b1;
                ID_SR = 2'b10;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b010000: begin //Load Byte
                ALU_OP = 4'b0000;
                RD_F = 2'b00;
                BL = 1'b0;
                SOH_OP = 3'b010;
                RAM_CTRL = 4'b0000;
                L = 1'b1;
                ID_SR = 2'b10;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b011010: begin //Store Word
                ALU_OP = 4'b0000;
                RD_F = 2'b00;
                BL = 1'b0;
                SOH_OP = 3'b010;
                RAM_CTRL = 4'b1011;
                L = 1'b0;
                ID_SR = 2'b10;
                RF_LE = 1'b0;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b011001: begin //Store Half Word
                ALU_OP = 4'b0000;
                RD_F = 2'b00;
                BL = 1'b0;
                SOH_OP = 3'b010;
                RAM_CTRL = 4'b0111;
                L = 1'b0;
                ID_SR = 2'b10;
                RF_LE = 1'b0;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b011000: begin //Store Byte
                ALU_OP = 4'b0000;
                RD_F = 2'b00;
                BL = 1'b0;
                SOH_OP = 3'b010;
                RAM_CTRL = 4'b0011;
                L = 1'b0;
                ID_SR = 2'b10;
                RF_LE = 1'b0;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b001101: begin //Load Offset
                ALU_OP = 4'b0000;
                RD_F = 2'b00;
                BL = 1'b0;
                SOH_OP = 3'b010;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b10;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b001000: begin //Load Immediate
                ALU_OP = 4'b0000;
                RD_F = 2'b01;
                BL = 1'b0;
                SOH_OP = 3'b011;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b10;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b111010: begin //Branch and Link
                ALU_OP = 4'b0000;
                RD_F = 2'b01;
                BL = 1'b1;
                SOH_OP = 3'b111;
                RAM_CTRL = 4'b0000;
                L = 1'b0;
                ID_SR = 2'b00;
                RF_LE = 1'b1;
                PSW_EN = 1'b0;
                CO_EN = 1'b0;
                COMB = 2'b00;
                SH = 1'b0;
            end
        6'b100000: begin //Compare and Branch if True
                        ALU_OP = 4'b0010;
                        RD_F = 2'b11;
                        BL = 1'b0;
                        SOH_OP = 3'b000;
                        RAM_CTRL = 4'b0000;
                        L = 1'b0;
                        ID_SR = 2'b11;
                        RF_LE = 1'b0;
                        PSW_EN = 1'b0;
                        CO_EN = 1'b0;
                        COMB = 2'b10; //bit [1] means its a COMB instruction and bit [0] means its a COMBT instruction   
                        SH = 1'b0;
                    end
        6'b100010: begin //Compare and Branch if False
                        ALU_OP = 4'b0010;
                        RD_F = 2'b11;
                        BL = 1'b0;
                        SOH_OP = 3'b000;
                        RAM_CTRL = 4'b0000;
                        L = 1'b0;
                        ID_SR = 2'b11;
                        RF_LE = 1'b0;
                        PSW_EN = 1'b0;
                        CO_EN = 1'b0;
                        COMB = 2'b11; //bit [1] means its a COMB instruction and bit [0] means its a COMBF instruction   
                        SH = 1'b0;
                    end
                6'b101101: begin //ADD Immediate
                        ALU_OP = 4'b0000;
                        RD_F = 2'b00;
                        BL = 1'b0;
                        SOH_OP = 3'b001;
                        RAM_CTRL = 4'b0000;
                        L = 1'b0;
                        ID_SR = 2'b10;
                        RF_LE = 1'b1;
                        PSW_EN = 1'b1;
                        CO_EN = 1'b0;
                        COMB = 2'b00;
                        SH = 1'b0;
                    end
                6'b100101: begin //SUB Immediate
                        ALU_OP = 4'b0010;
                        RD_F = 2'b00;
                        BL = 1'b0;
                        SOH_OP = 3'b001;
                        RAM_CTRL = 4'b0000;
                        L = 1'b0;
                        ID_SR = 2'b10;
                        RF_LE = 1'b1;
                        PSW_EN = 1'b1;
                        CO_EN = 1'b0;
                        COMB = 2'b00;
                        SH = 1'b0;
                        end
                    6'b110100: begin // Shift Right
                case (instruction[12:10]) // opcode 2
                    3'b110: begin // Shift Right with zero extension (EXTRU)
                        ALU_OP = 4'b1010;
                        RD_F = 2'b10;
                        BL = 1'b0;
                        SOH_OP = 3'b100;
                        RAM_CTRL = 4'b0000;
                        L = 1'b0;
                        ID_SR = 2'b01;
                        RF_LE = 1'b1;
                        PSW_EN = 1'b0;
                        CO_EN = 1'b0;
                        COMB = 2'b00;
                        SH = 1'b1;
                    end
                    3'b111: begin // Shift Right with sign extension (EXTRS)
                        ALU_OP = 4'b1010;
                        RD_F = 2'b10;
                        BL = 1'b0;
                        SOH_OP = 3'b101;
                        RAM_CTRL = 4'b0000;
                        L = 1'b0;
                        ID_SR = 2'b01;
                        RF_LE = 1'b1;
                        PSW_EN = 1'b0;
                        CO_EN = 1'b0;
                        COMB = 2'b00;
                        SH = 1'b1;
                    end
                endcase
            end

            6'b110101: begin // Shift Left
                case (instruction[12:10]) // opcode 2
                    3'b010: begin // Shift Left with zero extension (ZDEP)
                        ALU_OP = 4'b1010;
                        RD_F = 2'b10;
                        BL = 1'b0;
                        SOH_OP = 3'b110;
                        RAM_CTRL = 4'b0000;
                        L = 1'b0;
                        ID_SR = 2'b01;
                        RF_LE = 1'b1;
                        PSW_EN = 1'b0;
                        CO_EN = 1'b0;
                        COMB = 2'b00;
                        SH = 1'b1;
                    end
                endcase
            end

                    default: begin // NOP
                    ALU_OP = 4'b0000;
                    RD_F = 2'b00;
                    BL = 1'b0;
                    SOH_OP = 3'b000;
                    RAM_CTRL = 4'b0000;
                    L = 1'b0;
                    ID_SR = 2'b10;
                    RF_LE = 1'b0;
                    PSW_EN = 1'b0;
                    CO_EN = 1'b0;
                    COMB = 2'b00;
                    SH = 1'b0;
                end
            endcase // <-- CIERRA el case principal
        end
    endmodule
