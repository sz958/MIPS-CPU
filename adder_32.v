`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/16 13:19:46
// Design Name: 
// Module Name: adder_32
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


module adder_32(cin,in0,in1,carryout,out);
    input [31:0] in0;
    input [31:0] in1;
    input cin;
    output [31:0] out;
    output carryout;
    //wire [31:0] in0_com,in1_com,out_com;
    wire carryout1;
    wire carryout2;
    wire carryout3;
    
    adder_8 adder_8_0(cin,in0[7:0],in1[7:0],carryout1,out[7:0]);
    adder_8 adder_8_1(carryout1,in0[15:8],in1[15:8],carryout2,out[15:8]);
    adder_8 adder_8_2(carryout2,in0[23:16],in1[23:16],carryout3,out[23:16]);
    adder_8 adder_8_3(carryout3,in0[31:24],in1[31:24],carryout,out[31:24]);
    
endmodule
