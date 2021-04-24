module InstructionMem (PC,op,rs,rt,rd,immediate);
    input [31:0] PC;
    output [5:0] op;
    output [4:0] rs;
    output [4:0] rt;
    output [4:0] rd;
    output [15:0] immediate;
    reg[7:0] mem[0:127];
    initial begin
        $readmemb("",mem);  //使用二进制存放指令，故用readmemb
    end

    //分割指令
    assign op=mem[PC][7:2];
    assign rs[4:3]=mem[PC][1:0];
    assign rs[2:0]=mem[PC+1][7:5];
    assign rt=mem[PC+1][4:0];
    assign rd=mem[PC+2][7:3];
    assign immediate[15:8]=mem[PC+2];
    assign immediate[7:0]=mem[PC+3];
endmodule //InstructionMem