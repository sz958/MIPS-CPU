module PC (
    input clk,
    input rst,  //¸´Î»ÐÅºÅ
    input [31:0] pc,
    output reg [31:0] PC
    );

    always @(posedge clk,posedge rst) begin
        if(rst)
        PC<=32'b0;
        else
        PC<=pc;
    end
endmodule //PC