
module clk_div (clk_in, reset, clk_out);
  input               clk_in                   ;
  input               reset                    ;
  output              clk_out                  ;
  wire                 clk_in                  ;
  reg                   clk_out                 ;
  always @ (posedge clk_in) 
  if (!reset) begin 
   clk_out <= 1'b0;
  end else begin
    clk_out <=  !clk_out ; 
  end
 
 endmodule  