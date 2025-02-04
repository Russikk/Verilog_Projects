`timescale 1ns / 1ps

module MIPS_Processor_tb;


  
  reg clk;
  reg i_rst;
  
  

  
  MIPS_Processor dut (
    .clk(clk),
    .i_rst(i_rst)
  );

  
  
  always #5 clk = ~clk;

  
  initial begin
    clk = 0;
    i_rst = 0;
    #5 i_rst = 1; 
    
    
   
    
    
    
    #200 $finish;
  end

endmodule

