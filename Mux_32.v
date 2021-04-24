module Mux_32 (in0,in1,control,out);
    input [31:0] in0;
    input [31:0] in1;
    input control;
    output [31:0] out;

    assign out=control?in0:in1;    

endmodule //Mux_32