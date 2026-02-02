class driver;
    virtual counter_if vif;
    mailbox #(transaction) mbx;
    transaction tr;
    
    function new(virtual counter_if vif, mailbox #(transaction) mbx);
        this.vif = vif;
        this.mbx = mbx;
    endfunction

    task run();
        $display("[DRV] --- Started ---");
        vif.i_enable <= 0;
        vif.i_rst_n  <= 0;
        
        forever begin
            mbx.get(tr); 
            @(posedge vif.i_clk);
            
            vif.i_enable <= tr.i_enable;
            vif.i_rst_n  <= tr.i_rst_n;
        end
    endtask
endclass
