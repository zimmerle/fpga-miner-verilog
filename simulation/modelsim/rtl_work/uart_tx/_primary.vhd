library verilog;
use verilog.vl_types.all;
entity uart_tx is
    generic(
        CLKS_PER_BIT    : vl_notype
    );
    port(
        i_Clock         : in     vl_logic;
        i_Tx_DV         : in     vl_logic;
        i_Tx_Byte       : in     vl_logic_vector(7 downto 0);
        o_Tx_Active     : out    vl_logic;
        o_Tx_Serial     : out    vl_logic;
        o_Tx_Done       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLKS_PER_BIT : constant is 5;
end uart_tx;
