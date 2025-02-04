module Hazard_and_forwarding (
		i_rs,
		i_rt,
		i_o_rd2,
		i_o_rd3,
		i_o_rd4,
		i_wb_o_regWrite,
		i_mem_o_regWrite,
		i_ex_o_regWrite,

		o_ForwardA,
		o_ForwardB
);

input [4:0] i_rs;
input [4:0] i_rt;
input [4:0] i_o_rd2;
input [4:0] i_o_rd3;
input [4:0] i_o_rd4;
input   i_wb_o_regWrite;
input   i_mem_o_regWrite;
input   i_ex_o_regWrite;

output reg [1:0] o_ForwardA;
output reg [1:0] o_ForwardB;

always @* begin
//  ForwardA
    if (i_rs != 0 & i_rs==i_o_rd2 & (i_ex_o_regWrite)) begin
        o_ForwardA = 2'b01;
    end
    else if (i_rs != 0 & i_rs==i_o_rd3 & (i_mem_o_regWrite)) begin
        o_ForwardA = 2'b10; 
    end
    else if (i_rs != 0 & i_rs==i_o_rd4 & (i_wb_o_regWrite)) begin
        o_ForwardA = 2'b11; 
    end
    else begin
        o_ForwardA = 2'b00; 
    end


//  ForwardB

    if (i_rt != 0 & i_rt==i_o_rd2 & (i_ex_o_regWrite)) begin
        o_ForwardB = 2'b01;
    end
    else if (i_rt != 0 & i_rt==i_o_rd3 & (i_mem_o_regWrite)) begin
        o_ForwardB = 2'b10; 
    end
    else if (i_rt != 0 & i_rt==i_o_rd4 & (i_wb_o_regWrite)) begin
        o_ForwardB = 2'b11; 
    end
    else begin
        o_ForwardB = 2'b00; 
    end



end


endmodule
