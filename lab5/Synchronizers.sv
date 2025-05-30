module sync (
	input  logic Clk, d, 
	output logic q
);

always_ff @ (posedge Clk)
begin
	q <= d;
end

endmodule


module sync_r0 (
	input  logic Clk, Reset, d, 
	output logic q
);

always_ff @ (posedge Clk or posedge Reset)
begin
	if (Reset)
		q <= 1'b0;
	else
		q <= d;
end

endmodule

module sync_r1 (
	input  logic Clk, Reset, d, 
	output logic q
);

always_ff @ (posedge Clk or posedge Reset)
begin
	if (Reset)
		q <= 1'b1;
	else
		q <= d;
end

endmodule
