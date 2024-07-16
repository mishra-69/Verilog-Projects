module mux2x1 (a,b,s,out);

    input [31:0]a,b;
    input s;
    output [31:0]out;

    assign out = (s) ? a : b ;
    
endmodule

module mux4x1 (a,b,c,s,out);
    input [31:0] a,b,c;
    input [1:0] s;
    output [31:0] out;

    assign out = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 32'h00000000;
    
endmodule