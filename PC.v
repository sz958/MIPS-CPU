module PC (clk,pc,PC);
    input clk;
    input [31:0] pc;
    output [31:0] PC;
    reg [31:0] PC;
    always @(posedge clk) begin
        PC<=pc;
    end
endmodule //PC