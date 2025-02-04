module EX_MEM_reg (i_clk,
		EX_aluResult,
		EX_D,
		EX_rd3,

		MEM_o_rd3,
		MEM_aluResult,
		MEM_D,
		);
input i_clk;
input	[31:0]	EX_aluResult;
input	[31:0]	EX_D;
input	[4:0]	EX_rd3;

output reg [31:0] MEM_aluResult;
output reg [31:0] MEM_D;
output reg [4:0] MEM_o_rd3;

always @(posedge i_clk) begin
	MEM_aluResult <= EX_aluResult;
	MEM_D <= EX_D;
	MEM_o_rd3 <= EX_rd3;
	
end
endmodule
