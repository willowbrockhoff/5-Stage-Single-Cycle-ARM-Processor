module RegFile(
	input logic clk, RegWrite,
	input logic [3:0] RA1, RA2, A3,
	input logic [31:0] WD3, R15,
	output logic [31:0] RD1, RD2 
);
	reg [31:0] regfile [0:15];
	
	assign RD1 = (RA1 == 4'd15) ? R15 : regfile[RA1];
	assign RD2 = (RA2 == 4'd15) ? R15 : regfile[RA2];

	always_ff @(posedge clk) begin
		if(RegWrite)
			regfile[A3] <= WD3;
	end
endmodule