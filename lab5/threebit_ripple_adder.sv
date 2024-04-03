module threebit_ripple_adder
(
	input logic[2:0] x,
	input logic[2:0] y,
	input logic cin,
	output logic [2:0] s,
	output logic cout
);
	logic c0, c1;
	full_adder fa0(.x(x[0]), .y(y[0]), .cin(cin), .s(s[0]), .cout(c0));
	full_adder fa1(.x(x[1]), .y(y[1]), .cin(c0),  .s(s[1]), .cout(c1));
	full_adder fa2(.x(x[2]), .y(y[2]), .cin(c1),  .s(s[2]), .cout(cout));		

endmodule

