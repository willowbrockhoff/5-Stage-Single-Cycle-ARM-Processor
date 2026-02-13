module code_checker ( 
input logic [3:0] cond, 
input logic Z,  N,  C,  V, 
output logic satisfied);

parameter EQ = 4'b0000;
parameter NE = 4'b0001;
parameter CS = 4'b0010;
parameter CC = 4'b0011;
parameter MI = 4'b0100; 
parameter PL = 4'b0101;
parameter VS = 4'b0110;
parameter VC = 4'b0111;
parameter HI = 4'b1000;
parameter LS = 4'b1001;
parameter GE = 4'b1010;
parameter LT = 4'b1011;
parameter GT = 4'b1100;
parameter LE = 4'b1101;
parameter AL = 4'b1110;

always_comb begin
	case(cond)
		EQ: begin
			satisfied = Z; 
		end
		NE: begin
			satisfied = ~Z;
		end
		CS: begin
			satisfied = C;
		end
		CC: begin
			satisfied = ~C;
		end
		MI: begin
			satisfied = N;
		end
		PL: begin
			satisfied = ~N;
		end
		VS: begin
			satisfied = V;
		end
		VC: begin
			satisfied = ~V;
		end
		HI: begin
			satisfied = (~Z & C);
		end
		LS: begin
			satisfied = (Z | ~C);
		end
		GE: begin
			satisfied = ~(N ^ V);
		end
		LT: begin
			satisfied = (N ^ V);
		end
		GT: begin
			satisfied = ~Z & ~(N ^ V);
		end
		LE: begin
			satisfied= Z | (N ^ V);
		end
		AL: begin
			satisfied = 1'b1;
		end
		default: satisfied = 1'b0;
	endcase
end //always_comb
endmodule