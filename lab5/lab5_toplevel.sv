module lab5_toplevel (input logic   Clk,     
                                Reset,   
                                ClearA_LoadB,   
                                Run, 
                  input  logic [7:0]  S,     
                  output logic [7:0]  Aval,    
                                Bval,    
                  output logic [6:0]  AhexL,
                                AhexU,
                                BhexL,
                                BhexU,
						output logic  X);				
	 logic Reset_SH, RUN_SH, ClearA_loadB_SH;
	 logic [7:0] A,B;
	 logic [8:0] sum;
	 logic sub,bIN,shift,clear_load,add;
	 assign Aval = A;
	 assign Bval = B;
	 reg_8    registerA (
                        .Clk(Clk),
                        .Reset(clear_load | Reset_SH),
                        .Shift_In(X),
								.Load(add | sub),
								.Shift_En(shift),
								.D(sum[7:0]),
								.Shift_Out(bIN),
								.Data_Out(A));
	 
     reg_8    registerB (
                        .Clk(Clk),
                        .Reset(Reset_SH),
                        .Shift_In(bIN),
								.Load(ClearA_loadB_SH),
								.Shift_En(shift),
								.D(S),
								.Shift_Out(),
								.Data_Out(B));
								
    ripple_adder 	nine_bits_adder (
						
                        .A(A),
                        .B(S),
                        .sub(sub),
                        .Sum(sum));
															

	 D_filp_flop	registerX(
								.Clk(Clk),
                        .Reset(clear_load | Reset_SH),
								.load(add | sub),
								.in(sum[8]),
								.out(X));
	
	 control          control_unit (
                        .clk(Clk),
                        .reset(Reset_SH),
                        .clearA_loadB(ClearA_loadB_SH),
								.run(RUN_SH),
                        .shift(shift),
                        .add(add),
                        .sub(sub),
								.clr_ld(clear_load),
                        .M(B[0]) );
	 
	 
	 
	 HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(BhexL) );
								

	 HexDriver        HexAU (
                        .In0(A[7:4]),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(B[7:4]),
                        .Out0(BhexU) );
								
	  sync button_sync[2:0] (Clk, {~Reset,~ClearA_LoadB,~Run}, {Reset_SH, ClearA_loadB_SH , RUN_SH});
	  
endmodule

module reg_8 (input  logic Clk, Reset, Shift_In, Load, Shift_En,
              input  logic [7:0]  D,
              output logic Shift_Out,
              output logic [7:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) 
			  Data_Out <= 8'h00;
		 else if (Load)
			  Data_Out <= D;
		 else if (Shift_En)
		 begin
			  Data_Out <= { Shift_In, Data_Out[7:1] }; 
	    end
    end
	
    assign Shift_Out = Data_Out[0];

endmodule

module D_filp_flop(Clk, Reset,load,
  in, out);
  input logic Clk;
  input logic Reset;
  input logic load;
  input logic in;
  output logic out;

  always @(posedge Clk or posedge Reset)
  begin
    if (Reset) begin
      out <= 1'b0;
    end 
	 else if(load)
	 begin
      out <= in;
    end
	 else
	 begin
      out <= out;
    end
  end

endmodule 