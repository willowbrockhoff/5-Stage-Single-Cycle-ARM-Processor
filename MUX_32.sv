module MUX_32(
	input logic select,
	input logic [31:0] zero, one,
	output logic [31:0] out
);
	assign out = select ? one : zero;
endmodule