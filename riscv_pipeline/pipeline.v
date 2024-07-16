module if_id (clk,rst,PCF,instrF,FlushD,StallD,PCD,instrD);
input clk,rst,StallD,FlushD;
input [31:0] PCF,instrF;
output reg [31:0] PCD,instrD;

always@(posedge clk or posedge rst)
begin
  if(rst|FlushD) begin
    PCD<=32'd0;
    instrD<=32'd0;
  end
  else if(~StallD) begin
    PCD<=PCF;
    instrD<=instrF;
  end
end
endmodule


module id_ex(clk,rst,FlushE,PCD,Rdata1D,Rdata2D,instrD,CBusD,PCE,Rdata1E,Rdata2E,instrE,CBusE);    //,ImmSrcD,RegWEn,MemWEn,ASrc,BSrc,DdataSel,Branch,Jump/*,PCSrc*/,BrU,BrT,ALUopT);
  input clk,rst,FlushE;
  input [31:0] PCD,Rdata1D,Rdata2D,instrD;
  input [17:0] CBusD;
  output reg [31:0] PCE,Rdata1E,Rdata2E,instrE;
  output reg [17:0] CBusE;

  always@(posedge clk or posedge rst)
  begin
    if (rst|FlushE) begin
      PCE<=32'd0;
      Rdata1E<=32'd0;
      Rdata2E<=32'd0;
      instrE<=32'd0;
      CBusE<=18'd0;
    end
    else begin
      PCE<=PCD;
      Rdata1E<=Rdata1D;
      Rdata2E<=Rdata2D;
      instrE<=instrD;
      CBusE<=CBusD;
    end
  end
endmodule

module ex_ma(clk,rst,PCE,ResultE,Rdata2E,instrE,CBus4E,PCM,ResultM,Rdata2M,instrM,CBus4M);
input clk, rst;
input [31:0] PCE,ResultE,Rdata2E,instrE;
input [8:5] CBus4E;
output reg [31:0] PCM,ResultM,Rdata2M,instrM;
output reg [8:5] CBus4M;

always@(posedge clk or posedge rst)
  begin
    if (rst) begin
      PCM<=32'd0;
      ResultM<=32'd0;
      Rdata2M<=32'd0;
      instrM<=32'd0;
      CBus4M<=4'd0;
    end
    else begin
      PCM<=PCE;
      ResultM<=ResultE;
      Rdata2M<=Rdata2E;
      instrM<=instrE;
      CBus4M<=CBus4E;
    end
  end
endmodule

module ma_wb(clk,rst,DdataM,instrM,CBus1M,DdataWB,instrWB,CBus1WB);
input clk,rst;
input CBus1M;
input [31:0] DdataM,instrM;
output reg [31:0] DdataWB,instrWB;
output reg CBus1WB;

always@(posedge clk or posedge rst)
  begin
    if (rst) begin
      DdataWB<=32'd0;
      instrWB<=32'd0;
      CBus1WB<=1'b0;
    end
    else begin
      DdataWB<=DdataM;
      instrWB<=instrM;
      CBus1WB<=CBus1M;
    end
  end
endmodule