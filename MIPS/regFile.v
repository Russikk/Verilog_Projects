module regFile(
    input           i_clk, i_we,
    input   [4:0]   i_raddr1, i_raddr2, i_waddr,
    input   [31:0]  i_wdata,
    output   [31:0]  o_rdata1, o_rdata2
);

reg [31:0] registers [31:0]; 

assign o_rdata1 = (i_raddr1)? registers[i_raddr1] : 32'h00000000; 	
assign o_rdata2 = (i_raddr2)? registers[i_raddr2] : 32'h00000000;


always @(posedge i_clk) begin
    if(i_we) begin
	if(i_waddr != 0) 
		registers[i_waddr] <= i_wdata;
        end
    end


endmodule

