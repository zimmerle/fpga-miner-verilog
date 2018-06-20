library verilog;
use verilog.vl_types.all;
entity led is
    port(
        CLOCK_50        : in     vl_logic;
        led             : out    vl_logic;
        reset           : in     vl_logic
    );
end led;
