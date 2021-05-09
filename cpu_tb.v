module cpu_tb();
    reg clk;
    reg rst;
    wire [31:0] pc_out;
    wire [31:0] mux5_out;
    wire [31:0] RF_ReadData1;
    wire [31:0] RF_ReadData2;
    wire [31:0] Ext5_out;
    wire [31:0] Ext16_out;
    wire [31:0] alu_out;
    wire alu_overflow;
    wire alu_zero;
    wire alu_carryout;
    wire [3:0] ALUOp;
    wire [31:0] DataMem_out;
    wire [31:0] inst;
    cpu mips_cpu(clk,rst,pc_out,mux5_out,RF_ReadData1,RF_ReadData2,Ext5_out,Ext16_out,alu_out,alu_overflow,alu_zero,alu_carryout,ALUOp,DataMem_out,inst);
    initial begin
        clk=0;
        rst=0;
        #50
        rst=1;
        #50
        rst=0;
        forever begin
            #50
            clk=~clk;
        end
    end
endmodule