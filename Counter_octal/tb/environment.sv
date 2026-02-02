class environment;
    generator gen;
    driver    drv;
    scoreboard sco;
    mailbox #(transaction) mbx;
    virtual counter_if vif;

    function new(virtual counter_if vif);
        this.vif = vif;
        mbx = new();
        gen = new(mbx);
        drv = new(vif, mbx);
        sco = new(vif);
    endfunction

    task reset_dut();
        $display("[ENV] ➤ Phase: RESET");
        vif.i_enable = 0;
        vif.i_rst_n  = 0; 
        repeat(5) @(posedge vif.i_clk);
        
        vif.i_rst_n  = 1; 
        repeat(2) @(posedge vif.i_clk); 
        
        $display("[ENV] ➤ DUT is Ready");
    endtask

    task run_main_test();
        $display("[ENV] ➤ Phase: STIMULUS");
        
        sco.start_input_recording(); 
        
        gen.run(); 
        
        wait(gen.done.triggered);
        while (mbx.num() > 0) @(posedge vif.i_clk);
       
    endtask

    task post_test_drain();
        $display("[ENV] ➤ Phase: DRAIN");
        
        sco.stop_input_recording(); 

        repeat(20) @(posedge vif.i_clk);
    endtask

    task run();
        fork
            drv.run();
            sco.run();
        join_none

        reset_dut();       
        run_main_test();   
        post_test_drain(); 
        
        sco.report();
        $stop;
    endtask
endclass
