module ram(
    input i_clk,
    input i_addr,
    input i_data,
    input i_we,
    input done,
    output o_ramdata,
    output o_reg_1,
    output o_reg_2,
    output o_reg_3
);

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 8; // 32 4-byte words 

output [31:0] o_reg_1;
output [31:0] o_reg_2;
output [31:0] o_reg_3;

output [DATA_WIDTH-1:0] o_ramdata;
input [ADDR_WIDTH-1:0] i_addr;
input [DATA_WIDTH-1:0] i_data;

reg [DATA_WIDTH-1:0] memory [255:0];
reg [DATA_WIDTH-1:0] data_out;

always @(posedge i_clk) begin
    if (i_we) begin
            memory[i_addr >> 2] <= i_data;   
    end
    data_out <= memory[i_addr >> 2];   
end

initial $readmemh("ram_init.dat", memory);
assign o_ramdata = data_out;

assign o_reg_1 = memory[8];
assign o_reg_2 = memory[9];
assign o_reg_3 = memory[10];

endmodule

