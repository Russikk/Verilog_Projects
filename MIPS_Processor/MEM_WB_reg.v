module MEM_WB_reg (
		i_clk,
		MEM_WBdata,
		MEM_rd4,

		WBdata,
		WB_o_rd4,
		);
input i_clk;
input	[31:0]	MEM_WBdata;
input	[4:0]	MEM_rd4;

output reg [4:0]	WB_o_rd4;
output reg [31:0]	WBdata;


always @(posedge i_clk) begin
        WBdata <= MEM_WBdata;
	WB_o_rd4 <= MEM_rd4;	
end
endmodule
