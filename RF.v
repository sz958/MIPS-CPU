`timescale 1ns / 1ps

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

    //写寄存器
    always @(posedge clk,posedge rst) begin
        if(rst)
            begin
            register[0]<=0;
            register[1]<=1;
            register[2]<=2;
            register[3]<=3;
            register[4]<=4;
            register[5]<=5;
            register[6]<=6;
            register[7]<=7;
            register[8]<=8;
            register[9]<=9;
            register[10]<=10;
            register[11]<=11;
            register[12]<=12;
            register[13]<=13;
            register[14]<=14;
            register[15]<=15;
            register[16]<=16;
            register[17]<=17;
            register[18]<=18;
            register[19]<=19;
            register[20]<=20;
            register[21]<=21;
            register[22]<=22;
            register[23]<=23;
            register[24]<=24;
            register[25]<=25;
            register[26]<=26;
            register[27]<=27;
            register[28]<=28;
            register[29]<=29;
            register[30]<=30;
            register[31]<=31;
            end
        else
            if(RegWrite&&WriteReg)
                register[WriteReg]=WriteData;
    end
        //读寄存器
    assign ReadData1=register[rs];
    assign ReadData2=register[rt];
endmodule //RF