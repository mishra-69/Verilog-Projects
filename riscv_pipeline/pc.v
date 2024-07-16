module PC(clk,rst,StallF,PC_Next,PC);
    input clk,rst,StallF;
    input [31:0]PC_Next;
    output reg [31:0]PC;
    //reg [31:0]PC;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
            PC <= 32'h00000000;
        else if(~StallF)
            PC <= PC_Next;
    end
endmodule

module PC_Adder(a,b,out);

    input [31:0]a,b;
    output [31:0]out;

    assign out = a + b;
    
endmodule