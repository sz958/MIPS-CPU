module PCPlus4 (PC,PC4);
    input [31:0] PC;
    output [31:0] PC4;
    
    assign PC4=PC+4;

endmodule //PCPlus4