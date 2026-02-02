class scoreboard;
    virtual counter_if vif;
    
    logic [2:0] exp_low;
    logic [2:0] exp_high;

    bit recording_active = 0; 

    int checked_cycles = 0;
    int errors = 0;
    int stats_en_1 = 0;
    int stats_en_0 = 0;
    int stats_rst  = 0; 

    function new(virtual counter_if vif);
        this.vif = vif;
        this.exp_low = 0; 
        this.exp_high = 0;
    endfunction

    function void start_input_recording();
        recording_active = 1;
        $display("[SCO] Recording STARTED. Ignoring initialization cycles.");
    endfunction

    function void stop_input_recording();
        recording_active = 0;
        $display("[SCO] Recording STOPPED.");
    endfunction

    function void calculate_expected();
        if (exp_high != 3'd7) begin
            if (exp_low != 3'd7) begin
                exp_low = exp_low + 1;
            end else begin
                exp_low  = 0;
                exp_high = exp_high + 1;
            end
        end else begin
             if (exp_low != 3'd7) begin
                 exp_low = exp_low + 1;
             end else begin
                 exp_low  = 0;
                 exp_high = 0;
             end
        end
    endfunction

    function void report();
        $display(" Enable=1 cycles : %0d", stats_en_1);
        $display(" Enable=0 cycles : %0d", stats_en_0);
        $display(" Reset cycles    : %0d", stats_rst); 
        $display("------------------------------------------");
        $display(" Total Checked   : %0d", checked_cycles);
        $display(" Errors Found    : %0d", errors);
        
        if (errors == 0) $display(" STATUS: [ PASSED ]");
        else             $display(" STATUS: [ FAILED ]");
    endfunction

    task run();
        exp_low = 0; 
        exp_high = 0;
        checked_cycles = 0;
        stats_en_1 = 0; 
        stats_en_0 = 0;
        stats_rst  = 0; 
        
        recording_active = 0; 

        forever begin
            @(posedge vif.i_clk); 

            if (!vif.mon_rst_n) begin
                exp_low = 0; 
                exp_high = 0;
                if (recording_active) stats_rst++; 
            end else begin
                if ({vif.o_dut_high, vif.o_dut_low} !== {exp_high, exp_low}) begin
                    if (recording_active) begin
                        errors++;
                        $error("Mismatch! Exp: %d_%d | Got: %d_%d", 
                               exp_high, exp_low, vif.o_dut_high, vif.o_dut_low);
                    end
                end else begin
                end
                
                if (recording_active) checked_cycles++;

                if (vif.mon_enable) begin
                    calculate_expected();
                    if (recording_active) stats_en_1++;
                end else begin
                    if (recording_active) stats_en_0++;
                end
            end
        end
    endtask
endclass
