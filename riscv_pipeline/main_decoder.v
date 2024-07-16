// Code your design here
module main_decoder(op,/*BA,*/ImmSrc,RegWEn,MemWEn,ASrc,BSrc,DdataSel,ALUcon,Branch,Jump/*,PCSrc*/);
    input [6:0] op;
    /*input BA;*/
    /*output PCSrc;*/
    output reg RegWEn,MemWEn,ASrc,BSrc,Branch,Jump;//,PCSrc;
    output reg [2:0]ImmSrc;
    output reg [1:0]ALUcon,DdataSel;

    //reg [11:0] controlsig;
//
    //assign {ImmSrc,RegWEn,MemWEn,ASrc,BSrc,DdataSel,ALUcon,Branch,Jump} = controlsig

    always@(*)
    begin
      case(op)
        7'b0000011: begin //lw
        //controlsig=12'b000_1_0_0_1_00_00_0_0;
          ImmSrc=3'b000;
          RegWEn=1'b1;
          MemWEn=1'b0;
          ASrc=1'b0;
          BSrc=1'b1;
          DdataSel=2'b00;
          ALUcon=2'b00;
          Branch=1'b0;
          Jump=1'b0;
        end
        7'b0100011: begin //sw        
          ImmSrc=3'b001;
          RegWEn=1'b0;
          MemWEn=1'b1;
          ASrc=1'b0;
          BSrc=1'b1;
          DdataSel=2'b00;
          ALUcon=2'b00;
          Branch=1'b0;
          Jump=1'b0;          
        end
        7'b0110011: begin //R-type        
          ImmSrc=3'b000;
          RegWEn=1'b1;
          MemWEn=1'b0;
          ASrc=1'b0;
          BSrc=1'b0;
          DdataSel=2'b01;
          ALUcon=2'b10;
          Branch=1'b0;
          Jump=1'b0;
        end
         7'b0010011: begin //I-type        
          ImmSrc=3'b000;
          RegWEn=1'b1;
          MemWEn=1'b0;
          ASrc=1'b0;
          BSrc=1'b1;
          DdataSel=2'b01;
          ALUcon=2'b10;
          Branch=1'b0;
          Jump=1'b0;
        end
        7'b0110111: begin //lui-type        
          ImmSrc=3'b010;
          RegWEn=1'b1;
          MemWEn=1'b0;
          ASrc=1'b0;
          BSrc=1'b1;
          DdataSel=2'b01;
          ALUcon=2'b11;
          Branch=1'b0;
          Jump=1'b0;
        end
        7'b0010111: begin //auipc-type        
          ImmSrc=3'b010;
          RegWEn=1'b1;
          MemWEn=1'b0;
          ASrc=1'b1;
          BSrc=1'b1;
          DdataSel=2'b01;
          ALUcon=2'b00;
          Branch=1'b0;
          Jump=1'b0;
        end
        7'b1100011: begin //B-type        
          ImmSrc=3'b011;
          RegWEn=1'b0;
          MemWEn=1'b0;
          ASrc=1'b1;
          BSrc=1'b1;
          DdataSel=2'b00;
          ALUcon=2'b00;
          Branch=1'b1;
          Jump=1'b0;
        end
        7'b1101111: begin //jal        
          ImmSrc=3'b100;
          RegWEn=1'b1;
          MemWEn=1'b0;
          ASrc=1'b1;
          BSrc=1'b1;
          DdataSel=2'b10;
          ALUcon=2'b00;
          Branch=1'b0;
          Jump=1'b1;
        end
        7'b1100111: begin //jalr        
          ImmSrc=3'b000;
          RegWEn=1'b1;
          MemWEn=1'b0;
          ASrc=1'b1;
          BSrc=1'b1;
          DdataSel=2'b10;
          ALUcon=2'b00;
          Branch=1'b0;
          Jump=1'b1;
        end
        default: begin //jalr        
          ImmSrc=3'b000;
          RegWEn=1'b0;
          MemWEn=1'b0;
          ASrc=1'b0;
          BSrc=1'b0;
          DdataSel=2'b10;
          ALUcon=2'b00;
          Branch=1'b0;
          Jump=1'b0;
        end
      endcase
    end

    //assign PCSrc=(BA&Branch)|Jump;
endmodule