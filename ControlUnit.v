`timescale 1ns / 1ps

module ControlUnit (
    input [5:0] op,
    input [5:0] funct,
    
    output MemtoReg,    //选择数据来源
    output MemWrite,    //存储器写使能信号
    output MemRead,      //数据存储器读使能信号
    output [3:0] ALUOp, //ALU运算功能选择
    output ALUSrc1,     //ALU操作数1来源选择
    output ALUSrc2,     //ALU操作数2来源选择
    output RegDst,      //写回操作的数据来源
    output RegWrite,     //寄存器堆写使能信号
    output Branch,      //配合ALU零标志输出生成PCSrc
    output Jump,        //跳转标志
    output sign_ext     //是否为符号扩展
        ); 

    //先根据Op和funct确定执行的指令，然后根据执行的指令用到的数据通路确定控制信号
    wire R_type;
    wire add,addu,sub,subu,And,Or,Xor,Nor,slt,sltu,sll,srl,sra,sllv,srlv,srav;
    wire addi,addiu,andi,ori,xori,lw,sw,beq,bne;
    wire j;
    assign R_type=~|op;
    //R type
    assign add=R_type&funct[5]&~funct[4]&~funct[3]&~funct[2]&~funct[1]&~funct[0];   //100000
    assign addu=R_type&funct[5]&~funct[4]&~funct[3]&~funct[2]&~funct[1]&funct[0];   //100001
    assign sub=R_type&funct[5]&~funct[4]&~funct[3]&~funct[2]&funct[1]&~funct[0];    //100010
    assign subu=R_type&funct[5]&~funct[4]&~funct[3]&~funct[2]&funct[1]&funct[0];    //100011
    assign And=R_type&funct[5]&~funct[4]&~funct[3]&funct[2]&~funct[1]&~funct[0];    //100100
    assign Or=R_type&funct[5]&~funct[4]&~funct[3]&funct[2]&~funct[1]&funct[0];      //100101
    assign Xor=R_type&funct[5]&~funct[4]&~funct[3]&funct[2]&funct[1]&~funct[0];     //100110
    assign Nor=R_type&funct[5]&~funct[4]&~funct[3]&funct[2]&funct[1]&funct[0];      //100111
    assign slt=R_type&funct[5]&~funct[4]&funct[3]&~funct[2]&funct[1]&~funct[0];     //101010
    assign sltu=R_type&funct[5]&~funct[4]&funct[3]&~funct[2]&funct[1]&funct[0];     //101011
    assign sll=R_type&~funct[5]&~funct[4]&~funct[3]&~funct[2]&~funct[1]&~funct[0];  //000000
    assign srl=R_type&~funct[5]&~funct[4]&~funct[3]&~funct[2]&funct[1]&~funct[0];   //000010
    assign sra=R_type&~funct[5]&~funct[4]&~funct[3]&~funct[2]&funct[1]&funct[0];    //000011
    assign sllv=R_type&~funct[5]&~funct[4]&~funct[3]&funct[2]&~funct[1]&~funct[0];  //000100
    assign srlv=R_type&~funct[5]&~funct[4]&~funct[3]&funct[2]&funct[1]&~funct[0];   //000110
    assign srav=R_type&~funct[5]&~funct[4]&~funct[3]&funct[2]&funct[1]&funct[0];    //000111
    
    //I type
    assign addi=~op[5]&~op[4]&op[3]&~op[2]&~op[1]&~op[0];   //001000
    assign addiu=~op[5]&~op[4]&op[3]&~op[2]&~op[1]&op[0];   //001001
    assign andi=~op[5]&~op[4]&op[3]&op[2]&~op[1]&~op[0];   //001100
    assign ori=~op[5]&~op[4]&op[3]&op[2]&~op[1]&op[0];      //001101
    assign xori=~op[5]&~op[4]&op[3]&op[2]&op[1]&~op[0];     //001110
    assign lw=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];       //100011
    assign sw=op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];        //101011
    assign beq=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];    //000100
    assign bne=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&op[0];     //000101

    //J type
    assign j=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0];     //000010

    assign MemtoReg=lw;
    assign MemWrite=sw;
    assign MemRead=lw;
    assign Branch=beq|bne;
    assign ALUSrc1=add|addu|sub|subu|And|Or|Xor|Nor|slt|sltu|addi|addiu|andi|ori|xori|lw|sw|beq|bne|sllv|srlv|srav;
    assign ALUSrc2=addi|addiu|andi|ori|xori|lw|sw;
    assign RegDst=add|addu|sub|subu|And|Or|Xor|Nor|slt|sltu|sll|srl|sra|sllv|srlv|srav;
    assign RegWrite=add|addu|sub|subu|And|Or|Xor|Nor|slt|sltu|sll|srl|sra|sllv|srlv|srav|addi|addiu|andi|ori|xori|lw;
    assign Jump=j;
    assign sign_ext=lw|sw|beq;

    assign ALUOp[3]=slt|sltu|sllv|sll|srlv|srl|srav|sra;
    assign ALUOp[2]=And|andi|Or|ori|Xor|xori|Nor|srav|srav;
    assign ALUOp[1]=sub|beq|subu|Xor|xori|Nor|sllv|sll|srlv|srl;
    assign ALUOp[0]=addu|addiu|subu|Or|ori|Nor|sltu|srlv|srl;
    /*
    assign RegDst=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
    assign ALUSrc=(op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0])|(op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0]);
    assign MemtoReg=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
    assign RegWrite=(~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0])|(op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]);
    assign MemRead=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
    */
endmodule //ControlUnit