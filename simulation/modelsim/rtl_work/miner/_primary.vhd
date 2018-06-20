library verilog;
use verilog.vl_types.all;
entity miner is
    port(
        CLOCK_50        : in     vl_logic;
        reset           : in     vl_logic;
        led             : out    vl_logic_vector(7 downto 0)
    );
end miner;
