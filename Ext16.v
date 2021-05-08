//用于ori指令的immediate无符号扩展，beq指令的immediate符号扩展以及lw/sw中offset的符号扩展
module Ext16(
    input [15:0] imm16,
    input sign_ext,
    output reg [31:0] imm32
    );
    

    always @(*) begin
        if(sign_ext==1&&imm16[15]==1)
        begin 
            imm32[31:0]=32'hffffffff;
            imm32[15:0]=imm16[15:0];
        end
        else
        begin
            imm32[31:0]=32'h00000000;
            imm32[15:0]=imm16[15:0];
        end
    end
endmodule