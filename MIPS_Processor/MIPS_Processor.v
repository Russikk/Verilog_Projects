module MIPS_Processor (clk, i_rst);
input clk;
input i_rst;


wire [31:0] rom_data;
wire [31:0] pc_out;
wire [31:0] o_signExtend;
wire [31:0] adder_result;
wire [31:0] nfnksenfksng;
wire [31:0]	o_Aoperand;

wire ex_control_o_regWrite;
wire MEM_control_o_regWrite;
wire WB_control_o_regWrite;

wire [31:0] MUX_1_out;
wire [31:0] MUX_2_out;
wire PCScr_NPC;

wire [31:0] target_floor_from_ram;
wire [31:0] current_floor_from_ram;


Elevator Elevator(
       .clk(clk),                    
       .rst(i_rst),                     
       .target_floor(target_floor_from_ram[2:0]),      
       .current_floor(current_floor_from_ram[2:0]),     
       .state(),             
       .direction(),         
       .door_open()                
);


alu alu(
	.i_op1(o_Aoperand),
	.i_op2(mux2.o_dat),
	.i_control(EX_control.o_aluCtrl),
	.o_result(nfnksenfksng)
	

);
///////////////////////////////////  IF_ID  
wire [31:0] o_instruction;
wire [31:0] ID_incrementedPC;
IF_ID_reg IF_ID_INST(
		.i_clk(clk),
		.i_reset(PCScr_NPC),
		//.i_reset(0),
    		//.IF_incrementedPC(adder_result),
    		.IF_instruction(rom_data),    
    		//.ID_incrementedPC(ID_incrementedPC),
    		.ID_instruction(o_instruction)		
		);


/////////////////////////////////    ID_EX
wire	[31:0]	o_incrementedPC;
wire	[25:0]	o_imm16;

wire	[31:0]	o_Boperand;
wire    [4:0]   EX_o_rd2;
ID_EX_reg ID_EX_INST(
	        .i_clk(clk),		
		//.ID_incrementedPC(ID_incrementedPC),
		.ID_imm16(o_instruction[25:0]),
		.ID_Aoperand(MUX_1_out),
		.ID_Boperand(MUX_2_out),
		.ID_rd2(mux1.o_dat),
	
		//.EX_incrementedPC(o_incrementedPC),
		.EX_imm16(o_imm16),
		.EX_Aoperand(o_Aoperand),
		.EX_o_rd2(EX_o_rd2), 
		.EX_Boperand(o_Boperand)
		);


//////////////////////////////////    EX_MEM
wire [31:0]  o_MEM_aluResult;
wire [31:0]  o_MEM_D;
wire [4:0]   MEM_o_rd3;
EX_MEM_reg EX_MEM_INST (
                .i_clk(clk),
    		.EX_aluResult(nfnksenfksng),
    		.EX_D(o_Boperand),
		.EX_rd3(EX_o_rd2),

		.MEM_aluResult(o_MEM_aluResult),
		.MEM_D(o_MEM_D),
		.MEM_o_rd3(MEM_o_rd3)
);
////////////////////////////////   MEM_WB
wire [31:0] MEM_WBdata;
wire [31:0] o_WBdata;
wire [4:0]  WB_o_rd4;
MEM_WB_reg MEM_WB_INST(
		.i_clk(clk),
		.MEM_WBdata(MEM_WBdata),
		.MEM_rd4(MEM_o_rd3),
		.WB_o_rd4(WB_o_rd4),
		.WBdata(o_WBdata)
		);



////// MUX 4 in 1 (1)
mux4in1 mux4in1_1(
		.i_data0(regFile.o_rdata1), 
		.i_data1(nfnksenfksng),
		.i_data2(MEM_WBdata), 
		.i_data3(o_WBdata), 
		.i_control(hazard_and_forwarding.o_ForwardA), 
		.o_data(MUX_1_out)
		);
    	
////// MUX 4 in 1 (2)
mux4in1 mux4in1_2(
		.i_data0(regFile.o_rdata2), 
		.i_data1(nfnksenfksng),
		.i_data2(MEM_WBdata), 
		.i_data3(o_WBdata), 
		.i_control(hazard_and_forwarding.o_ForwardB), 
		.o_data(MUX_2_out)
		);
	

Hazard_and_forwarding hazard_and_forwarding(
		.i_rs(o_instruction[25:21]),
		.i_rt(o_instruction[20:16]),

		.i_o_rd2(EX_o_rd2),
		.i_o_rd3(MEM_o_rd3),
		.i_o_rd4(WB_o_rd4),

		.i_wb_o_regWrite(WB_control_o_regWrite),
		.i_mem_o_regWrite(MEM_control_o_regWrite),
		.i_ex_o_regWrite(ex_control_o_regWrite),

		.o_ForwardA(mux4in1_1.i_control),
		.o_ForwardB(mux4in1_2.i_control)
);



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

rom rom(
	.i_addr(pc_out),
	.o_romdata(rom_data)
);

regFile regFile(
	.i_clk(clk),
	.i_raddr1(o_instruction[25:21]),
	.i_raddr2(o_instruction[20:16]),
	.i_waddr(WB_o_rd4),
	.i_wdata(o_WBdata),
	.i_we(WB_control_o_regWrite),
	.o_rdata1(mux4in1_1.i_data0),
	.o_rdata2(mux4in1_2.i_data0)


);

mux2in1_1 mux1(
	.i_dat0(o_instruction[20:16]),
	.i_dat1(o_instruction[15:11]),
	.i_control(control.o_regDst),
	.o_dat(ID_EX_INST.ID_rd2)

);

Next_PC NPC(
	.IncPC(pc_out),
	.Imm26(o_instruction[25:0]),
	.Zero(adder_NPC.o_zero),
	.J(control.o_jump),
	.BNE(control.o_bne), 
	.BEQ(control.o_branch),
	.PCScr(PCScr_NPC),
	.AddrNextPC(mux.i_dat1)

);

Adder_NPC adder_NPC(
	.i_value1(MUX_1_out),
	.i_value2(MUX_2_out),
	
	.o_zero(NPC.Zero)

);

signExtend signExtend(
	.i_data(o_imm16[15:0]),
	.en(EX_control.o_extOp),
	.o_data(o_signExtend)


);
mux2in1 mux2(
	.i_dat0(o_Boperand),
	.i_dat1(o_signExtend),
	.i_control(EX_control.o_aluSrc),
	.o_dat(alu.i_op2)

);






mux2in1 mux(
	.i_dat0(adder_result),
	.i_dat1(NPC.AddrNextPC),
	.i_control(PCScr_NPC),
	.o_dat(pc.i_pc)

);


aluControl aluctrl(
	.i_aluOp(control.o_aluOp),
	.i_func(o_instruction[5:0]),
	.o_aluControl(EX_control.i_aluCtrl)

);


control control(
	.i_instrCode(o_instruction[31:26]),
	.o_regDst(mux1.i_control),
	.o_jump(NPC.J),
	.o_branch(NPC.BEQ),
	.o_memToReg(EX_control.i_memToReg),
	.o_aluOp(aluctrl.i_aluOp),
	.o_memWrite(EX_control.i_memWrite),
	.o_aluSrc(EX_control.i_aluSrc),
	.o_regWrite(EX_control.i_regWrite),
	.o_extOp(EX_control.i_extOp),
	.o_bne(NPC.BNE)


);
EX_control EX_control(
		.i_clk(clk),

		.i_aluCtrl(aluctrl.o_aluControl),

		//.i_jump(control.o_jump), 
                //.i_branch(control.o_branch),
                .i_memToReg(control.o_memToReg),
                .i_memWrite(control.o_memWrite),
                .i_aluSrc(control.o_aluSrc),
                .i_regWrite(control.o_regWrite),
	        .i_extOp(control.o_extOp),
                .i_memRead(control.o_memRead),
	        //.i_bne(control.o_bne),

		//.o_jump(NPC.J),
		.o_aluCtrl(alu.i_control),
                //.o_branch(NPC.BEQ),
                .o_aluSrc(mux2.i_control),
	        .o_extOp(signExtend.en),
	        //.o_bne(NPC.BNE),
		

		.o_memToReg(MEM_control.i_memToReg),
		.o_memWrite(MEM_control.i_memWrite),
		.o_regWrite(ex_control_o_regWrite),
		.o_memRead(MEM_control.i_memRead)


);


MEM_control  MEM_control(
		.i_clk(clk),

		.i_memToReg(EX_control.o_memToReg),
		.i_memWrite(EX_control.o_memWrite),
		.i_regWrite(ex_control_o_regWrite),
		.i_memRead(EX_control.o_memRead),

   		.o_memToReg(mux3.i_control),
    		.o_memWrite(ram.i_we),

		.o_regWrite(MEM_control_o_regWrite)
);

WB_control WB_control(
		.i_clk(clk),
		.i_regWrite(MEM_control_o_regWrite),
		.o_regWrite(WB_control_o_regWrite)
);




ram ram(
	.i_clk(clk),
	.i_addr(o_MEM_aluResult),
	.i_data(o_MEM_D),
	.i_we(MEM_control.o_memWrite),
	.o_ramdata(mux3.i_dat1),
	.o_reg_1(target_floor_from_ram),
	.o_reg_2(current_floor_from_ram),
	.o_reg_3(),
	.done()
	//.o_data(ram_to_morse),
	//.en(MorseCodeEncoder.load)

);



mux2in1 mux3(
	.i_dat0(o_MEM_aluResult),
	.i_dat1(ram.o_ramdata),
	.i_control(MEM_control.o_memToReg),
	.o_dat(MEM_WBdata)

);





endmodule
