module IF_ID_reg (i_clk,
		i_reset,
		IF_incrementedPC,
		IF_instruction,	
		ID_incrementedPC,
		ID_instruction
		);

input i_clk;
input [31:0] IF_incrementedPC;
input [31:0] IF_instruction;
input i_reset;
output reg [31:0] ID_incrementedPC;
output reg [31:0] ID_instruction;

always @(posedge i_clk) begin
	if (i_reset) begin
		ID_instruction <= 32'b0;
	end else begin
       			
			ID_instruction <= IF_instruction;
        		ID_incrementedPC <= IF_incrementedPC;
	end
end
endmodule

