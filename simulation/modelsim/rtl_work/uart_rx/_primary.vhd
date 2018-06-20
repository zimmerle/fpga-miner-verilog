library verilog;
use verilog.vl_types.all;
entity uart_rx is
    generic(
        CLKS_PER_BIT    : vl_notype
    );
    port(
        i_Clock         : in     vl_logic;
        i_Rx_Serial     : in     vl_logic;
        o_Rx_DV         : out    vl_logic;
        o_Rx_Byte       : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLKS_PER_BIT : constant is 5;
end uart_rx;
