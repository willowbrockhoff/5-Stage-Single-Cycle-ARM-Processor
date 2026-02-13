module SignExtend(
	input logic [23:0] Instr,
	input logic [1:0] ImmSrc,
	output logic [31:0] value
);
	always_comb begin
		case(ImmSrc)
			2'b00: value = {24'b0, Instr[7:0]}; 
			2'b01: value = {20'b0, Instr[11:0]};
			2'b10: value = {{6{Instr[23]}}, Instr, 2'b00};
			default: value = 32'hXXXX_XXXX; 
		endcase
	end
endmodule