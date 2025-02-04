`timescale 1ns / 1ps

module ram_tb;

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 5;
    parameter CLK_PERIOD = 5;

    reg i_clk, i_we;
    reg [ADDR_WIDTH-1:0] i_addr;
    reg [DATA_WIDTH-1:0] i_data;
    wire [DATA_WIDTH-1:0] o_ramdata;

    ram uut (
        .i_clk(i_clk),
        .i_addr(i_addr),
        .i_data(i_data),
        .i_we(i_we),
        .o_ramdata(o_ramdata)
    );

    initial begin
        i_clk = 0;
        i_we = 1;
        i_addr = 0;
        i_data = 0;

        #5;
       
        i_addr = 5;
        i_data = 32'h12345678;
        #5;
   
        i_addr = 5;
        #5;

        $display("o_data = %h", o_ramdata);

        $stop;
    end

    always #((CLK_PERIOD)/2) i_clk <= ~i_clk;

endmodule

