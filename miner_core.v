`timescale 1ns/10ps

module miner_core (
  input       CLOCK_50,
  input       CLOCK_3,
  input       reset,
  input       enable,
  output reg  led_processing,
  output reg  led_found,
  input  reg  [511:0]  blk1,
  input  reg  [95:0]   blk2,
  output wire [1023:0] msg,
  output wire delivery_msg
);


/* definition of the state for the state machine */
parameter STATE_SLEEPING = 0;
parameter STATE_START = 1;
parameter STATE_WAITING_FIRST_BLOCK = 2;
parameter STATE_FIRST_BLOCK_READY = 3;
parameter STATE_WAITING_SECOND_BLOCK = 4;
parameter STATE_SECOND_BLOCK_READY = 5;
parameter STATE_WAITING_HASH_OF_HASH = 6;
parameter STATE_HASH_OF_HASH_READY = 7;
parameter STATE_WAITING_RESET = 8;
parameter STATE_FOUND = 19;

/* sha global definition */
reg sha_init;
reg sha_mode;
reg sha_next;

/* sha instance #1 */
reg [511:0] sha_1_block;
wire [255:0] sha_1_digest;
wire sha_1_digest_valid;
wire sha_1_ready;
wire [255:0] hash_i;

/* nonces */
//reg [31:0] sha_1_nonce;
integer sha_1_nonce = 49782218; /* 49782288 */

/* dificult */
reg [255:0] dificult;

/* global machine state */
reg [31:0] global_state;

reg [31:0] counter = 0;
reg [64:0] counter_perf = 0;

sha256_core SHA_INST1 (
  .clk(CLOCK_50),
  .reset_n(reset),
  .init(sha_init),
  .next(sha_next),
  .mode(sha_mode),
  .block(sha_1_block),
  .ready(sha_1_ready),
  .digest(sha_1_digest),
  .digest_valid(sha_1_digest_valid)
);


task counter_performance();
begin
  counter_perf <= counter_perf + 1;
  if (counter_perf == 1000) begin
    delivery_msg <= 0;
  end
  if (counter_perf == 500000) begin
    msg = {"^!!", sha_1_nonce, "!!"};	
    delivery_msg <= 1;
	 counter_perf <= 0;
  end
end
endtask


task counter_blink();
begin
  counter <= counter + 1;
  if (counter > 10000) begin
    led_processing <= !led_processing;
	 counter <= 0;
  end
end
endtask


always @ (posedge CLOCK_3)
begin : CORE
  if (!reset) begin
    global_state <= STATE_SLEEPING;
	 led_found <= 0;
	 delivery_msg <= 0;

    sha_mode = 1;
    sha_init = 0;
    sha_next = 0;
    //sha_1_nonce = 32'h1DAC2B7C;
	 //sha_1_nonce = 32'h00000000;
	 sha_1_nonce <= 49782218;
	 dificult = 255'h0000000000000000000000000000000000000000000000000000000000000000;
	 led_processing <= 0;
  end

  case (global_state)

  STATE_SLEEPING:
  begin
    if (enable) begin
	   global_state <= STATE_START;
	 end
  end
  
  STATE_START:
  begin
    //led_found <= 0;
    if (!enable) begin
	   global_state <= STATE_SLEEPING;
	 end else begin
	   dificult = {blk2[15:8], blk2[23:16], blk2[31:24]} * 2 ** (8*(blk2[7:0]-3));
	   sha_init = 0;
      sha_next = 0;
      sha_mode = 1;
	   sha_1_block = blk1;
	   sha_init = 1;
      global_state <= STATE_WAITING_FIRST_BLOCK;
	 end
  end

  STATE_WAITING_FIRST_BLOCK:
  begin
    if (sha_1_ready && sha_1_digest_valid) begin
   	$display("1 - Got block: %x", sha_1_block);
	   global_state <= STATE_FIRST_BLOCK_READY;	
		sha_init = 0;
    end
  end
  
  STATE_FIRST_BLOCK_READY:
  begin
    sha_1_block = {96'h4B1E5E4A29AB5F49FFFF001D, sha_1_nonce, 384'h800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000280};
    sha_next = 1;
    global_state <= STATE_WAITING_SECOND_BLOCK;
  end
  
  STATE_WAITING_SECOND_BLOCK:
  begin
  	 if (sha_next == 0 && sha_1_ready && sha_1_digest_valid) begin
		global_state <= STATE_SECOND_BLOCK_READY;
	 end
	 sha_next = 0; 
  end

  STATE_SECOND_BLOCK_READY:
  begin
    sha_1_block = {sha_1_digest, 256'h8000000000000000000000000000000000000000000000000000000000000100};
    sha_init = 1;
    global_state <= STATE_WAITING_HASH_OF_HASH;
  end
  
  STATE_WAITING_HASH_OF_HASH:
  begin
  	 if (sha_init == 1 && sha_1_ready && sha_1_digest_valid) begin
		global_state <= STATE_HASH_OF_HASH_READY;
		sha_init = 0;
	 end
  end
  
  STATE_HASH_OF_HASH_READY:
  begin
    hash_i[255:248] = sha_1_digest[7:0];
    hash_i[247:240] = sha_1_digest[15:8];
    hash_i[239:232] = sha_1_digest[23:16];
    hash_i[231:224] = sha_1_digest[31:24];
    hash_i[223:216] = sha_1_digest[39:32];
    hash_i[215:208] = sha_1_digest[47:40];
    hash_i[207:200] = sha_1_digest[55:48];
    hash_i[199:192] = sha_1_digest[63:56];
    hash_i[191:184] = sha_1_digest[71:64];
    hash_i[183:176] = sha_1_digest[79:72];
    hash_i[175:168] = sha_1_digest[87:80];
    hash_i[167:160] = sha_1_digest[95:88];
    hash_i[159:152] = sha_1_digest[103:96];
    hash_i[151:144] = sha_1_digest[111:104];
    hash_i[143:136] = sha_1_digest[119:112];
    hash_i[135:128] = sha_1_digest[127:120];
    hash_i[127:120] = sha_1_digest[135:128];
    hash_i[119:112] = sha_1_digest[143:136];
    hash_i[111:104] = sha_1_digest[151:144];
    hash_i[103:96] = sha_1_digest[159:152];
    hash_i[95:88] = sha_1_digest[167:160];
    hash_i[87:80] = sha_1_digest[175:168];
    hash_i[79:72] = sha_1_digest[183:176];
    hash_i[71:64] = sha_1_digest[191:184];
    hash_i[63:56] = sha_1_digest[199:192];
    hash_i[55:48] = sha_1_digest[207:200];
    hash_i[47:40] = sha_1_digest[215:208];
    hash_i[39:32] = sha_1_digest[223:216];
    hash_i[31:24] = sha_1_digest[231:224];
    hash_i[23:16] = sha_1_digest[239:232];
    hash_i[15:8] = sha_1_digest[247:240];
    hash_i[7:0] = sha_1_digest[255:248];

    if (hash_i < dificult) begin
      msg = {"^--", sha_1_nonce, "--"};	
      delivery_msg <= 1;
      global_state <= STATE_FOUND;
		led_found <= 1;
    end else begin
      sha_1_nonce <= sha_1_nonce + 1;
      global_state <= STATE_START;
		counter_blink();
		counter_performance();
	 end
	
  end

  STATE_FOUND:
  begin
  end
	 
  endcase

end
endmodule
