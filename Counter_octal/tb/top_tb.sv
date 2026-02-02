`timescale 1ns/1ps

`include "counter_if.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "scoreboar.sv"
`include "environment.sv"

module tb_top;
    bit clk;
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    counter_if vif(clk);

    top dut (
        .i_clk      (clk),
        .i_rst_n    (vif.i_rst_n),
        .i_enable   (vif.i_enable),
        .count_low  (vif.o_dut_low), 
        .count_high (vif.o_dut_high)
    );

    assign vif.mon_enable = dut.w_enable_sync; 
    assign vif.mon_rst_n  = dut.w_rst_n_sync;  

    environment env;

    initial begin
        env = new(vif);
        env.run();
    end
endmodule
