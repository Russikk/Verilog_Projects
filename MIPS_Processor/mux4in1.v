module mux4in1 (i_data0, 
		i_data1,
		i_data2, 
		i_data3, 
		i_control, 
		o_data
		);

parameter WIDTH = 32;
input   [WIDTH-1:0]   i_data0, i_data1, i_data2, i_data3;
input   [1:0]   i_control;
output   [WIDTH-1:0]  o_data; 

assign o_data = (i_control === 2'b00)? i_data0 :
		(i_control === 2'b01)? i_data1 :
		(i_control === 2'b10)? i_data2 :
		(i_control === 2'b11)? i_data3 : 32'b0;

endmodule

