module Join(
    input [27:0] address,
    input [3:0] pc4_out,
    output [31:0] join_out
    );
    assign join_out[27:0]=address;
    assign join_out[31:28]=pc4_out;
endmodule