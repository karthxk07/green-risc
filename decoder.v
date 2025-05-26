module decoder(input [31:0] instr);

wire is_r_instr,is_i_instr,is_s_instr,is_b_instr,is_u_instr,is_j_instr;
assign is_r_instr = (instr[6:2] == 5'b01100  || instr[6:2]  == 5'b01011 ||  instr[6:2]  == 5'b01110  || instr[6:2]  == 5'b10100) ? 1 : 0;
assign is_i_instr = ((instr[6:2] == 5'b00x && instr[6:2] != 5'b00101) || instr[6:2] == 5'b11001)? 1 : 0;
assign is_s_instr = (instr[6:2] == 5'b0100x) ? 1 : 0;
assign is_b_instr = (instr[6:2] == 5'b11000)? 1 : 0;
assign is_u_instr = (instr[6:2] ==5'b0x101)? 1 : 0;
assign is_j_instr = (instr[6:2] == 5'b11011)? 1 : 0;



endmodule