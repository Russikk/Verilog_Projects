module octal_counter_top (
    input  logic       i_clk,
    input  logic       i_rst_n,
    input  logic       i_enable,

    output logic [2:0] count_low,
    output logic [2:0] count_high
);

    logic carry_wire;

    counter_3bit lower_inst (
        .i_clk       (i_clk),
        .i_rst_n     (i_rst_n),
        .i_enable    (i_enable),    
        .o_count_ff  (count_low),
        .o_co        (carry_wire)
    );

    counter_3bit upper_inst (
        .i_clk       (i_clk),
        .i_rst_n     (i_rst_n),
        .i_enable    (carry_wire),
        .o_count_ff  (count_high),
        .o_co        ()    
   );

endmodule
