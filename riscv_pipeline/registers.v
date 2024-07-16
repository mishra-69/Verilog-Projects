module Registers(clk,rst,RegWEn,Ddata,RAddr1,RAddr2,DAddr,Rdata1,Rdata2);

    input clk,rst,RegWEn;
    input [4:0]RAddr1,RAddr2,DAddr;
    input [31:0]Ddata;
    output reg [31:0]Rdata1,Rdata2;

    reg [31:0] Register [31:0];

    
    always @ (posedge clk)
    begin
        if(RegWEn & (DAddr != 5'h00))
            Register[DAddr] <= Ddata;
    end

    always @(*) begin
        if (RegWEn && (RAddr1 == DAddr)) begin
            Rdata1 = Ddata;
        end else begin
            Rdata1 = Register[RAddr1];
        end

        if (RegWEn && (RAddr2 == DAddr)) begin
            Rdata2 = Ddata;
        end else begin
            Rdata2 = Register[RAddr2];
        end
    end

    
    // assign Rdata1 = (rst) ? 32'd0 : Register[RAddr1];
    // assign Rdata2 = (rst) ? 32'd0 : Register[RAddr2];

    initial begin
        Register[0] = 32'h00000000;
    end

endmodule