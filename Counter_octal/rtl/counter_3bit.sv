module counter_3bit(
    input logic        i_clk,
    input logic        i_rst_n,
    input logic        i_enable,

    output logic [2:0] o_count_ff,
    output logic       o_co
);
logic [2:0] count_next;

always_ff @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        o_count_ff <= 3'b000;
    end else begin
        o_count_ff <= count_next;
    end
end

always_comb begin
    count_next[0] = o_count_ff[0] ^ i_enable;
    count_next[1] = o_count_ff[1] ^ (o_count_ff[0] & i_enable);
    count_next[2] = o_count_ff[2] ^ (o_count_ff[0] & o_count_ff[1] & i_enable);
end

assign o_co = (o_count_ff == 3'b111) && i_enable;

endmodule
