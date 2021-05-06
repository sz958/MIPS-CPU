//用于移位操作，对移位数shamt进行扩充
module Ext5(
    input [4:0] shamt,
    output reg [31:0] shamt32
    );
    always @(shamt) begin
        if(shamt[4]==1)
        begin
            shamt32[31:0]=32'hffffffff;
            shamt32[4:0]=shamt[4:0];
        end
        else
        begin
            shamt32[31:0]=32'h11111111;
            shamt32[4:0]=shamt[4:0];
        end
    end
endmodule