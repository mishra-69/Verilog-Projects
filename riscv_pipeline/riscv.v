`include "pc.v"
`include "instr_memory.v"
`include "registers.v"
`include "extender.v"
`include "alu.v"
`include "cu_top.v"
`include "data_memory.v"
//`include "pc_adder.v"
`include "mux.v"
`include "branch.v"
`include "pc_src_box.v"
`include "pipeline.v"
`include "hazard.v"

module riscv_top(clk,rst);

    input clk,rst;

    // wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
    // wire RegWrite,MemWrite,ALUSrc,ResultSrc;
    // wire [1:0]ImmSrc;
    // wire [2:0]ALUControl_Top;

    wire [31:0] PCF,PC_NextF,PCFplus4,ResultM,instrF,PCD,instrD,DdataWB,instrWB,Rdata1D,Rdata2D,PCE,Rdata1E,Rdata2E,instrE,ImmExtE,AE,BE,ResultE,PCM,Rdata2M,instrM;
    wire[31:0] MemDataM,PCMplus4,DdataM;
    wire CBus1WB,BAe,PCSrcE,FlushE,StallF,StallD,FlushD;
    wire [17:0] CBusD,CBusE;
    wire [8:5] CBus4E,CBus4M;
    wire [31:0] Rdata1Ef,Rdata2Ef;
    wire [1:0] Fwd1,Fwd2;

    PC PC(
        .clk(clk),
        .rst(rst),
        .StallF(StallF),
        .PC_Next(PC_NextF),
        .PC(PCF)
        
    );

    PC_Adder PC_Adder1(
                    .a(PCF),
                    .b(32'd4),
                    .out(PCFplus4)
    );
    
    mux2x1 PCmux(
                .a(ResultE),
                .b(PCFplus4),
                .s(PCSrcE),
                .out(PC_NextF)
    );
    
    Instruction_Memory Instruction_Memory(
                                        .rst(rst),
                                        .PC(PCF),
                                        .instr(instrF)
    );

    if_id if_id(
                .clk(clk),
                .rst(rst),
                .PCF(PCF),
                .instrF(instrF),
                .StallD(StallD),
                .FlushD(FlushD),
                .PCD(PCD),
                .instrD(instrD)
    );

    Registers Registers(
                        .clk(clk),
                        .rst(rst),
                        .RegWEn(CBus1WB),
                        .Ddata(DdataWB),
                        .RAddr1(instrD[19:15]),
                        .RAddr2(instrD[24:20]),
                        .DAddr(instrWB[11:7]),
                        .Rdata1(Rdata1D),
                        .Rdata2(Rdata2D)
    );

    cu_top cu_top(
                .instr(instrD),
                .CBus(CBusD)
    );

    id_ex id_ex(
                .clk(clk),
                .rst(rst),
                .FlushE(FlushE),
                .PCD(PCD),
                .Rdata1D(Rdata1D),
                .Rdata2D(Rdata2D),
                .instrD(instrD),
                .CBusD(CBusD),
                .PCE(PCE),
                .Rdata1E(Rdata1E),
                .Rdata2E(Rdata2E),
                .instrE(instrE),
                .CBusE(CBusE)
    );

    Sign_Extend Sign_Extend(
                        .instr(instrE),
                        .ImmSrc(CBusE[2:0]),
                        .ImmExt(ImmExtE)
    );

    PC_Src_Box PC_Src_Box(
                        .BA(BAe),
                        .Branch(CBusE[13]),
                        .Jump(CBusE[14]),
                        .PCSrc(PCSrcE)
    );

    
    mux4x1 FwdRdata1(
                .a(Rdata1E),
                .b(ResultM),
                .c(DdataWB),
                .s(Fwd1),
                .out(Rdata1Ef)
    );

    mux4x1 FwdRdata2(
                .a(Rdata2E),
                .b(ResultM),
                .c(DdataWB),
                .s(Fwd2),
                .out(Rdata2Ef)
    );

    data_forward data_forward(
                            .rs1E(instrE[19:15]),
                            .rs2E(instrE[24:20]),
                            .RegWEnM(CBus4M[5]),
                            .RegWEnWB(CBus1WB),
                            .rdM(instrM[11:7]),
                            .rdWB(instrWB[11:7]),
                            .Fwd1(Fwd1),
                            .Fwd2(Fwd2)
    );

    lw_stall_bj_haz lw_stall_bj_haz(
                    .rs1D(instrD[19:15]),
                    .rs2D(instrD[24:20]),
                    .rdE(instrE[11:7]),
                    .PCSrcE(PCSrcE),
                    .DdataSelE(CBusE[8:7]),
                    .FlushE(FlushE),
                    .FlushD(FlushD),
                    .StallD(StallD),
                    .StallF(StallF)
    );

    // bj_haz bj_haz(
    //             .PCSrcE(PCSrcE),
    //             .FlushE(FlushE),
    //             .FlushD(FlushD)
    // );

    Branch Branch(  
                .rs1(Rdata1Ef),
                .rs2(Rdata2Ef),
                .BrT(CBusE[17:16]),
                .BrU(CBusE[15]),
                .BA(BAe)
    );

    mux2x1 ASrcmux(
                .a(PCE),
                .b(Rdata1Ef),
                .s(CBusE[3]),
                .out(AE)
    );

    mux2x1 BSrcmux(
                .a(ImmExtE),
                .b(Rdata2Ef),
                .s(CBusE[4]),
                .out(BE)
    );
    
    ALU ALU(
            .A(AE),
            .B(BE),
            .ALUopT(CBusE[12:9]),
            .Result(ResultE)
    );

    ex_ma ex_ma(
                .clk(clk),
                .rst(rst),
                .PCE(PCE),
                .ResultE(ResultE),
                .Rdata2E(Rdata2Ef),
                .instrE(instrE),
                .CBus4E(CBusE[8:5]),
                .PCM(PCM),
                .ResultM(ResultM),
                .Rdata2M(Rdata2M),
                .instrM(instrM),
                .CBus4M(CBus4M)
    );

    Data_Memory Data_Memory(
                .clk(clk),
                .rst(rst),
                .WE(CBus4M[6]),
                .WD(Rdata2M),
                .A(ResultM),
                .RD(MemDataM)
    );

    PC_Adder PC_Adder2(
                    .a(PCM),
                    .b(32'd4),
                    .out(PCMplus4)
    );

    mux4x1 Ddatamux(
                .a(MemDataM),
                .b(ResultM),
                .c(PCMplus4),
                .s(CBus4M[8:7]),
                .out(DdataM)
    );

    ma_wb ma_wb(
                .clk(clk),
                .rst(rst),
                .DdataM(DdataM),
                .instrM(instrM),
                .CBus1M(CBus4M[5]),
                .DdataWB(DdataWB),
                .instrWB(instrWB),
                .CBus1WB(CBus1WB)
    );

endmodule