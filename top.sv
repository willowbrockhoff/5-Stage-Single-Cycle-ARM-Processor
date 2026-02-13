module top(
    input  logic        clk,
    input  logic        reset,
    output logic        MemWrite,
    output logic [31:0] WriteData,
    output logic [31:0] ReadData,
    output logic [31:0] ALUResult
);
    logic        RegWrite;
    logic        ALUSrc;
    logic        MemtoReg;
    logic [1:0]  RegSrc;
    logic [1:0]  ImmSrc;
    logic [3:0]  ALUControl;
    logic        PCSrc;
    logic [31:0] Instr;
    logic [3:0]  ALUFlags;

    datapath dp(
        .clk       (clk),
        .reset     (reset),
        .RegWrite  (RegWrite),
        .MemWrite  (MemWrite),
        .ALUSrc    (ALUSrc),
        .MemtoReg  (MemtoReg),
        .RegSrc    (RegSrc),
        .ImmSrc    (ImmSrc),
        .ALUControl(ALUControl),
        .PCSrc     (PCSrc),
        .Instr     (Instr),
        .ALUFlags  (ALUFlags),
        .ALUResult (ALUResult),
        .WriteData (WriteData),
        .ReadData  (ReadData)
    );

    Controller ctrl(
        .clk       (clk),
        .reset     (reset),
        .Instr     (Instr),
        .ALUFlags  (ALUFlags),
        .RegWrite  (RegWrite),
        .MemWrite  (MemWrite),
        .ALUSrc    (ALUSrc),
        .MemtoReg  (MemtoReg),
        .RegSrc    (RegSrc),
        .ImmSrc    (ImmSrc),
        .ALUControl(ALUControl),
        .PCSrc     (PCSrc)
    );

endmodule