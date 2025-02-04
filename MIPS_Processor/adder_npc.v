module Adder_NPC (
	i_value1,
	i_value2,
	
	o_zero

);

input [31:0] i_value1;
input [31:0] i_value2;

output reg o_zero;
always @* begin
if (i_value1 == i_value2) begin
                o_zero = 1;
           end else begin
                o_zero = 0;
        end
end
endmodule
