module alu(
    input   [31:0] i_op1, i_op2,
    input   [3:0]  i_control,
    output  [31:0] o_result,
    output         o_zf
);

localparam AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010;
localparam SUB = 4'b0110, SOLT = 4'b0111, NOR = 4'b1100;


reg [31:0] result;
always @* begin
    case(i_control)
        AND: result = i_op1 & i_op2;
        OR: result = i_op1 | i_op2;
        ADD: result = i_op1 + i_op2;
        SUB: result = i_op1 - i_op2;
        SOLT: begin
            if (i_op1 < i_op2)
                result = 1;
            else
                result = 0;
        end
        NOR: result = ~(i_op1 | i_op2);
        default: result = 0;
    endcase
end

    assign o_result = result;
    assign o_zf = (o_result == 32'h0) ? 1 : 0;


endmodule

