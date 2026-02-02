class transaction;
    rand bit i_enable;
    rand bit i_rst_n;

    function void display(string name);
        $display("[%s] i_enable=%b, i_rst_n=%b", name, i_enable, i_rst_n);
    endfunction
endclass
