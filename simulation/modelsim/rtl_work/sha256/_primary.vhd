library verilog;
use verilog.vl_types.all;
entity sha256 is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        cs              : in     vl_logic;
        we              : in     vl_logic;
        address         : in     vl_logic_vector(7 downto 0);
        write_data      : in     vl_logic_vector(31 downto 0);
        read_data       : out    vl_logic_vector(31 downto 0);
        error           : out    vl_logic
    );
end sha256;
