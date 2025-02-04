module EX_control(
		i_clk,
		
		i_aluCtrl,

		i_jump, 
                i_branch,
                i_memToReg,
                i_aluOp,
                i_memWrite,
                i_aluSrc,
                i_regWrite,
	        i_extOp,
                i_memRead,
	        i_bne,

		o_aluCtrl,

		o_jump, 
                o_branch,
                o_memToReg,
                o_aluOp,
                o_memWrite,
                o_aluSrc,
                o_regWrite,
	        o_extOp,
                o_memRead,
	        o_bne
);

input            i_clk;

input            i_jump; 
input            i_branch;
input            i_bne;
input            i_memToReg;
input    [1:0]   i_aluOp;
input            i_memWrite;
input            i_aluSrc;
input            i_regWrite;
input            i_extOp;
input            i_memRead;
input     [3:0]      i_aluCtrl;

output   reg    o_jump; 
output   reg    o_branch;
output   reg    o_bne;
output   reg    o_memToReg;
output   reg  [1:0]   o_aluOp;
output   reg    o_memWrite;
output   reg    o_aluSrc;
output   reg    o_regWrite;
output   reg    o_extOp;
output   reg    o_memRead;
output   reg  [3:0]  o_aluCtrl;
always @(posedge i_clk) begin
	o_jump <= i_jump;
	o_branch <= i_branch;
	o_memToReg <= i_memToReg;
	o_aluOp <= i_aluOp;
	o_memWrite <= i_memWrite;
	o_aluSrc <= i_aluSrc;
	o_regWrite <= i_regWrite;
	o_extOp <= i_extOp;
	o_memRead <= i_memRead;
	o_bne <= i_bne;
	o_aluCtrl <= i_aluCtrl;

end
endmodule
