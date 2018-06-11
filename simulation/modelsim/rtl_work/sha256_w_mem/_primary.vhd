library verilog;
use verilog.vl_types.all;
entity sha256_w_mem is
    generic(
        CTRL_IDLE       : integer := 0;
        CTRL_UPDATE     : integer := 1
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        \block\         : in     vl_logic_vector(511 downto 0);
        init            : in     vl_logic;
        \next\          : in     vl_logic;
        w               : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CTRL_IDLE : constant is 1;
    attribute mti_svvh_generic_type of CTRL_UPDATE : constant is 1;
end sha256_w_mem;
