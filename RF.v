module RF (clk,RegWrite,rs,rt,WriteReg,WriteData,ReadData1,ReadData2);
    input clk;
    input RegWrite; //写使能信号
    input [4:0] rs; //A1，注释为PPT图中端口名，下同
    input [4:0] rt; //A2
    input [4:0] WriteReg;   //A3
    input [31:0] WriteData; //WD3
    output [31:0] ReadData1;    //RD1
    output [31:0] ReadData2;    //RD2
    reg [31:0] register[0:31];
    //初始化寄存器

    //读寄存器
    assign ReadData1=register[rs];
    assign ReadData2=register[rt];
    //写寄存器
    always @(posedge clk) begin
        if(RegWrite&&WriteReg)
            register[WriteReg]=WriteData;
    end
endmodule //RF