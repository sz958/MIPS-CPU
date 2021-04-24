module ControlUnit (op,MemtoReg,MemWrite,Branch,ALUControl,ALUSrc,RegDst,RegWrite);
    input [5:0] op;
    output MemtoReg;    //选择数据来源
    output MemWrite;    //存储器写使能信号
    output Branch;      //用于生成指令跳转信号
    output [3:0] ALUControl;    
    output ALUSrc;      //ALU操作数来源选择
    output RegDst;      //
    output RegWrite;    //寄存器堆写使能信号

    assign RegDst=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
    assign ALUSrc=(op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0])|(op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0]);
    assign MemtoReg=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
    assign RegWrite=(~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0])|(op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]);
    assign MemRead=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
    
endmodule //ControlUnit