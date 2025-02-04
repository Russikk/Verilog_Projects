module adder(i_op1, o_result);
input [31:0] i_op1;
output [31:0] o_result;


assign o_result = i_op1 + 4;

endmodule 
