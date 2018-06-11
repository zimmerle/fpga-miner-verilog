`timescale 1ns/10ps
 
`include "../miner.v"
`include "../sha2/sha256_w_mem.v"
`include "../sha2/sha256_stream.v"
`include "../sha2/sha256_k_constants.v"
`include "../sha2/sha256_core.v"
`include "../sha2/sha256.v"



  
module tb_miner ();
 
  parameter CLK_HALF_PERIOD = 2;
  parameter CLK_PERIOD = 2 * CLK_HALF_PERIOD;

  reg [31 : 0] cycle_ctr;
  reg [31 : 0] error_ctr;
  reg [31 : 0] tc_ctr;

  reg            tb_clk;
  reg            tb_reset_n;
  reg            tb_init;
  reg            tb_next;
  reg            tb_mode;
  reg [511 : 0]  tb_block;
  wire           tb_ready;
  wire [255 : 0] tb_digest;
  wire           tb_digest_valid;
 
       reg [511 : 0] tc2_1;
      reg [255 : 0] res2_1;
      reg [511 : 0] tc2_2;
      reg [255 : 0] res2_2;
		
		     reg [255 : 0] db_digest1;
     reg [255 : 0] db_digest2;

	  
    task wait_ready;
    begin
      while (!tb_ready)
        begin
		  
          #(CLK_PERIOD);
        end
    end
  endtask // wait_ready
  

	 
	 
   //----------------------------------------------------------------
  // Device Under Test.
  //----------------------------------------------------------------
  sha256_core dut(
                  .clk(tb_clk),
                  .reset_n(tb_reset_n),

                  .init(tb_init),
                  .next(tb_next),
                  .mode(tb_mode),

                  .block(tb_block),

                  .ready(tb_ready),

                  .digest(tb_digest),
                  .digest_valid(tb_digest_valid)
                 );
  
 // always
   // #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;
        always
    begin : clk_gen
      #CLK_HALF_PERIOD;
      tb_clk = !tb_clk;
    end // clk_gen


  initial
  
    begin : tb_miner
	   /* reset */
      tb_clk = 0;
      tb_reset_n = 1;
      tb_init = 0;
      tb_next = 0;
      tb_mode = 1;
      tb_block = 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
      tb_reset_n = 0;
      #(4 * CLK_HALF_PERIOD);
      tb_reset_n = 1;

		$display("   -- Testbench for miner started --");

      tc2_1 = 512'h6162636462636465636465666465666765666768666768696768696A68696A6B696A6B6C6A6B6C6D6B6C6D6E6C6D6E6F6D6E6F706E6F70718000000000000000;
      res2_1 = 256'h85E655D6417A17953363376A624CDE5C76E09589CAC5F811CC4B32C1F20E533A;

      tc2_2 = 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001C0;
      res2_2 = 256'h248D6A61D20638B8E5C026930C3E6039A33CE45964FF2167F6ECEDD419DB06C1;
		
		
      tb_block = tc2_1;
      tb_init = 1;
		$display("   -- Wait 1 --");
      #(CLK_PERIOD);
      tb_init = 0;
      wait_ready();

	   $display("   -- Wait 1 :: fora --");
      db_digest1 = tb_digest;


		 
		tb_block = tc2_2;		
		tb_next = 1;
      #(CLK_PERIOD);
      tb_next = 0;
		
		$display("   -- Wait 2 --");
      wait_ready();
		$display("   -- Wait 2 :: fora --");
		db_digest2 = tb_digest;
		 
		 
      $display("Expected 1: 0x%064x", res2_2);
      $display("Got      1: 0x%064x", db_digest2);

      //double_block_test(2, tc2_1, res2_1, tc2_2, res2_2);
		
      //@(posedge r_Clock);
      $display("Test Passed - Correct Byte Received");
       
    end
   
endmodule