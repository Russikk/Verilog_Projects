module signExtend(i_data, en, o_data);
input   [15:0]  i_data;
input	en;
output  [31:0]  o_data;

reg [31:0]  data;
always @* begin
if (en) begin
  data = {{16{i_data[15]}}, i_data};
end else begin
  data = {{16{1'b0}}, i_data};
end
end
assign o_data = data;
endmodule