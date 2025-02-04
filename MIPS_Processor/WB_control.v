module WB_control(
		i_clk,
		i_regWrite,
		o_regWrite
);

input i_clk;
input i_regWrite;

output reg o_regWrite;

always @(posedge i_clk) begin
o_regWrite <= i_regWrite;

end
endmodule
