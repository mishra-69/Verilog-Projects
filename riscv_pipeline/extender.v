module Sign_Extend (instr,ImmSrc,ImmExt);
    input [31:0] instr;
    input [2:0] ImmSrc;
    output reg [31:0] ImmExt;

    always@(*)
    begin
        case(ImmSrc)
            3'b000:ImmExt={{20{instr[31]}},instr[31:20]};//I
            3'b001:ImmExt={{20{instr[31]}},instr[31:25],instr[11:7]};//S
            3'b011:ImmExt={{19{instr[31]}},instr[7], instr[30:25], instr[11:8], 1'b0};//B
            3'b010:ImmExt={instr[31], instr[30:20], instr[19:12], {12{1'b0}}};//U
            3'b100:ImmExt={{13{instr[31]}},instr[19:12], instr[20], instr[30:25], instr[24:21],1'b0 };//jal
        endcase
    end
endmodule