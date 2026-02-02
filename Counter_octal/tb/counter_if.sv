interface counter_if(input bit i_clk);
    logic i_rst_n;
    logic i_enable;
    
    logic [2:0] o_dut_low;
    logic [2:0] o_dut_high;

    logic mon_rst_n;  
    logic mon_enable; 
endinterface
