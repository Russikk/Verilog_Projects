module mux2in1_1(i_dat0, i_dat1, i_control, o_dat);

parameter WIDTH = 5;

input   [WIDTH-1:0]   i_dat0, i_dat1; 
input                 i_control;
output  [WIDTH-1:0]   o_dat;


assign o_dat = i_control ? i_dat1 : i_dat0;


endmodule
