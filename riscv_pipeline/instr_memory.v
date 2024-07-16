module Instruction_Memory(rst,PC,instr);

  input rst;
  input [31:0]PC;
  output [31:0]instr;

  reg [31:0] mem [1023:0];
  
  assign instr = mem[PC[31:2]];

  initial begin
    $readmemh("memfile2.hex",mem);
  end


/*
  initial begin
    //mem[0] = 32'hFFC4A303;
    //mem[1] = 32'h00832383;
    // mem[0] = 32'h0064A423;
    // mem[1] = 32'h00B62423;
    mem[0] = 32'h0062E233;
    // mem[1] = 32'h00B62423;

  end
*/
endmodule