class generator;
    mailbox #(transaction) mbx;
    transaction tr;
    event done;
    
    int count = 500; 

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task run();
        repeat(count) begin
            tr = new();
            
            if (!tr.randomize() with {
                i_rst_n dist {1 := 98, 0 := 2}; 
            }) $fatal("Gen: Randomization failed");

            mbx.put(tr);
        end
        -> done;
    endtask
endclass
