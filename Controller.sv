module Controller (
    input  logic clk, reset,
    input  logic [31:0] Instr,
    input  logic [3:0]  ALUFlags, 
    output logic RegWrite, MemWrite, ALUSrc, MemtoReg, PCSrc,
    output logic [1:0]  RegSrc, ImmSrc,
    output logic [3:0]  ALUControl
);

    // Decode fields
    logic [3:0] cond;
    logic [1:0] op;
    logic       funct_imm;   // bit 25
    logic [3:0] funct;       // bits 24:21
    logic       Sbit;        // bit 20

    assign cond = Instr[31:28];
    assign op = Instr[27:26];
    assign funct_imm = Instr[25];
    assign funct = Instr[24:21];
    assign Sbit = Instr[20];

    // ALU flags
    wire N, Z, C, V;
    assign {N, Z, C, V} = ALUFlags;

    // Condition satisfied?
    logic cond_satisfied;

    code_checker cc (
        .cond      (cond),
        .Z         (Z),
        .N         (N),
        .C         (C),
        .V         (V),
        .satisfied (cond_satisfied)
    );

    // local wires for raw control
    logic RegWrite_raw, MemWrite_raw, PCSrc_raw;
    logic [3:0] ALUControl_raw;

    function automatic logic [3:0] decode_alu (input logic [3:0] funct);
        case (funct)
            4'b0000: decode_alu = 4'b0000; // AND
            4'b0001: decode_alu = 4'b0010; // XOR
            4'b0010: decode_alu = 4'b1011; // SUB
            4'b0100: decode_alu = 4'b0011; // ADD
            4'b1100: decode_alu = 4'b0001; // ORR
            default: decode_alu = 4'b0011; // Default (ADD)
        endcase
    endfunction

    always_comb begin
        RegWrite_raw   = 1'b0;
        MemWrite_raw   = 1'b0;
        ALUSrc         = 1'b0;
        MemtoReg       = 1'b0;
        RegSrc         = 2'b00;
        ImmSrc         = 2'b00;
        ALUControl_raw = 4'b0011; // Default (ADD)
        PCSrc_raw      = 1'b0;

        unique case (op)
            //Data processing
            2'b00: begin
                RegWrite_raw   = 1'b1;             // write result
                MemWrite_raw   = 1'b0;
                MemtoReg       = 1'b0;             // write ALUResult
                ALUSrc         = funct_imm;        // send to imm. or register
                RegSrc         = 2'b00;            // normal register usage
                ImmSrc         = 2'b00;            // zero‑ext 8‑bit imm
                ALUControl_raw = decode_alu(funct);
                PCSrc_raw      = 1'b0;
            end
            //Load/Store
            2'b01: begin
                ALUSrc         = 1'b1;             
                ImmSrc         = 2'b01;            // 12‑bit imm
                RegSrc         = 2'b10; 
                ALUControl_raw = 4'b0011;          
                if (Instr[20]) begin               //If LDR (1)
                    RegWrite_raw = 1'b1;
                    MemWrite_raw = 1'b0;
                    MemtoReg     = 1'b1;
                end else begin                     //If STR (0)
                    RegWrite_raw = 1'b0;
                    MemWrite_raw = 1'b1;
                    MemtoReg     = 1'b0; 		   //Write data for str
                end
                PCSrc_raw     = 1'b0;
            end
            //Branch
            2'b10: begin
                RegWrite_raw   = 1'b0;
                MemWrite_raw   = 1'b0;
                MemtoReg       = 1'b0;
                ALUSrc         = 1'b1;            
                // we don't care about RA2 here.
                RegSrc         = 2'b01;            // RA1 = R15, RA2 = Inst[3:0]
                ImmSrc         = 2'b10;            
                ALUControl_raw = 4'b0011;          // PC+8 + offset
                PCSrc_raw      = 1'b1;             
            end
            default: begin
                // Nothing
            end
        endcase
    end

    // if condition fails the instruction does nothing
    always_comb begin
        RegWrite   = RegWrite_raw   & cond_satisfied;
        MemWrite   = MemWrite_raw   & cond_satisfied;
        PCSrc      = PCSrc_raw      & cond_satisfied;
        ALUControl = ALUControl_raw;
    end

endmodule
