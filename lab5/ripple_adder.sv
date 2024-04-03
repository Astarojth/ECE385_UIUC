module ripple_adder
(
    input   logic[7:0]     A,
    input   logic[7:0]     B,
	 input	logic		 		sub,
    output  logic[8:0]     Sum
);

	logic C0, C1, C2, C3, C4;
	logic[8:0] B1;
	logic[8:0] A1;
	assign B1 = B^{8{sub}};
	assign A1 = {A[7],A};
	threebit_ripple_adder FRA0(.x(A1[2:0]),   .y(B1[2:0]),   .cin(sub),  .s(Sum[2:0]),   .cout(C0));
	threebit_ripple_adder FRA1(.x(A1[5:3]),   .y(B1[5:3]),   .cin(C0), .s(Sum[5:3]),   .cout(C1));
	threebit_ripple_adder FRA2(.x(A1[8:6]),   .y({B1[7],B1[7:6]}),   .cin(C1), .s(Sum[8:6]),   .cout(C2)); 
endmodule

