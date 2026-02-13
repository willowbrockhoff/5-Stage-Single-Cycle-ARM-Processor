module MUX_4(
	input logic RegSrc,
	input logic [3:0] one, zero,
	output logic [3:0] out
);
	assign out = RegSrc ? one : zero; 
endmodule