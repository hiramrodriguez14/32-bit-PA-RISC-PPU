module pc_back (
    input clk,
    input reset,
    input LE,
    input [31:0] pc_front_in,
    output reg [31:0] pc_back_out
);
    wire [31:0] pc_incremented;

    adder4 add4 (
        .in(pc_front_in),
        .out(pc_incremented)
    );

    always @(posedge clk) begin
        if (reset)
            pc_back_out <= 32'd4;      // RESET: pone PCBack en 4
        else if (LE)
            pc_back_out <= pc_incremented; // Solo actualiza si LE está activo
    end
endmodule
