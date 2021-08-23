`timescale 1ns / 1ps

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
            shamt32[31:0]=32'h00000000;
            shamt32[4:0]=shamt[4:0];
        end
    end
endmodule