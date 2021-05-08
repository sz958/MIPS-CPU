`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/04 09:28:34
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    input [3:0] op,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out,
    output reg overflow,
    output reg zero,
    output reg carryout
        );
    
    //wire [31:0]in0;
    //wire [31:0]in1;
    //wire [31:0]add_out_com;
    //wire [31:0]sub_out_com;
    //reg [31:0]add_out;
    //reg [31:0]sub_out;
    wire [31:0] sub_in1;
    wire [31:0]add_out;
    wire [31:0]sub_out;
    //wire [31:0]shift_out;
    wire add_carryout;
    wire sub_carryout;
    parameter cin=0;

    assign  sub_in1=(~in1+1);
    adder_32 add(
                .cin(cin),
                .in0(in0),
                .in1(in1),
                .carryout(add_carryout),
                .out(add_out)
                );
    adder_32 sub(
                .cin(cin),
                .in0(in0),
                .in1(sub_in1),
                .carryout(sub_carryout),
                .out(sub_out)
                );

    //sll/sllv,sra/srav以及srl/srlv区别在于第二个操作数，指令执行可用同样的操作
    always @(*)
    begin 
        case(op)
        //add
        4'b0000:
            begin
                out=add_out;
                //add_out=add_out_com;
                overflow=((in0[31]==in1[31])&&(~out[31]==in0[31]))?1:0;
                zero=(out==0)?1:0;
                carryout=0; //有符号加法最高位是符号位，故考虑溢出即可，进位赋为0
            end
        //addu
        4'b0001:
            begin
                //{carryout,out}=in0+in1;
                carryout=add_carryout;
                out=add_out;
                zero=(out==0)?1:0;
                overflow=0;
            end
        //sub
        4'b0010:
            begin
                out=sub_out;
                //overflow=(in1[31]!=in0[31]&&out[31]!=in1[31])?1:0;
                overflow=((in0[31]==sub_in1[31])&&(~out[31]==in0[31]))?1:0;
                zero=(out==0)?1:0;
                carryout=0;
            end
        //subu
        4'b0011:    
            begin
                //{carryout,out}=in1-in0;
                carryout=~sub_carryout;
                out=sub_out;
                zero=(out==0)?1:0;
                overflow=0;
            end
        //and
        4'b0100:
            begin
                out=in1&in0;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
            end
        //or
        4'b0101:
            begin
                out=in1|in0;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
            end
        //xor
        4'b0110:
            begin
                out=in1^in0;
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
            end
        //nor
        4'b0111:
            begin
                out=~(in1|in0);
                zero=(out==0)?1:0;
                carryout=0;
                overflow=0;
            end
        //slt
        4'b1000:
            begin
                if(in0[31]==1&&in1[31]==0)
                    out=1;
                else if(in0[31]==0&&in1[31]==1)
                    out=0;
                else
                    out=(in0<in1)?1:0;
                zero=(out==0)?1:0;
                overflow=0;
                carryout=0;
            end
        //sltu
        4'b1001:
            begin
                out=(in0<in1)?1:0;
                zero=(out==0)?1:0;
                overflow=0;
                carryout=0;
            end
        
        //sllv
        4'b1010:
            begin
            out=in1<<in0;
            carryout=0;
            overflow=in0[31]^in0[31-in1];
            zero=(out==0)?1:0;
            end
        //srlv
        4'b1011:
            begin
            out=in1>>in0;
            carryout=0;
            overflow=0;
            zero=(out==0)?1:0;
            end
        //srav
        4'b1100:
            begin
            out=$signed(in1)>>>in0;
            carryout=0;
            overflow=0;
            zero=(out==0)?1:0;
            end

        endcase
    end

endmodule

