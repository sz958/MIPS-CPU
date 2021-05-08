module DataMemory(
    input clk,
    input MemRead,  //读使能信�?
    input MemWrite, //写使能信�?
    input [31:0] address,   //写入地址
    input [31:0] wdata, //写数�?
    output [31:0] rdata //读数�?
    );
    reg [7:0] datamemory [0:255];
    assign rdata=(MemRead)?datamemory[address]:32'h0;
    always @(posedge clk) begin     
    if(MemWrite) 
        begin
            datamemory[address]<=wdata[31:24];
            datamemory[address+1]<=wdata[23:16];
            datamemory[address+2]<=wdata[15:8];
            datamemory[address+3]<=wdata[7:0];
        end
    end
endmodule