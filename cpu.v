module cpu(
    input clk,
    input rst,
    output [31:0] pc_out,
    output [15:0] immediate,
    output [31:0] RF_ReadData1,
    output [31:0] RF_ReadData2,
    output [31:0] ext5_out,
    output [31:0] ext16_out,
    //output [31:0] Ext18_out,
    output [31:0] alu_out,
    output alu_overflow,
    output alu_zero,
    output alu_carryout,
    output [3:0] ALUOp,
    output [31:0] DataMem_out,
    output [31:0] inst
    //output clk_out
    );
    parameter cin=0;
    wire [31:0] mux2_out,pc4_out,mux5_out,ext16_out,mux4_out,ext5_out,mux3_out,s2_out,add_out,join_out,mux1_out;
    wire [25:0] address1;
    wire [27:0] address2=address1<<2;
    wire [5:0] op,funct;
    wire [4:0] rs,rd,rt,mux_5_out,shamt;
    //wire [15:0] immediate;
    //wire [3:0] ALUOp;
    wire MemtoReg,MemWrite,MemRead,ALUSrc1,ALUSrc2,RegDst,RegWrite,Branch,Jump,sign_ext,add_carry;
    PC pc(clk,rst,mux2_out,pc_out);
    PCPlus4 pc4(pc_out,pc4_out);
    InstructionMem InsMem(pc_out,op,rs,rt,rd,funct,immediate,address1,inst);
    assign shamt[4:0]=immediate[10:6];
    Ext5 ext5(shamt,ext5_out);
    ControlUnit control(op,funct,MemtoReg,MemWrite,MemRead,ALUOp,ALUSrc1,ALUSrc2,RegDst,RegWrite,Branch,Jump,sign_ext);
    Mux_32 mux3(RF_ReadData1,ext5_out,ALUSrc1,mux3_out);
    Mux_5 mux_5(rd,rt,RegDst,mux_5_out);
    RF rf(clk,rst,RegWrite,rs,rt,mux_5_out,mux5_out,RF_ReadData1,RF_ReadData2);
    Ext16 ext16(immediate,sign_ext,ext16_out);
    //Ext18 ext18(immediate<<2,ext18_out);
    Mux_32 mux4(ext16_out,RF_ReadData2,ALUSrc2,mux4_out);
    ALU alu(ALUOp,mux3_out,mux4_out,alu_out,alu_overflow,alu_zero,alu_carryout);   //mux3_out(in0)â€”â?”RF_ReadData1â€”â?”rs,mux4_out(in1)â€”â?”RF_ReadData2â€”â?”rt
    DataMemory datamemory(clk,MemRead,MemWrite,alu_out,RF_ReadData2,DataMem_out);
    Mux_32 mux5(DataMem_out,alu_out,MemtoReg,mux5_out);
    shifter_2 s2(ext16_out,cin,s2_out);
    adder_32 add(cin,pc4_out,s2_out,add_carry,add_out);
    Join join1(address2,pc4_out,join_out);
    Mux_32 mux1(add_out,pc4_out,Branch&alu_zero,mux1_out);
    Mux_32 mux2(join_out,mux1_out,Jump,mux2_out);
endmodule