module mux2to1 (
    input  wire  in0,
    input  wire  in1,
    input  wire  sel,
    output wire  out
);

    assign out = (sel == 1'b0) ? in0 : in1;

endmodule
