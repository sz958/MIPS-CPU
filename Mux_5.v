module Mux_5 (in0,in1,control,out);
    input [4:0] in0;
    input [4:0] in1;
    input control;
    output [4:0] out;

    assign out=control?in0:in1;    

endmodule //Mux_5
