module control(i_instrCode, 
               o_regDst,
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
               
// if {Op_code[31:26], func[5:0]} when input [11:0] i_instrCode; 
//if only Op_code[31:26] - when   input [5:0] i_instrCode; 
 
//input     [11:0]  i_instrCode;
input     [5:0]  i_instrCode; 
output            o_regDst;
output            o_jump; 
output            o_branch;
output            o_bne;
output            o_memToReg;
output    [1:0]   o_aluOp;
output            o_memWrite;
output            o_aluSrc;
output            o_regWrite;
output            o_extOp;
output            o_memRead;

 
parameter R_TYPE = 6'b000000;
parameter ADDI = 6'b001000;
parameter ADDIU = 6'b001001;
parameter SLTI = 6'b001010;
parameter ANDI = 6'b001100;
parameter ORI = 6'b001101;
parameter XORI = 6'b001110;
parameter LW = 6'b100011;
parameter SW = 6'b101011;
parameter BEQ = 6'b000100;
parameter BNE = 6'b000101;
parameter JUMP = 6'b000010;

reg temp_regDst, temp_jump, temp_branch, temp_memToReg, temp_memWrite, temp_aluSrc, temp_regWrite, temp_memRead, temp_extOp, temp_bne;
reg [1:0] temp_aluOp;

always @(*) begin
    case(i_instrCode)
        R_TYPE: begin // R-type 
            temp_regDst = 1;
            temp_jump = 0;
            temp_branch = 0;
            temp_memToReg = 0;
            temp_aluOp = 2'b10; 
            temp_memWrite = 0;
            temp_aluSrc = 0;
            temp_regWrite = 1;
	    temp_memRead = 0;
	    temp_bne = 0;
        end
        ADDI, SLTI: begin // I-type
            temp_regDst = 0;
            temp_jump = 0;
            temp_branch = 0;
            temp_memToReg = 0;
            temp_aluOp = 2'b00; 
            temp_memWrite = 0;
            temp_aluSrc = 1; 
            temp_regWrite = 1;
	    temp_extOp = 0;
	    temp_memRead = 0;
	    temp_bne = 0;
        end
	ANDI, ORI, XORI: begin // I-type
            temp_regDst = 0;
            temp_jump = 0;
            temp_branch = 0;
            temp_memToReg = 0;
            temp_aluOp = 2'b00; 
            temp_memWrite = 0;
            temp_aluSrc = 1; 
            temp_regWrite = 1;
	    temp_extOp = 1;
	    temp_memRead = 0;
	    temp_bne = 0;
        end
	ADDIU: begin
	    temp_regWrite = 1'b1;
	    temp_aluSrc = 1'b1;
	    temp_regDst = 1'b0;
	    temp_aluOp = 2'b00;
	    temp_memToReg = 1'b0;
	    temp_branch = 1'b0;
	    temp_bne = 1'b0;
	    temp_jump = 1'b0;


		end

        LW: begin // Load word
            temp_regDst = 0;
            temp_jump = 0;
            temp_branch = 0;
            temp_memToReg = 1; 
            temp_aluOp = 2'b00;
            temp_memWrite = 0;
            temp_aluSrc = 1;
            temp_regWrite = 1;
	    temp_extOp = 1;
	    temp_memRead = 1;
	    temp_bne = 0;
        end
        SW: begin // Store word
            temp_jump = 0;
            temp_branch = 0;
            temp_aluOp = 2'b00;
            temp_memWrite = 1; 
            temp_aluSrc = 1;
            temp_regWrite = 0;
	    temp_extOp = 1;
	    temp_memRead = 0;
	    temp_bne = 0;
        end
        BEQ: begin // Branch equal
            temp_regDst = 0;
            temp_jump = 0;
            temp_branch = 1; 
            temp_memToReg = 0;
            temp_aluOp = 2'b01; 
            temp_memWrite = 0;
            temp_aluSrc = 0;
            temp_regWrite = 0;
	    temp_extOp = 0;
	    temp_memRead = 0;
	    temp_bne = 0;
        end
	BNE: begin // Branch not equal
            temp_regDst = 0;
            temp_jump = 0;
            temp_branch = 0; 
            temp_memToReg = 0;
            temp_aluOp = 2'b01; 
            temp_memWrite = 0;
            temp_aluSrc = 0;
            temp_regWrite = 0;
	    temp_extOp = 0;
	    temp_memRead = 0;
	    temp_bne = 1;
        end
        JUMP: begin // Jump
            
            temp_regDst = 1'b0;
            temp_jump = 1'b1;
            temp_branch = 1'b0;
            temp_memToReg = 1'b0;
            temp_aluOp = 2'b0;
            temp_memWrite = 1'b0;
            temp_aluSrc = 1'b0;
            temp_regWrite = 1'b0;
	    temp_extOp = 1'b0;
	    temp_memRead = 1'b0;
	    temp_bne = 1'b0;
        end
        default: begin // ?? ?????????????
            temp_regDst = 1'b0;
            temp_jump = 1'b0;
            temp_branch = 1'b0;
            temp_memToReg = 1'b0;
            temp_aluOp = 2'b0;
            temp_memWrite = 1'b0;
            temp_aluSrc = 1'b0;
            temp_regWrite = 1'b0;
	    temp_extOp = 1'b0;
	    temp_memRead = 1'b0;
	    temp_bne = 1'b0;
        end
    endcase
end
assign o_regDst = temp_regDst;
assign o_jump = temp_jump;
assign o_branch = temp_branch;
assign o_memToReg = temp_memToReg;
assign o_aluOp = temp_aluOp;
assign o_memWrite = temp_memWrite;
assign o_aluSrc = temp_aluSrc;
assign o_regWrite = temp_regWrite;
assign o_extOp = temp_extOp;
assign o_memRead = temp_memRead;
assign o_bne = temp_bne;

endmodule