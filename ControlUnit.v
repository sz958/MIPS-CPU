module ControlUnit (
    input [5:0] op,
    input [5:0] funct,
    
    output MemtoReg,    //选择数据来源
    output MemWrite,    //存储器写使能信号
    output [9:0] ALUOp, //ALU运算功能选择
    output ALUSrc1,     //ALU操作数1来源选择
    output ALUSrc2,     //ALU操作数2来源选择
    output RegDst,      //写回操作的数据来源
    output RegWrite,     //寄存器堆写使能信号
    output MemRead,      //数据存储器读使能信号
    output Branch,      //配合ALU零标志输出生成PCSrc
    output Jump,        //跳转标志
    output sign_ext     
        ); 

    //先根据Op和funct确定执行的指令，然后根据执行的指令用到的数据通路确定控制信号
    wire R_type;
    wire add,addu,sub,subu,ori,sll,lw,sw,beq,jal;
    assign R_type=~|op;
    assign add=R_type&funct[5]&~funct[4]&~funct[3]&~funct[2]&~funct[1]&~funct[0];
    assign addu=R_type&funct[5]&~funct[4]&~funct[3]&~funct[2]&~funct[1]&funct[0];
    assign sub=R_type&funct[5]&~funct[4]&~funct[3]&~funct[2]&funct[1]&~funct[0];
    assign subu=R_type&funct[5]&~funct[4]&~funct[3]&~funct[2]&funct[1]&funct[0];
    assign ori=~op[5]&~op[4]&op[3]&op[2]&~op[1]&op[0];
    assign sll=R_type&~funct[5]&~funct[4]&~funct[3]&~funct[2]&~funct[1]&~funct[0];
    assign sw=op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
    assign beq=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
    assign jal=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];

    assign MemtoReg=lw;
    assign MemWrite=sw;
    assign MemRead=lw;
    assign Branch=beq;
    assign ALUSrc1=add|addu|sub|subu|ori|lw|sw|beq;
    assign ALUSrc2=ori|lw|sw;
    assign ALUOp={op,funct};
    assign RegDst=add|addu|sub|subu|sll;
    assign RegWrite=add|addu|sub|subu|ori|sll|lw;
    assign Jump=jal;
    /*
    assign RegDst=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
    assign ALUSrc=(op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0])|(op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0]);
    assign MemtoReg=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
    assign RegWrite=(~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0])|(op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]);
    assign MemRead=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
    */
endmodule //ControlUnit