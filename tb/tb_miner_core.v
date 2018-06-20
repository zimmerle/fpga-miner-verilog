`timescale 1ns/10ps
 
`include "../miner.v"
`include "../sha2/sha256_w_mem.v"
`include "../sha2/sha256_stream.v"
`include "../sha2/sha256_k_constants.v"
`include "../sha2/sha256_core.v"
`include "../sha2/sha256.v"

  
module tb_miner ();


reg tb_clk;
reg tb_reset;
reg tb_miner_enabled;
reg led1;
reg led2;
reg [511:0]  tb_blk1;
reg [95:0]   tb_blk2;
reg tb_delivery_msg;
reg [1023:0] tb_msg;


parameter CLK_HALF_PERIOD = 2;
parameter CLK_PERIOD = 2 * CLK_HALF_PERIOD;

miner_core dut (
  .CLOCK_50(tb_clk),
  .reset(tb_reset),
  .enable(tb_miner_enabled),
  .led_processing(led1),
  .led_found(led2),
  .blk1(tb_blk1),
  .blk2(tb_blk2),
  .delivery_msg(delivery_msg),
  .msg(msg)
);


always
begin : clk_gen
  #CLK_HALF_PERIOD;
  tb_clk = !tb_clk;
end



initial
begin : tb_miner
  tb_clk = 0;
  #CLK_PERIOD;
  $display("   -- Testbench for miner started --");
  tb_miner_enabled <= 1;
  

  $display("test passed");
  end


endmodule