module MEM_control(
		i_clk,

		i_memToReg,
		i_memWrite,
		i_regWrite,
		i_memRead,

   		o_memToReg,
    		o_memWrite,
    		o_regWrite,
    		o_memRead
);

input     i_clk;
input     i_memToReg;
input     i_memWrite;
input     i_regWrite;
input     i_memRead;

output   reg  o_memToReg;
output   reg  o_memWrite;
output   reg o_regWrite;
output   reg o_memRead;

always @(posedge i_clk) begin

o_memToReg <= i_memToReg;
o_memWrite <= i_memWrite;
o_regWrite <= i_regWrite;
o_memRead <= i_memRead;

end
endmodule
