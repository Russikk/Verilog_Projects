module rst_sync(
input logic  i_clk,
input logic  i_rst_n,

output logic o_rst_n
);

logic first_ff;
logic second_ff;

always_ff @(posedge i_clk, negedge i_rst_n)begin
    if(!i_rst_n)begin
        first_ff <= 0;
        second_ff <= 0;
    end else begin
	first_ff <= 1;
        second_ff <= first_ff;
    end

end

assign o_rst_n = second_ff;

endmodule
