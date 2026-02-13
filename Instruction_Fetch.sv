module Instruction_Fetch(
	input logic clk, reset, PCSrc,
	input logic [31:0] BranchAddress,
	output logic [31:0] PC, Inst, PCPlus4
);

	logic [31:0] next_pc;
 
	Program_Counter pc_reg(.clk(clk), .reset(reset), .next_pc(next_pc), .pc(PC));		// PC counter
	Adder pc_adder(.in(PC), .out(PCPlus4));												// Adder
	MUX_32 pc_mux(.select(PCSrc), .zero(PCPlus4), .one(BranchAddress), .out(next_pc));	// 32 bit MUX
	imem pc_imem(.A(PC), .Instr(Inst));													// Instruction memory

endmodule
