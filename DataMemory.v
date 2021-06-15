module DataMemory(
    input clk,
    input rst,
    input MemRead,  //读使能信号
    input MemWrite, //写使能信号
    input [31:0] address,   //写入地址
    input [31:0] wdata, //写数据
    output [31:0] rdata //读数据
    );
    reg [7:0] datamemory [0:31];
    always @(posedge clk) begin
    if(rst)
        begin
        datamemory[0]<=0;
        datamemory[1]<=0;
        datamemory[2]<=0;
        datamemory[3]<=0;
        datamemory[4]<=0;
        datamemory[5]<=0;
        datamemory[6]<=0;
        datamemory[7]<=0;
        datamemory[8]<=0;
        datamemory[9]<=0;
        datamemory[10]<=0;
        datamemory[11]<=0;
        datamemory[12]<=0;
        datamemory[13]<=0;
        datamemory[14]<=0;
        datamemory[15]<=0;
        datamemory[16]<=0;
        datamemory[17]<=0;
        datamemory[18]<=0;
        datamemory[19]<=0;
        datamemory[20]<=0;
        datamemory[21]<=0;
        datamemory[22]<=0;
        datamemory[23]<=0;
        datamemory[24]<=0;
        datamemory[25]<=0;
        datamemory[26]<=0;
        datamemory[27]<=0;
        datamemory[28]<=0;
        datamemory[29]<=0;
        datamemory[30]<=0;
        datamemory[31]<=0;
        end
    end
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
