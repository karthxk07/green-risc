module greenrisc(input clk, input flash, input [7:0] data, input  [13:0] addr , input reset);
	
	//pc logic
	wire [31:0] next_pc, pc;
	pc pc1(.next_pc(next_pc) , .reset(reset), .pc(pc));
	assign next_pc = pc+1;
	
	//iMem logic
	wire [31:0] idata;
	imem imem1(.addr(pc), .data(idata));
	
	//decoder logic
	wire rs1,rs2,rd, imm;
	wire [10:0] dec_bits;
	decoder decoder1(.instr(idata), .rs1(rs1), .rs2(rs2) , .rd(rd), .dec_bits(dec_bits), .imm(imm));
	
	reg is_beq, is_bne, is_blt, is_bge, is_bltu, is_bgeu, is_addi, is_add; 
	always @(*) begin
		is_beq = dec_bits[9:0] == 10'b000_1100011;
		is_bne = dec_bits[9:0] == 10'b001_1100011;
		is_blt = dec_bits[9:0] == 10'b100_1100011;
		is_bge = dec_bits[9:0] == 10'b101_1100011;
		is_bltu = dec_bits[9:0] == 10'b110_1100011;
		is_bgeu = dec_bits[9:0] == 10'b111_1100011;
		is_addi = dec_bits[9:0] == 10'b000_0010011;
		is_add = dec_bits[10:0] == 10'b0_000_0110011;
	end
	
endmodule