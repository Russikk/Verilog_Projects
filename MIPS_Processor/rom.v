module rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
	input [(ADDR_WIDTH-1):0] i_addr,
	output [(DATA_WIDTH-1):0] o_romdata
);

reg [7:0] memory [1023:0];
   initial  $readmemh("rom_init.dat", memory);
    assign o_romdata = {memory[i_addr], memory[i_addr+1], memory[i_addr+2], memory[i_addr+3]};

endmodule
