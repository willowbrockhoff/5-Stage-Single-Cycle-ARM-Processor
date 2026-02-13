module testbench();

  logic        clk, reset, MemWrite;
  logic [31:0] WriteData, ReadData, ALUResult;
  
  // Instantiate device to be tested
  top uut(.clk(clk), .reset(reset), .MemWrite(MemWrite), .WriteData(WriteData), .ReadData(ReadData), .ALUResult(ALUResult));
  
  // Initialize test
  initial
    begin
      clk=0; 
		  reset = 1; # 1; reset = 0;
    end

  // Generate clock to sequence tests
  always #2 clk=~clk;

  // Check results
  always @(negedge clk)
    begin
      if(MemWrite && WriteData==32'h2c) begin
        if(ALUResult ==32'h10) begin
          $display("Simulation succeeded");
          #4 $stop;
        end else begin
			    $display("Simulation failed");
          #4 $stop;
			  end
      end
    end
endmodule