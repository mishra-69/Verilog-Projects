
//`include "riscv.v"

module testb;
  reg clk=1'b1,rst;

  riscv_top dut(.clk(clk),.rst(rst));

  initial
  begin
    $dumpfile("testb.vcd");
    $dumpvars(0);
  end

  always
  begin
    clk= ~clk;
    #5;
  end

  initial
  begin
    rst = 1'b1;
    #5.5 rst =1'b0;
    //#3 rst =1'b0;
  end

  initial
  begin
    #300 $finish;
  end

endmodule