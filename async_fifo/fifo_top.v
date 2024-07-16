`include "sync.v"
`include "write.v"
`include "read.v"
`include "fifo_memory.v"

module asynchronous_fifo (wclk,wrst_n,rclk,rrst_n,w_en,r_en,data_in,data_out,full, empty);

  parameter DEPTH=8, DATA_WIDTH=8;
  parameter PTR_WIDTH = $clog2(DEPTH);

  input wclk, wrst_n;
  input rclk, rrst_n;
  input w_en, r_en;
  input [DATA_WIDTH-1:0] data_in;
  output reg [DATA_WIDTH-1:0] data_out;
  output reg full, empty;
 
  reg [PTR_WIDTH:0] g_wptr_sync, g_rptr_sync;
  reg [PTR_WIDTH:0] b_wptr, b_rptr;
  reg [PTR_WIDTH:0] g_wptr, g_rptr;

  wire [PTR_WIDTH-1:0] waddr, raddr;

  synchronizer sync_wptr (rclk, rrst_n, g_wptr, g_wptr_sync); //write pointer to read clock domain
  synchronizer sync_rptr (wclk, wrst_n, g_rptr, g_rptr_sync); //read pointer to write clock domain 
  
  wptr_handler wptr_h(wclk, wrst_n, w_en,g_rptr_sync,b_wptr,g_wptr,full);
  rptr_handler rptr_h(rclk, rrst_n, r_en,g_wptr_sync,b_rptr,g_rptr,empty);
  fifo_mem fifom(wclk, w_en, rclk, r_en,b_wptr, b_rptr, data_in,full,empty, data_out);

endmodule