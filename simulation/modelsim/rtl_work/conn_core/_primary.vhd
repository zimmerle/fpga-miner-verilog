library verilog;
use verilog.vl_types.all;
entity conn_core is
    generic(
        c_CLOCK_PERIOD_NS: integer := 100;
        c_CLKS_PER_BIT  : integer := 434;
        c_BIT_PERIOD    : integer := 8600
    );
    port(
        CLOCK_50        : in     vl_logic;
        tx              : out    vl_logic;
        rx              : out    vl_logic;
        line            : out    vl_logic;
        test            : in     vl_logic;
        data_available_to_be_processed: out    vl_logic;
        data_alredy_being_processed: in     vl_logic;
        blk1            : out    vl_logic_vector(511 downto 0);
        blk2            : out    vl_logic_vector(95 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of c_CLOCK_PERIOD_NS : constant is 1;
    attribute mti_svvh_generic_type of c_CLKS_PER_BIT : constant is 1;
    attribute mti_svvh_generic_type of c_BIT_PERIOD : constant is 1;
end conn_core;
