`timescale 1ns / 1ps

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