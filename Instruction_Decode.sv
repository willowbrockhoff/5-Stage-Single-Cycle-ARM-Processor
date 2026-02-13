module Instruction_Decode(
	input logic clk, reset, RegWrite, ALUSrc,
	input logic [1:0] RegSrc, ImmSrc,
	input logic [31:0] Result, PCPlus4, Inst,
	output logic [31:0] RD1, RD2, ExtImm, PCPlus8, SrcB
); 

	logic [3:0] RA1, RA2;
	MUX_4 mux_ra1(.RegSrc(RegSrc[0]), .zero(Inst[19:16]), .one(4'd15), .out(RA1));		// 4 bit MUX
	MUX_4 mux_ra2(.RegSrc(RegSrc[1]), .zero(Inst[3:0]), .one(Inst[15:12]), .out(RA2));	// 4 bit MUX
	SignExtend ext(.Instr(Inst[23:0]), .ImmSrc(ImmSrc), .value(ExtImm));				//Sign extender
	MUX_32 mux_srcb(.select(ALUSrc), .zero(RD2), .one(ExtImm), .out(SrcB));				// 32 bit MUX
	Adder pc_plus8(.in(PCPlus4), .out(PCPlus8)); 										// Adder
	RegFile rf(.clk(clk), .RegWrite(RegWrite), .RA1(RA1), .RA2(RA2), .A3(Inst[15:12]),	
				  .WD3(Result), .R15(PCPlus8), .RD1(RD1), .RD2(RD2));					// Register file
				
endmodule