module reg_8 (input  logic Clk, Reset, Load,
              input  logic [7:0]  D,
              output logic [7:0]  data_out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset)
			  data_out <= 8'h0;
		 else if (Load)
			  data_out <= D;
    end
endmodule

module reg_4 (input  logic Clk, Reset, Load,
              input  logic [3:0]  D,
              output logic [3:0]  data_out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset)
			  data_out <= 4'h0;
		 else if (Load)
			  data_out <= D;
    end
endmodule

module reg_16 (input  logic Clk, Reset, Load,
              input  logic [15:0]  D,
              output logic [15:0]  data_out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) 
			  data_out <= 16'h0;
		 else if (Load)
			  data_out <= D;
    end
endmodule

module eightreg_16 (input logic Clk, Reset, Load,
							input logic [15:0] D,
							input logic [2:0] SR1IN, SR2, DRIN,
							
							output logic [15:0] SR2O, SR1O);
		
		logic [7:0][15:0] regs;
		
		always_ff @ (posedge Clk)
		
			begin
					if(Reset)
						
						begin
						
							regs[0] <= 16'h0;
							regs[1] <= 16'h0;
							regs[2] <= 16'h0;
							regs[3] <= 16'h0;
							regs[4] <= 16'h0;
							regs[5] <= 16'h0;
							regs[6] <= 16'h0;
							regs[7] <= 16'h0;
							
					
						end
						
					else if (Load)
						
						case(DRIN)
							
								3'b000: regs[0] <= D;
								3'b001: regs[1] <= D;
								3'b010: regs[2] <= D;
								3'b011: regs[3] <= D;
								3'b100: regs[4] <= D;
								3'b101: regs[5] <= D;
								3'b110: regs[6] <= D;
								3'b111: regs[7] <= D;
								
								default ;
								
						endcase
						
			end
			
			always_comb
			
			begin
			
						case(SR1IN)
							
								3'b000: SR1O <= regs[0];
								3'b001: SR1O <= regs[1];
								3'b010: SR1O <= regs[2];
								3'b011: SR1O <= regs[3];
								3'b100: SR1O <= regs[4];
								3'b101: SR1O <= regs[5];
								3'b110: SR1O <= regs[6];
								3'b111: SR1O <= regs[7];
								
								default ;
								
						endcase
							
						case(SR2)
							
								3'b000: SR2O <= regs[0];
								3'b001: SR2O <= regs[1];
								3'b010: SR2O <= regs[2];
								3'b011: SR2O <= regs[3];
								3'b100: SR2O <= regs[4];
								3'b101: SR2O <= regs[5];
								3'b110: SR2O <= regs[6];
								3'b111: SR2O <= regs[7];
								
								default ;
								
						endcase
					
			end
		
endmodule	
							

module flip_flop (input  logic Clk, Reset, Load,
              input  logic  D,
              output logic data_out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) 
			  data_out <= 1'b0;
		 else if (Load)
			  data_out <= D;
		 
    end
	

endmodule

module mux_PC(input logic [15:0] A, B, C,
				  input logic [1:0] S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					2'b00:
						Out = A;
					2'b01:
						Out = B;
					2'b10:
						Out = C;
					2'b11:
						Out = 16'h0000;
				endcase
			end
endmodule

module mux_MDR(input logic [15:0] A, B,
				  input logic S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = B;
				endcase
			end
endmodule

module mux_GATES(input logic [15:0] A, B, C, D, //ordering maybe an issue?
				  input logic [3:0] S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					4'b1000:
						Out = A;
					4'b0100:
						Out = B;
					4'b0010:
						Out = C;
					4'b0001:
						Out = D;
					default:
						Out = 16'h0000;
				endcase
			end
endmodule

module mux_ADDR2(input logic [15:0] A, B, C, D,
				  input logic [1:0] S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					2'b00:
						Out = A;
					2'b01:
						Out = B;
					2'b10:
						Out = C;
					2'b11:
						Out = D;
					default:
						Out = 16'h0000;
				endcase
			end
endmodule

module mux_ADDR1(input logic [15:0] A, B,
				  input logic S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = B; 
					default:
						Out = 16'h0000;
				endcase
			end
endmodule

module mux_DR(input logic [2:0] A,
				  input logic S,
				  output logic [2:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = 3'b111;
				endcase
			end
endmodule
module mux_SR1(input logic [2:0] A,B,
				  input logic S,
				  output logic [2:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = B;
				endcase
			end
endmodule
module mux_SR2(input logic [15:0] A,B,
				  input logic S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = B;
				endcase
			end
endmodule

module NZP(input logic Clk, NI, ZI, PI, LD_CC,
				output logic NO, ZO, PO);
		always_ff @ (posedge Clk)
			begin
				 if(LD_CC)
					begin
						NO<=NI;
						ZO<=ZI;
						PO<=PI;
					end
			end
endmodule

module ALU (input logic [15:0] A, B,
				input logic [1:0] ALUK,
				output logic [15:0] dout);
				
				
			always_comb
			
			begin
			
						case(ALUK)
							
								2'b00:
								
										dout = A + B;
										
								2'b01:
								
										dout = A & B;
										
								2'b10:
								
										dout = ~A;
										
								2'b11:
								
										dout = A;
										
						endcase
						
			end
			
			
endmodule 