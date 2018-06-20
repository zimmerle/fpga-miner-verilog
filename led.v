
module led (
  CLOCK_50,
  led,
  reset
);

input CLOCK_50;
output led;
input reset;

reg leds;
assign led = leds;

reg [33:0]  counter;
reg [5:0]   PWM_adj;
reg [6:0]   PWM_width;

always @ (posedge CLOCK_50 or negedge reset) begin
  if (!reset) begin
    counter <= 0;
    leds <= 0;
  end
  else begin
    counter <= counter + 1;
    PWM_width <= PWM_width[5:0]+ PWM_adj;
    if (counter[26]) begin
      PWM_adj <= counter[25:20];
    end
    else begin
      PWM_adj <= ~ counter[25:20];
    end
    leds <= PWM_width[6];
  end
end
	
endmodule
