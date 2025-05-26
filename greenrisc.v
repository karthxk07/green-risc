module greenrisc(input clk, input flash, input [7:0] data, input  [13:0] addr , input reset);
	
	//pc logic
	wire [31:0] next_pc, pc;
	pc pc1(.next_pc(next_pc) , .reset(reset), .pc(pc));
	assign next_pc = pc+1;
	
	//iMem logic
	wire [31:0] idata;
	imem imem1(.addr(pc), .data(idata));
	
	//decoder logic
	wire rs1,rs2,rd;
	decoder decoder1(.instr(idata));
	
endmodule