// Code your design here
module ALU(A,B,ALUopT,Result);

input [31:0] A,B;
input [3:0] ALUopT;
output reg [31:0] Result;

reg [31:0] temp;
reg temp2;
// a=5 b=A
always@(*)
 begin
            Result=32'h00000000;//default
            case(ALUopT)
                4'b0000:Result=A+B;//ALUopT=add\addi;
                4'b0010:begin //ALUopT=slt\slti;
                            temp=A+(~B)+1;
                            temp2=(A[31]==B[31])? temp[31]:A[31];
                            Result={31'b0,temp2};
                        end
                4'b0011:begin //ALUopT=sltu\sltui;//?????????
                            temp=A+(~B)+1;
                            temp2=temp[31];
                            Result={31'b0,temp2};
                        end
                4'b0100:Result=A^B;//ALUopT=xor\xori;
                4'b0110:Result=A|B;//ALUopT=or\ori;
                4'b0111:Result=A&B;//ALUopT=and\andi;
                4'b0001:Result=A<<B;//ALUopT=sll\slli;
                4'b0101:Result=A>>B;//ALUopT=srl\srli;
                //4'b1101:ALUopT=sra\srai
                4'b1000:Result=A+(~B)+1;//ALUopT=sub;
                4'b1111:Result=B;//lui
            endcase
        end

endmodule