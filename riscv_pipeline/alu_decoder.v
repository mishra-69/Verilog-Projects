//
module alu_decoder(op,funct3,funct7,ALUcon,ALUopT);
    input [6:0] op;
    input [2:0] funct3;
    input [6:0] funct7;
    input [1:0] ALUcon;
    output reg [3:0] ALUopT;

//parameter [2:0] ADD=3'b000,SUB=3'b001,SLT=3'b010,SLTU=3'b011 

    always@(*)
    begin
      ALUopT=4'b0000;//default
      case(ALUcon)
        2'b00:ALUopT=4'b0000;
        2'b11:ALUopT=4'b1111;
        2'b10:ALUopT={(funct7[5]&op[5]),funct3};
      endcase
    end
endmodule