module branch_decoder(funct3,BrU,BrT);
    input [2:0] funct3;
    output reg [1:0] BrT;
    output reg BrU;

    //assign {BrT[1],BrU,BrT[0]} =funct3;

    always@(*)
        {BrT[1],BrU,BrT[0]} =funct3;

endmodule