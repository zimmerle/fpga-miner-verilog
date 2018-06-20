

module miner (
  input  wire CLOCK_50,
  input  wire reset,
  output wire [7:0] led,
  input  wire rx,
  output wire tx
);

reg  [511:0]  blk1;
wire [95:0]   blk2;
reg miner_enabled;
wire delivery_msg;
wire [1023:0] msg;
reg           CLOCK_25;
reg           CLOCK_12;
reg           CLOCK_6;
reg           CLOCK_3;

clk_div CLK (
  .clk_in(CLOCK_50),
  .reset(reset),
  .clk_out(CLOCK_25)
);

clk_div CLK2 (
  .clk_in(CLOCK_25),
  .reset(reset),
  .clk_out(CLOCK_12)
);

clk_div CLK3 (
  .clk_in(CLOCK_12),
  .reset(reset),
  .clk_out(CLOCK_6)
);

clk_div CLK4 (
  .clk_in(CLOCK_6),
  .reset(reset),
  .clk_out(CLOCK_3)
);


led LED0 (
  .CLOCK_50(CLOCK_25),
  .led(led[0]),
  .reset(reset)
);
led LED5 (
  .CLOCK_50(CLOCK_25),
  .led(led[5]),
  .reset(reset)
);
led LED6 (
  .CLOCK_50(CLOCK_25),
  .led(led[6]),
  .reset(reset)
);

conn_core CONN (
  .CLOCK_50(CLOCK_25),
  .reset(reset),
  .rx_led(led[3]),
  .rx_pin(rx),
  .tx_led(led[2]),
  .tx_pin(tx),
  .line(led[7]),
  .blk1(blk1),
  .blk2(blk2),
  .miner(miner_enabled),
  .delivery_msg(delivery_msg),
  .msg(msg)
);

miner_core CORE (
  .CLOCK_50(CLOCK_50),
  .CLOCK_3(CLOCK_6),
  .reset(reset),
  .enable(miner_enabled),
  .led_processing(led[1]),
  .led_found(led[4]),
  .blk1(blk1),
  .blk2(blk2),
  .delivery_msg(delivery_msg),
  .msg(msg)
);

endmodule
