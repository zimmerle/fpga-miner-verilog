
module conn_core (
  input  wire CLOCK_50,
  input  wire reset,
  output reg  rx_led,
  output reg  tx_led,
  input  wire rx_pin,
  output wire tx_pin,
  output reg  line,
  output wire miner,
  output reg  [511:0]  blk1,
  output reg  [95:0]   blk2,
  input  wire [1023:0] msg,
  input  wire delivery_msg
);


reg [31:0] counter = 0;
wire       tx_busy;
reg        tx_data_ready;
reg  [7:0] tx_data;
wire       rx_data_ready;
wire [7:0] rx_data;
reg  [7:0] tmp_data;

reg        writeOk = 0;
reg        writeFailed = 0;

reg  [3:0] r_SM_Main;
reg  [3:0] read_state;

integer    offset;
integer    offset_send;

reg [1023:0] startup = "^n1.0v reniM aketsiB";
reg [1023:0] to_be_sent;
reg          msg_delivered;

parameter s_IDLE = 3'b000;
parameter s_SEND_DATA = 3'b001;
parameter s_SENDING_DATA = 3'b011;
parameter s_SENDING_BUFFER = 3'b111;
parameter s_SENDING_BUFFER_WAIT = 3'b100;

parameter s_r_IDLE = 3'b000;
parameter s_r_LOAD_BLK1 = 3'b001;
parameter s_r_LOAD_BLK2 = 3'b011;

task counter_blink();
begin
  counter <= counter + 1;
  if (counter > 10000000) begin
    tx_led <= !tx_led;
	 counter <= 0;
  end
end
endtask


led LED_line (
  .CLOCK_50(CLOCK_50),
  .led(line),
  .reset(reset)
);


async_transmitter TX(
  .clk(CLOCK_50),
  .TxD(tx_pin),
  .TxD_start(tx_data_ready),
  .TxD_data(tx_data),
  .TxD_busy(tx_busy)
);


async_receiver RX(
  .clk(CLOCK_50),
  .RxD(rx_pin),
  .RxD_data_ready(rx_data_ready),
  .RxD_data(rx_data)
);


always @ (posedge CLOCK_50 or negedge reset) begin
  if (!reset) begin
	 rx_led <= 0;
	 tx_data_ready <= 0;

	 r_SM_Main <= s_IDLE;
	 read_state <= s_r_IDLE;

	 writeOk <= 0;
	 writeFailed <= 0;
	 miner <= 0;
	 
    r_SM_Main <= s_SENDING_BUFFER;
	 to_be_sent = startup;
    offset_send = 0;
	 msg_delivered <= 0;
	 blk2 = 96'h4B1E5E4A29AB5F49FFFF001D;
	 blk1 = 512'h0100000000000000000000000000000000000000000000000000000000000000000000003BA3EDFD7A7B12B27AC72C3E67768F617FC81BC3888A51323A9FB8AA;
  end
  
 
  else if (CLOCK_50) begin
    rx_led <= 0;

    if (read_state == s_r_LOAD_BLK1 || read_state == s_r_LOAD_BLK2) begin
	   counter_blink();
	 end

	 if (!reset) begin
	 	blk2 = 96'h4B1E5E4A29AB5F49FFFF001D;
		blk1 = 512'h0100000000000000000000000000000000000000000000000000000000000000000000003BA3EDFD7A7B12B27AC72C3E67768F617FC81BC3888A51323A9FB8AA;
	 end

	 
    case (r_SM_Main)
  
    s_IDLE:
    begin
      if (rx_data_ready) begin
		
        tmp_data = rx_data;
	 
        case (read_state)

        s_r_IDLE:
        begin
          if (tmp_data == 49) begin
	         offset = 0;
            read_state <= s_r_LOAD_BLK1;
          end
          else if (tmp_data == 50) begin
    	      offset = 0;
            read_state <= s_r_LOAD_BLK2;
          end
          else if (tmp_data == 51) begin
            miner <= 1;
            writeOk <= 1;
          end
          else if (tmp_data == 52) begin
            miner <= 0;
		      writeOk <= 1;
          end
	       else begin
  	         writeFailed <= 1;
	       end
        end

        s_r_LOAD_BLK1:
        begin
			 if (offset == 0) begin
				blk1[7:0] <= tmp_data;
			 end
			 if (offset == 1) begin
				blk1[15:8] <= tmp_data;
			 end
			 if (offset == 2) begin
				blk1[23:16] <= tmp_data;
			 end
			 if (offset == 3) begin
				blk1[31:24] <= tmp_data;
			 end
			 if (offset == 4) begin
				blk1[39:32] <= tmp_data;
			 end
			 if (offset == 5) begin
				blk1[47:40] <= tmp_data;
			 end
			 if (offset == 6) begin
				blk1[55:48] <= tmp_data;
			 end
			 if (offset == 7) begin
				blk1[63:56] <= tmp_data;
			 end
			 if (offset == 8) begin
				blk1[71:64] <= tmp_data;
			 end
			 if (offset == 9) begin
				blk1[79:72] <= tmp_data;
			 end
			 if (offset == 10) begin
				blk1[87:80] <= tmp_data;
			 end
			 if (offset == 11) begin
				blk1[95:88] <= tmp_data;
			 end
			 if (offset == 12) begin
				blk1[103:96] <= tmp_data;
			 end
			 if (offset == 13) begin
				blk1[111:104] <= tmp_data;
			 end
			 if (offset == 14) begin
				blk1[119:112] <= tmp_data;
			 end
			 if (offset == 15) begin
				blk1[127:120] <= tmp_data;
			 end
			 if (offset == 16) begin
				blk1[135:128] <= tmp_data;
			 end
			 if (offset == 17) begin
				blk1[143:136] <= tmp_data;
			 end
			 if (offset == 18) begin
				blk1[151:144] <= tmp_data;
			 end
			 if (offset == 19) begin
				blk1[159:152] <= tmp_data;
			 end
			 if (offset == 20) begin
				blk1[167:160] <= tmp_data;
			 end
			 if (offset == 21) begin
				blk1[175:168] <= tmp_data;
			 end
			 if (offset == 22) begin
				blk1[183:176] <= tmp_data;
			 end
			 if (offset == 23) begin
				blk1[191:184] <= tmp_data;
			 end
			 if (offset == 24) begin
				blk1[199:192] <= tmp_data;
			 end
			 if (offset == 25) begin
				blk1[207:200] <= tmp_data;
			 end
			 if (offset == 26) begin
				blk1[215:208] <= tmp_data;
			 end
			 if (offset == 27) begin
				blk1[223:216] <= tmp_data;
			 end
			 if (offset == 28) begin
				blk1[231:224] <= tmp_data;
			 end
			 if (offset == 29) begin
				blk1[239:232] <= tmp_data;
			 end
			 if (offset == 30) begin
				blk1[247:240] <= tmp_data;
			 end
			 if (offset == 31) begin
				blk1[255:248] <= tmp_data;
			 end

	       offset = offset + 1;
	       if (offset == 32) begin
  	         offset = 0;
	         read_state <= s_r_IDLE;
            writeOk <= 1;
	       end
        end

        s_r_LOAD_BLK2:
        begin
			 if (offset == 0) begin
				blk2[7:0] <= tmp_data;
			 end
			 if (offset == 1) begin
				blk2[15:8] <= tmp_data;
			 end
			 if (offset == 2) begin
				blk2[23:16] <= tmp_data;
			 end
			 if (offset == 3) begin
				blk2[31:24] <= tmp_data;
			 end
			 if (offset == 4) begin
				blk2[39:32] <= tmp_data;
			 end
			 if (offset == 5) begin
				blk2[47:40] <= tmp_data;
			 end
			 if (offset == 6) begin
				blk2[55:48] <= tmp_data;
			 end
			 if (offset == 7) begin
				blk2[63:56] <= tmp_data;
			 end
			 if (offset == 8) begin
				blk2[71:64] <= tmp_data;
			 end
			 if (offset == 9) begin
				blk2[79:72] <= tmp_data;
			 end
			 if (offset == 10) begin
				blk2[87:80] <= tmp_data;
			 end
			 if (offset == 11) begin
				blk2[95:88] <= tmp_data;
			 end

	       offset = offset + 1;
	       if (offset == 32) begin
  	         offset = 0;
	         read_state <= s_r_IDLE;
            writeOk <= 1;
	       end
        end

		  default:
		  begin
		    read_state <= s_r_IDLE;
		  end

        endcase
	   end
  
      if (writeOk == 1) begin
        r_SM_Main <= s_SENDING_BUFFER;
	     to_be_sent = "^.kO";
        offset_send = 0;
      end
      if (writeFailed == 1) begin
        r_SM_Main <= s_SENDING_BUFFER;
	     to_be_sent = "^?tahW";
        offset_send = 0;
      end
		if (delivery_msg && msg_delivered == 0) begin
        r_SM_Main <= s_SENDING_BUFFER;
	     to_be_sent = msg;
        offset_send = 0;
		  msg_delivered <= 1;
		end
		if (msg_delivered && delivery_msg == 0) msg_delivered <= 0;
    end
	 
  s_SENDING_BUFFER:
  begin
    if (offset_send == 0) begin
      tx_data <= to_be_sent[7:0];
	 end
    if (offset_send == 1) begin
      tx_data <= to_be_sent[15:8];
	 end
    if (offset_send == 2) begin
      tx_data <= to_be_sent[23:16];
	 end
    if (offset_send == 3) begin
      tx_data <= to_be_sent[31:24];
	 end
    if (offset_send == 4) begin
      tx_data <= to_be_sent[39:32];
	 end
	 if (offset_send == 5) begin
		tx_data <= to_be_sent[47:40];
    end
    if (offset_send == 6) begin
		tx_data <= to_be_sent[55:48];
    end
    if (offset_send == 7) begin
		tx_data <= to_be_sent[63:56];
    end
    if (offset_send == 8) begin
		tx_data <= to_be_sent[71:64];
    end
    if (offset_send == 9) begin
		tx_data <= to_be_sent[79:72];
    end
    if (offset_send == 10) begin
		tx_data <= to_be_sent[87:80];
    end
    if (offset_send == 11) begin
		tx_data <= to_be_sent[95:88];
    end
    if (offset_send == 12) begin
      tx_data <= to_be_sent[103:96];
    end
    if (offset_send == 13) begin
      tx_data <= to_be_sent[111:104];
    end
    if (offset_send == 14) begin
      tx_data <= to_be_sent[119:112];
    end
    if (offset_send == 15) begin
      tx_data <= to_be_sent[127:120];
    end
    if (offset_send == 16) begin
      tx_data <= to_be_sent[135:128];
    end
    if (offset_send == 17) begin
      tx_data <= to_be_sent[143:136];
    end
    if (offset_send == 18) begin
      tx_data <= to_be_sent[151:144];
    end
    if (offset_send == 19) begin
      tx_data <= to_be_sent[159:152];
    end
    if (offset_send == 20) begin
      tx_data <= to_be_sent[167:160];
    end
    if (offset_send == 21) begin
      tx_data <= to_be_sent[175:168];
    end
    if (offset_send == 22) begin
      tx_data <= to_be_sent[183:176];
    end
    if (offset_send == 23) begin
      tx_data <= to_be_sent[191:184];
    end
    if (offset_send == 24) begin
      tx_data <= to_be_sent[199:192];
    end
    if (offset_send == 25) begin
      tx_data <= to_be_sent[207:200];
    end
    if (offset_send == 26) begin
      tx_data <= to_be_sent[215:208];
    end
    if (offset_send == 27) begin
      tx_data <= to_be_sent[223:216];
    end
    if (offset_send == 28) begin
      tx_data <= to_be_sent[231:224];
    end
    if (offset_send == 29) begin
      tx_data <= to_be_sent[239:232];
    end
    if (offset_send == 30) begin
      tx_data <= to_be_sent[247:240];
    end
	 if (tx_data == "^" || offset_send > 30) begin
	   tx_data[7:0] <= 8'ha;
      tx_data_ready <= 1;
	   r_SM_Main <= s_SENDING_DATA;
		offset_send = 0;
	 end else begin
      tx_data_ready <= 1;
	   r_SM_Main <= s_SENDING_BUFFER_WAIT;
      offset_send = offset_send + 1;
	 end
  end
  
  s_SENDING_BUFFER_WAIT:
  begin
    if (!tx_busy) begin
	   tx_data_ready <= 0;
 	   r_SM_Main <= s_SENDING_BUFFER;
	 end
  end

  
  s_SENDING_DATA:
  begin
    if (!tx_busy) begin
  	   tx_data_ready <= 0;
		r_SM_Main <= s_IDLE;
		writeOk <= 0;
		writeFailed <= 0;
	 end
  end  
  endcase
  end
end








endmodule
