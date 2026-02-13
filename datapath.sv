module datapath (
    input  logic clk,
    input  logic reset,

    // Control signals
    input  logic RegWrite,
    input  logic MemWrite,
    input  logic ALUSrc,
    input  logic MemtoReg,
    input  logic [1:0]  RegSrc,
    input  logic [1:0]  ImmSrc,
    input  logic [3:0]  ALUControl,
    input  logic PCSrc,

    // To controller & top modules
    output logic [31:0] Instr,
    output logic [3:0]  ALUFlags,  
    output logic [31:0] ALUResult,
    output logic [31:0] WriteData,
    output logic [31:0] ReadData
);

    // Internal wires
    logic [31:0] PC;
    logic [31:0] PCPlus4;
    logic [31:0] BranchAddress;
    logic [31:0] RD1, RD2;
    logic [31:0] ExtImm;
    logic [31:0] PCPlus8;
    logic [31:0] SrcB;
    logic [31:0] Result;            
    logic [3:0]  ALUFlags_next;

    // Instruction fetch 
    Instruction_Fetch IF (
        .clk          (clk),
        .reset        (reset),
        .PCSrc        (PCSrc),
        .BranchAddress(BranchAddress),
        .PC           (PC),
        .Inst         (Instr),
        .PCPlus4      (PCPlus4)
    );

    // Instruction decode & register file
    Instruction_Decode ID (
        .clk     (clk),
        .reset   (reset),
        .RegWrite(RegWrite),
        .ALUSrc  (ALUSrc),
        .RegSrc  (RegSrc),
        .ImmSrc  (ImmSrc),
        .Result  (Result),
        .PCPlus4 (PCPlus4),
        .Inst    (Instr),
        .RD1     (RD1),
        .RD2     (RD2),
        .ExtImm  (ExtImm),
        .PCPlus8 (PCPlus8),
        .SrcB    (SrcB)
    );

    assign WriteData = RD2;

    ALU alu (
        .ALUControl(ALUControl),
        .SrcA      (RD1),
        .SrcB      (SrcB),
        .ALUFlags  (ALUFlags_next),
        .ALUResult (ALUResult)
    );

    Condition_Code_Register ccr (
        .clk       (clk),
        .reset     (reset),
        .next_flags(ALUFlags_next),
        .ALUFlags  (ALUFlags)
    );

    DataMemory dmem (
        .clk        (clk),
        .reset      (reset),
        .WriteEnable(MemWrite),
        .ALUResult  (ALUResult),
        .WriteData  (WriteData),
        .ReadData   (ReadData)
    );

    assign BranchAddress = ALUResult;

   	MUX_32 MemToRegMux(
		.select(MemtoReg),
		.one(ReadData),
		.zero(ALUResult),
		.out(Result)
	);

endmodule