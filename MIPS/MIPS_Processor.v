module MIPS_Processor (clk, i_rst);
input clk;
input i_rst;

wire [31:0] rom_data;
wire [31:0] pc_out;
wire [31:0] o_signExtend;
wire [31:0] regFile_o_rdata2;
wire [31:0] alu_result;
wire [31:0] adder_result;

pc pc(
	.i_clk(clk),
	.i_rst_n(i_rst),
	.i_pc(mux.o_dat),
	.o_pc(pc_out)

);
adder adder(
	.i_op1(pc_out),
	.o_result(adder_result)

);

mux2in1 mux(
	.i_dat0(adder_result),
	.i_dat1(NPC.AddrNextPC),
	.i_control(NPC.PCScr),
	.o_dat(pc.i_pc)

);
Next_PC NPC(
	.IncPC(adder_result),
	.Imm26(rom_data[25:0]),
	.Zero(alu.o_zf),
	.J(control.o_jump),
	.BNE(control.o_bne), 
	.BEQ(control.o_branch),
	.PCScr(mux.i_control),
	.AddrNextPC(mux.i_dat1)

);
rom rom(
	.i_addr(pc_out),
	.o_romdata(rom_data)
);
regFile regFile(
	.i_clk(clk),
	.i_raddr1(rom_data[25:21]),
	.i_raddr2(rom_data[20:16]),
	.i_waddr(mux1.o_dat),
	.i_wdata(mux3.o_dat),
	.i_we(control.o_regWrite),
	.o_rdata1(alu.i_op1),
	.o_rdata2(regFile_o_rdata2)


);
control control(
	.i_instrCode(rom_data[31:26]),
	.o_regDst(mux1.i_control),
	.o_jump(NPC.J),
	.o_branch(NPC.BEQ),
	.o_memToReg(mux3.i_control),
	.o_aluOp(aluctrl.i_aluOp),
	.o_memWrite(ram.i_we),
	.o_aluSrc(mux2.i_control),
	.o_regWrite(regFile.i_we),
	.o_extOp(signExtend.en),
	.o_bne(NPC.BNE)


);
mux2in1_1 mux1(
	.i_dat0(rom_data[20:16]),
	.i_dat1(rom_data[15:11]),
	.i_control(control.o_regDst),
	.o_dat(regFile.i_waddr)

);
signExtend signExtend(
	.i_data(rom_data[15:0]),
	.en(control.o_extOp),
	.o_data(o_signExtend)


);
mux2in1 mux2(
	.i_dat0(regFile_o_rdata2),
	.i_dat1(o_signExtend),
	.i_control(control.o_aluSrc),
	.o_dat(alu.i_op2)

);
alu alu(
	.i_op1(regFile.o_rdata1),
	.i_op2(mux2.o_dat),
	.i_control(aluctrl.o_aluControl),
	.o_result(alu_result),
	.o_zf(NPC.Zero)

);
aluControl aluctrl(
	.i_aluOp(control.o_aluOp),
	.i_func(o_signExtend[5:0]),
	.o_aluControl(alu.i_control)

);
ram ram(
	.i_clk(clk),
	.i_addr(alu_result),
	.i_data(regFile_o_rdata2),
	.i_we(control.o_memWrite),
	.o_ramdata(mux3.i_dat1)

);



mux2in1 mux3(
	.i_dat0(alu_result),
	.i_dat1(ram.o_ramdata),
	.i_control(control.o_memToReg),
	.o_dat(regFile.i_wdata)

);





endmodule
