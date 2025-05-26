module pc(input [31:0] next_pc , input reset, output reg [31:0] pc);
	
	
	always @(negedge reset) begin
		pc <= 0;
	end
		

endmodule