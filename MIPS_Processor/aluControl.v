module aluControl(i_aluOp, i_func, o_aluControl);
 
input       [1:0]   i_aluOp;
input       [5:0]   i_func;
output  reg [3:0]   o_aluControl;

always @* begin 
case(i_aluOp)
2'b00: o_aluControl = 4'b0010; // ADD
2'b01: o_aluControl = 4'b0110; //SUB
2'b10: begin
	case(i_func)
	6'b100000: o_aluControl = 4'b0010; // Add
	6'b100010: o_aluControl = 4'b0110; // sub
	6'b100100: o_aluControl = 4'b0000; // and
	6'b100101: o_aluControl = 4'b0001; // or
	6'b101010: o_aluControl = 4'b0111; // set on less than
	6'b100111: o_aluControl = 4'b1100;

	default: o_aluControl = 4'b0000; 
	endcase 
end
default: o_aluControl = 4'b0000;
endcase
end
  
endmodule