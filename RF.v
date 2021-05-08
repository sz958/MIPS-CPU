module RF (
    input clk,
    input rst,
    input RegWrite,
    input [4:0] rs, //A1
    input [4:0] rt, //A2
    input [4:0] WriteReg,   //A3
    input [31:0] WriteData, //WD3
    output [31:0] ReadData1,    //RD1
    output [31:0] ReadData2     //RD2
    );

    reg [31:0] register[0:31];
    //初始化寄存器
    
    //写寄存器
    always @(posedge clk,posedge rst) begin
        if(rst)
            begin
            register[0]=0;
            register[1]=0;
            register[2]=0;
            register[3]=0;
            register[4]=0;
            register[5]=0;
            register[6]=0;
            register[7]=0;
            register[8]=0;
            register[9]=0;
            register[10]=0;
            register[11]=0;
            register[12]=0;
            register[13]=0;
            register[14]=0;
            register[15]=0;
            register[16]=0;
            register[17]=0;
            register[18]=0;
            register[19]=0;
            register[20]=0;
            register[21]=0;
            register[22]=0;
            register[23]=0;
            register[24]=0;
            register[25]=0;
            register[26]=0;
            register[27]=0;
            register[28]=0;
            register[29]=0;
            register[30]=0;
            register[31]=0;
            end
        else
            if(RegWrite&&WriteReg)
                register[WriteReg]=WriteData;
    end
        //读寄存器
    assign ReadData1=register[rs];
    assign ReadData2=register[rt];
endmodule //RF