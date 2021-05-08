//beq指令将immediate左移两位后进行符号扩展
module Ext18(
    input [17:0] imm18,
    output reg [31:0] imm32
    );

    always @(*) begin
        if(imm18[17]==1)
        begin
            imm32[31:0]=32'hffffffff;
            imm32[17:0]=imm18[17:0];
        end
        else
        begin
            imm32[31:0]=32'h11111111;
            imm32[17:0]=imm18[17:0];
        end
    end
endmodule