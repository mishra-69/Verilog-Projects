module Branch(rs1,rs2,BrT,BrU,BA);
    input [31:0] rs1,rs2;
    input [1:0] BrT;
    input BrU;
    output reg BA;

    wire Beq,Blt;
    wire [31:0] temp;
    //wire temp2;

    assign temp = rs1+(~rs2)+1;
    assign Beq = (temp==32'h00000000);
    assign Blt = (BrU) ? temp[31] : ((rs1[31]==rs2[31]) ? temp[31]:rs1[31]);//??????????????

    always@(*)
    begin    
        case(BrT)
            2'b00:BA=Beq;
            2'b01:BA=(~Beq);
            2'b10:BA=Blt;
            2'b11:BA=(~Blt);
        endcase
    end
endmodule