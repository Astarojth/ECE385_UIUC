module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */

    logic [2:0] c;
    fourbit_ripple_adder FR0(.A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .Cout(c[0]),.S(Sum[3:0]));
    fourbit_ripple_adder FR1(.A(A[7:4]), .B(B[7:4]), .Cin(c[0]), .Cout(c[1]),.S(Sum[7:4]));
    fourbit_ripple_adder FR2(.A(A[11:8]), .B(B[11:8]), .Cin(c[1]), .Cout(c[2]),.S(Sum[11:8]));
    fourbit_ripple_adder FR3(.A(A[15:12]), .B(B[15:12]), .Cin(c[2]), .Cout(CO),.S(Sum[15:12]));
	 
endmodule

module fourbit_ripple_adder
(
    input logic[3:0] A,
    input logic[3:0] B,
    input logic Cin,
    output logic Cout,
    output logic[3:0] S
);
    logic [2:0] c;
    full_adder FA0(.x(A[0]), .y(B[0]), .z(Cin), .c(c[0]), .s(S[0]));
    full_adder FA1(.x(A[1]), .y(B[1]), .z(c[0]), .c(c[1]), .s(S[1]));
    full_adder FA2(.x(A[2]), .y(B[2]), .z(c[1]), .c(c[2]), .s(S[2]));
    full_adder FA3(.x(A[3]), .y(B[3]), .z(c[2]), .c(Cout), .s(S[3]));
	 
endmodule

module full_adder
(
	input logic x,y,z, 
	output logic c,s
);
	assign s=x^y^z;
	assign c=(x&y)|(y&z)|(z&x);
	
endmodule
