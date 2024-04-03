module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
    
    logic [3:0] c, c0, c1; 
    logic [15:0] s0, s1;
    four_ripple_adder FR0(.A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .Cout(c0[0]),.S(s0[3:0]));
    four_ripple_adder FR2(.A(A[7:4]), .B(B[7:4]), .Cin(1'b0), .Cout(c0[1]),.S(s0[7:4]));
    four_ripple_adder FR3(.A(A[7:4]), .B(B[7:4]), .Cin(1'b1), .Cout(c1[1]),.S(s1[7:4]));
    four_ripple_adder FR4(.A(A[11:8]), .B(B[11:8]), .Cin(1'b0), .Cout(c0[2]),.S(s0[11:8]));
    four_ripple_adder FR5(.A(A[11:8]), .B(B[11:8]), .Cin(1'b1), .Cout(c1[2]),.S(s1[11:8]));
    four_ripple_adder FR6(.A(A[15:12]), .B(B[15:12]), .Cin(1'b0), .Cout(c0[3]),.S(s0[15:12]));
    four_ripple_adder FR7(.A(A[15:12]), .B(B[15:12]), .Cin(1'b1), .Cout(c1[3]),.S(s1[15:12]));
    
    always_comb begin
		c[0] = c0[0];
		for (int i = 1; i < 4; i++) begin
        c[i] = c0[i] | (c1[i] & c[i-1]);
		end
		CO = c[3];
		Sum[3:0] = s0[3:0];
		for (int i = 0; i < 3; i++) begin
        unique case (c[i])
            1'b0: Sum[(i+1)*4 +: 4] = s0[(i+1)*4 +: 4];
            1'b1: Sum[(i+1)*4 +: 4] = s1[(i+1)*4 +: 4];
            default: Sum[(i+1)*4 +: 4] = 4'bxxxx;
        endcase
		end
	end

     
endmodule

module four_ripple_adder
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