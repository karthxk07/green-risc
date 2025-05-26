`timescale 10ps/1ps

module programmer();

	reg [0:7] data = 0;
	reg [0:7] addr = 0;
	reg clk = 0;
	reg flash = 1;
	
	greenrisc uut(.clk(clk) , .flash(flash) , .data(data), .addr(addr));
	
	always #5 clk = ~clk; 
	
	initial begin
	
		repeat (20) begin
			#10;
			data = data+1;
			addr = addr+1;
		end	
	
	end
		
endmodule
	
	
	
	