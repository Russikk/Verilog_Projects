module Next_PC(PCScr, AddrNextPC, IncPC, Imm26, Zero, J, BNE, BEQ);

input  [31:0] IncPC;
input  [25:0] Imm26;
input Zero, J, BNE, BEQ;

output PCScr;
output [31:0] AddrNextPC;

reg [31:0] o_AddrNextPC;

always @* begin
if (J) begin
  o_AddrNextPC = {IncPC[31:28], Imm26[25:0] , 2'b00};
end else begin
  o_AddrNextPC = IncPC + ({{16{Imm26[15]}}, Imm26[15:0]});
   
end

end

assign AddrNextPC = o_AddrNextPC;
assign PCScr = J | (BEQ & Zero) | (BNE & ~Zero)? 1 : 0; 


endmodule
