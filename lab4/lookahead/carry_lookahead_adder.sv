module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
    logic [4:0] C, P, G; 

    assign C[0] = 1'b0; 
    assign C[1] = C[0] & P[0] | G[0];
    assign C[2] = C[0] & P[0] & P[1] | G[0] & P[1] | G [1];
    assign C[3] = C[0] & P[0] & P[1] & P[2] | G[0] & P[1] & P[2] | G [1] & P[2] | G[2];
    assign CO = C[0] & P[0] & P[1] & P[2] & P[3] | G[0] & P[1] & P[2] & P[3] | G [1] & P[2] & P[3] | G[2] & P[3] | G[3];
    
    fourbit_carry_lookahead_adder AD0(.A(A[3:0]),.B(B[3:0]),.Cin(C[0]),.S(Sum[3:0]),.Cout(),.Pg(P[0]),.Gg(G[0]));
    fourbit_carry_lookahead_adder AD1(.A(A[7:4]),.B(B[7:4]),.Cin(C[1]),.S(Sum[7:4]),.Cout(),.Pg(P[1]),.Gg(G[1]));
    fourbit_carry_lookahead_adder AD2(.A(A[11:8]),.B(B[11:8]),.Cin(C[2]),.S(Sum[11:8]),.Cout(),.Pg(P[2]),.Gg(G[2]));
    fourbit_carry_lookahead_adder AD3(.A(A[15:12]),.B(B[15:12]),.Cin(C[3]),.S(Sum[15:12]),.Cout(),.Pg(P[3]),.Gg(G[3]));
     
endmodule

module fourbit_carry_lookahead_adder
(
    input logic [3:0] A,
    input logic [3:0] B,
    input logic Cin,
    output logic [3:0] S,
    output logic Cout,
    output logic Pg,
    output logic Gg
);
    logic [4:0] C, P, G; 
  
    assign C[0] = Cin;
    assign C[1] = Cin & P[0] | G[0];
    assign C[2] = Cin & P[0] & P[1] | G[0] & P[1] | G [1];
    assign C[3] = Cin & P[0] & P[1] & P[2] | G[0] & P[1] & P[2] | G [1] & P[2] | G[2];
    assign Cout = Cin & P[0] & P[1] & P[2] & P[3] | G[0] & P[1] & P[2] & P[3] | G [1] & P[2] & P[3] | G[2] & P[3] | G[3];
    assign Pg = P[0] & P[1] & P[2] & P[3];
    assign Gg = G[3] | G[2] & P[3] | G[1] & P[3] & P[2] | G[0] & P[3] & P[2] & P[1];
    
    full_adder FA0(.x(A[0]),.y(B[0]),.z(C[0]),.c(),.s(S[0]),.p(P[0]),.g(G[0]));
    full_adder FA1(.x(A[1]),.y(B[1]),.z(C[1]),.c(),.s(S[1]),.p(P[1]),.g(G[1]));
    full_adder FA2(.x(A[2]),.y(B[2]),.z(C[2]),.c(),.s(S[2]),.p(P[2]),.g(G[2]));
    full_adder FA3(.x(A[3]),.y(B[3]),.z(C[3]),.c(),.s(S[3]),.p(P[3]),.g(G[3]));

endmodule

module full_adder
(
		input logic x,y,z, 
		output logic c,s,p,g
);
		assign s=x^y^z;
		assign c=(x&y)|(y&z)|(z&x); 
		assign p=x^y;
		assign g=x&y;
endmodule