

module miner (
    clock,
    reset,
    led
);

input clock;
input reset;
output led;
wire clock;
wire reset;
wire led;

/* clock related fixed parameter */
parameter CLK_HALF_PERIOD = 2;
parameter CLK_PERIOD = 2 * CLK_HALF_PERIOD;

/* definition of the state for the state machine */
parameter STATE_IDLE = 0;
parameter STATE_FIRST_BLOCK = 1;
parameter STATE_SECOND_BLOCK = 2;
parameter STATE_HASH_OF_HASH = 3;
parameter STATE_COMPARING_HASHES = 4;
parameter STATE_INCREASE_NONCE = 5;
parameter STATE_GOLDEN_NONCE_FOUND = 6;

/* sha global definition */
reg sha_init;
reg sha_mode;
reg sha_next;
reg sha_reset;

/* sha instance #1 */
reg [511:0] sha_1_block;
wire [255:0] sha_1_digest;
wire sha_1_digest_valid;
wire sha_1_ready;

/* attempt to make somthing dummy */
reg [1:0] sha_1_state;
reg sha_done = 0;

/* global machine state */
reg [31:0] global_state = STATE_IDLE;

/* hard coded blocks to be computed */
reg [511:0] blk1;
reg [511:0] blk2;

/* counter to be used as part of developer process */
reg [31:0] counter_out;

 
sha256_core SHA_INST1 (
  .clk(clock),
  .reset_n(sha_reset),
  .init(sha_init),
  .next(sha_next),
  .mode(sha_mode),
  .block(sha_1_block),
  .ready(sha_1_ready),
  .digest(sha_1_digest),
  .digest_valid(sha_1_digest_valid)
);


task reset_sha();
begin
  /* reset sha #n */
  sha_mode = 1;

  /* reset sha #1 */
  sha_reset = 1;
  sha_init = 0;
  sha_next = 0;
  sha_1_block = 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  sha_reset = 0;
  #(4 * CLK_HALF_PERIOD);
  sha_reset = 1;
end
endtask


task reset_all();
begin
  reset_sha();
end
endtask


task compute_hash_of_hash();
begin
  $display(" ** computing second hash....");
  global_state = STATE_HASH_OF_HASH;
  
  sha_1_block = {sha_1_digest, 256'h80000000000000000000000000000000000000000000000000000000000001C0};
  sha_init = 1;
  #(CLK_PERIOD);
  sha_init = 0;
  sha_1_state = 2'b10;
end
endtask


task compute_sha_1st_block();
begin
  $display(" ** computing frist block....");
  global_state = STATE_FIRST_BLOCK;
  sha_1_block = blk1;
  sha_init = 1;
  #(CLK_PERIOD);
  sha_init = 0;
  sha_1_state = 2'b00;
end
endtask


task compute_sha_2nd_block();
begin
  $display(" ** computing second block....");
  global_state = STATE_SECOND_BLOCK;
  sha_1_block = blk2;
  sha_next = 1;
  #(CLK_PERIOD);
  sha_next = 0;
  sha_1_state = 2'b01;
end
endtask


task compare_hashes();
begin
  global_state = STATE_COMPARING_HASHES;
  //global_state = 5;
  $display(" ** comparing hashes.... ");
end
endtask


task increase_nonces();
begin
  //global_state = 2;
end
endtask


always @ (posedge sha_1_ready)
begin
sha_done = 1;
//  if (sha_1_state == 2'b00) begin
    ///* first block done */
//    $display("Got first  block: 0x%064x", sha_1_digest);
//  end
//  if (sha_1_state == 2'b01) begin
    /* second block done */
//    $display("Got second block: 0x%064x", sha_1_digest);
//  end
//  if (sha_1_state == 2'b10) begin
    /* second hash done */
//    $display("Got second hash: 0x%064x", sha_1_digest);
//  end
end



always @ (posedge clock)
begin : COUNTER
  if (reset == 1'b1) begin
    counter_out <= #1 0;
    reset_all();
    global_state = STATE_IDLE;
  end
  else begin
    counter_out <= #1 counter_out + 1;
  end

  /* reset on start */
  if (counter_out == 10) begin
    $display("Simulating data from uart.");
    blk1 = 512'h6162636462636465636465666465666765666768666768696768696A68696A6B696A6B6C6A6B6C6D6B6C6D6E6C6D6E6F6D6E6F706E6F70718000000000000000;
    blk2 = 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001C0;
	 compute_sha_1st_block();
  end
  if (sha_done && sha_1_ready && sha_1_digest_valid && global_state == STATE_FIRST_BLOCK) begin
    $display("Got first  block: 0x%064x", sha_1_digest);
	 sha_done = 0;
    compute_sha_2nd_block();
  end
  if (sha_done && sha_1_ready && sha_1_digest_valid && global_state == STATE_SECOND_BLOCK) begin
    $display("Got second block: 0x%064x", sha_1_digest);
    compute_hash_of_hash();
  end
  if (sha_done && sha_1_ready && sha_1_digest_valid && global_state == STATE_HASH_OF_HASH) begin
    $display("Got second hash: 0x%064x", sha_1_digest);
    $display("Got hash of hash...");
	 global_state = STATE_IDLE;
	 counter_out <= #1 0;
  end

  //$display("Counter: 0x%04x", counter_out); 
end



endmodule
