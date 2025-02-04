module ram(i_clk, i_addr, i_data, i_we, o_ramdata);
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 8; //32 4-byte words 

input                     i_clk, i_we;
input   [ADDR_WIDTH-1:0]  i_addr;
input   [DATA_WIDTH-1:0]  i_data;
output  [DATA_WIDTH-1:0]  o_ramdata;


reg [DATA_WIDTH-1:0] memory [255:0];

    always @(posedge i_clk) begin
        if (i_we) begin
            memory[i_addr] <= i_data;
        end
    end

    assign o_ramdata = memory[i_addr];

  
endmodule
