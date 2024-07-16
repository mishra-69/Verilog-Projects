`include "main_decoder.v"
`include "branch_decoder.v"
`include "alu_decoder.v"

module cu_top(instr,CBus);///*BA,*/ImmSrc,RegWEn,MemWEn,ASrc,BSrc,DdataSel,Branch,Jump/*,PCSrc*/,BrU,BrT,ALUopT);
    input [31:0] instr;
    output [17:0] CBus;
    //input BA;
    // reg PCSrc;
    // reg RegWEn,MemWEn,ASrc,BSrc,Branch,Jump;//,PCSrc;
    // reg  [2:0]ImmSrc;
    
    // reg  [1:0] BrT,DdataSel;
    // reg  BrU;
    // reg  [3:0] ALUopT;
    wire [1:0]ALUcon;

    main_decoder m (instr[6:0],CBus[2:0],CBus[5],CBus[6],CBus[3],CBus[4],CBus[8:7],ALUcon,CBus[13],CBus[14]);       //(/*BA,*/)ImmSrc,RegWEn,MemWEn,ASrc,BSrc,DdataSel,ALUcon,Branch,Jump);(/*,PCSrc*/)
    branch_decoder v(instr[14:12],CBus[15],CBus[17:16]);      //BrU,BrT);
    alu_decoder a(instr[6:0],instr[14:12],instr[31:25],ALUcon,CBus[12:9]);    //ALUopT);

    //assign CBus = {ImmSrc,RegWEn,MemWEn,ASrc,BSrc,DdataSel,ALUopT,Branch,Jump,BrU,BrT};
endmodule