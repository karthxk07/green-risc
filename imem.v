module imem (input [31:0] addr , output [31:0] data);
	
	reg [31:0] mem [999:0] ;  
	assign data = mem[addr];

endmodule