module ID_EX_reg (i_clk,	
		ID_incrementedPC,
		ID_imm16,
		ID_Aoperand,
		ID_Boperand,
		ID_rd2,
		
		EX_incrementedPC,
		EX_imm16,
		EX_Aoperand,
		EX_Boperand,
		EX_o_rd2,
		);
input i_clk;
input   [4:0]   ID_rd2;
input	[31:0]	ID_incrementedPC;
input	[25:0]	ID_imm16;
input	[31:0]	ID_Aoperand;
input	[31:0]	ID_Boperand;

output reg [31:0] EX_incrementedPC;
output reg [25:0] EX_imm16;
output reg [31:0] EX_Aoperand;
output reg [31:0] EX_Boperand;
output reg [4:0]  EX_o_rd2;

always @(posedge i_clk) begin
	EX_incrementedPC <= ID_incrementedPC;
	EX_imm16 <= ID_imm16;
	EX_Aoperand <= ID_Aoperand;
	EX_Boperand <= ID_Boperand;
	EX_o_rd2 <= ID_rd2;
	
end

endmodule
