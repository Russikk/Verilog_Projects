module top (
    input  logic       i_clk,
    input  logic       i_rst_n,
    input  logic       i_enable,
    
    output logic [2:0] count_low,
    output logic [2:0] count_high
);

    logic w_rst_n_sync;
    logic w_enable_sync;

    rst_sync rst_sync (
        .i_clk    (i_clk),
        .i_rst_n  (i_rst_n),
        .o_rst_n  (w_rst_n_sync)
    );

    data_sync data_sync (
        .i_clk    (i_clk),
        .i_rst_n  (w_rst_n_sync), 
        .i_data   (i_enable), 
        .o_data   (w_enable_sync)
    );

    octal_counter_top counter (
        .i_clk        (i_clk),
        .i_rst_n      (w_rst_n_sync),
        .i_enable     (w_enable_sync),
        
        .count_low    (count_low),
        .count_high   (count_high)
    );

endmodule
