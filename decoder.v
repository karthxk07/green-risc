module decoder(input [31:0] instr, output reg [8:0] rs1, output reg [8:0] rs2, output reg [8:0] rd, output reg [10:0] dec_bits, output reg [31:0] imm);

reg is_r_instr,is_i_instr,is_s_instr,is_b_instr,is_u_instr,is_j_instr;
reg[7:0] opcode, func3, func7;
reg is_rs1_valid, is_rs2_valid, is_rd_valid, is_func3_valid, is_func7_valid;


always @(*) begin
	is_r_instr <= (instr[6:2] == 5'b01100  || instr[6:2]  == 5'b01011 ||  instr[6:2]  == 5'b01110  || instr[6:2]  == 5'b10100) ? 1 : 0;
	is_i_instr <= (instr[6:2] == 5'b00000 ||  instr[6:2] == 5'b00001  ||  instr[6:2] == 5'b00010  ||  instr[6:2] == 5'b00011 ||  instr[6:2] == 5'b00100 ||  instr[6:2] == 5'b00110 ||  instr[6:2] == 5'b00111  || instr[6:2] == 5'b11001)? 1 : 0;
	is_s_instr <= (instr[6:2] == 5'b01000 ||  instr[6:2] == 5'b01001 ) ? 1 : 0;
	is_b_instr <= (instr[6:2] == 5'b11000)? 1 : 0;
	is_u_instr <= (instr[6:2] ==5'b00101 || instr[6:2] ==5'b01101)? 1 : 0;
	is_j_instr <= (instr[6:2] == 5'b11011)? 1 : 0;
end

//extracting fields
always @(*) begin
	rs1[4:0] <= instr[19:15];
	rs2[4:0] <= instr[24:20];
	rd[4:0] <= instr[11:7];
	opcode[6:0] <= instr[6:0];
	func3[2:0] <= instr[14:12];
	func7[6:0] <= instr[31:25];
end

//validity
always @(*) begin
	is_rs1_valid <= is_r_instr || is_i_instr || is_s_instr || is_b_instr;
	is_rs2_valid <= is_r_instr || is_s_instr || is_b_instr;
	is_rd_valid <= is_r_instr || is_i_instr || is_u_instr || is_j_instr;
	is_func3_valid <= is_r_instr || is_i_instr || is_s_instr || is_b_instr;
	is_func7_valid <= is_r_instr;
end 

//immediate value
always @(*) begin
	imm[31:0] = is_i_instr ? {{21{instr[31]}}, instr[30:20]} : 
					is_s_instr ? {{21{instr[31]}}, instr[30:25], instr[11:7]} :
					is_b_instr ? {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8] , 1'b0} :
					is_u_instr ? {instr[31], instr[30:20], instr[19:12], {12{1'b0}}} :
					is_s_instr ? {{12{instr[31]}}, instr[19:12], instr[20], instr[30:25], instr[24:21], 1'b0} :
					32'b0;
end

//decoded bits
always @(*) begin
	dec_bits = {instr[30], func3, opcode};
end

//extracting instr
	

endmodule