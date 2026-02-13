module DataMemory(
	input logic clk, reset, WriteEnable,
	input logic [31:0] ALUResult, WriteData,
	output logic [31:0] ReadData
);

	logic [31:0] DataMem [0:63];
	logic [5:0] address;

	assign address = ALUResult[7:2];

	always_ff @ (posedge clk) begin
		if(WriteEnable)
			DataMem[address] <= WriteData;
	end

	assign ReadData = DataMem[address];

endmodule