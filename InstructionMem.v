module InstructionMem (
    input [31:0] PC,
    output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [5:0] funct,
    output [15:0] immediate,
    output [25:0] address,
    output [31:0] inst
        );

    reg[31:0] mem[0:31];
    initial begin
        $readmemh("F:\\CPU\\MIPS-CPU-main\\imem.txt",mem);  //使用二进制存放指令，故用readmemb
    end
    assign inst=mem[PC];
    assign op=mem[PC][31:26];
    assign rs=mem[PC][25:21];
    assign rt=mem[PC][20:16];
    assign rd=mem[PC][15:11];
    assign funct=mem[PC][5:0];
    assign immediate=mem[PC][15:0];
    assign address=mem[PC][25:0];
    //分割指令
    /*
    assign op=mem[PC][7:2];
    assign rs[4:3]=mem[PC][1:0];
    assign rs[2:0]=mem[PC+1][7:5];
    assign rt=mem[PC+1][4:0];
    assign rd=mem[PC+2][7:3];
    assign funct=mem[PC+3][5:0];
    assign immediate[15:8]=mem[PC+2];
    assign immediate[7:0]=mem[PC+3];
    assign address[25:24]=mem[PC][1:0];
    assign address[23:16]=mem[PC+1];
    assign address[15:8]=mem[PC+2];
    assign address[7:0]=mem[PC+3];
    */
endmodule //InstructionMem