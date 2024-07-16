module data_forward(rs1E,rs2E,RegWEnM,RegWEnWB,rdM,rdWB,Fwd1,Fwd2);
    input RegWEnM,RegWEnWB;
    input [4:0] rs1E,rs2E,rdM,rdWB;
    output reg [1:0] Fwd1,Fwd2;

    always@(*)
    begin
        if (((rs1E==rdM) & RegWEnM)&(rs1E!=5'd0))
            Fwd1=01;
        else if (((rs1E==rdWB) & RegWEnWB)&(rs1E!=5'd0))
            Fwd1=10;
        else
            Fwd1=00;

        if (((rs2E==rdM) & RegWEnM)&(rs2E!=5'd0))
            Fwd2=01;
        else if (((rs2E==rdWB) & RegWEnWB)&(rs2E!=5'd0))
            Fwd2=10;
        else
            Fwd2=00;
    
    end
endmodule

module lw_stall_bj_haz(rs1D,rs2D,rdE,PCSrcE,DdataSelE,FlushE,FlushD,StallD,StallF);
    input [4:0] rs1D,rs2D,rdE;
    input [1:0] DdataSelE;
    input PCSrcE;
    output reg FlushE,FlushD,StallD,StallF;

    always@(*)
    begin
      if (((rs1D==rdE)|(rs2D==rdE))&(DdataSelE==2'b00)&(rs2D!=5'd0)&(rs1D!=5'd0)) begin
        FlushE=1'b1;
        FlushD=1'b0;
        StallD=1'b1;
        StallF=1'b1;
    end
    else if (PCSrcE) begin
        FlushE=1'b1;
        FlushD=1'b1;
        StallD=1'b0;
        StallF=1'b0;
    end
    else begin
        FlushE=1'b0;
        FlushD=1'b0;
        StallD=1'b0;
        StallF=1'b0;
    end  
    end
endmodule

// module bj_haz(PCSrcE,FlushE,FlushD);
//     input PCSrcE;
//     output reg FlushE,FlushD;

//     // assign FlushE = PCSrcE;
//     // assign FlushD = PCSrcE;

//     always@(*)
//     begin
//       if(PCSrcE) begin
//         FlushE=1'b1;
//         FlushD=1'b1;
//       end

//       else
//       FlushE=1'b0;
//       FlushD=1'b0;
//     end
// endmodule