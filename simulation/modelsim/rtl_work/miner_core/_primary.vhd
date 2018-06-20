library verilog;
use verilog.vl_types.all;
entity miner_core is
    generic(
        STATE_IDLE      : integer := 0;
        STATE_FIRST_BLOCK: integer := 1;
        STATE_SECOND_BLOCK: integer := 2;
        STATE_HASH_OF_HASH: integer := 3;
        STATE_COMPARING_HASHES: integer := 4;
        STATE_INCREASE_NONCE: integer := 5;
        STATE_GOLDEN_NONCE_FOUND: integer := 6
    );
    port(
        CLOCK_50        : in     vl_logic;
        led_processing  : out    vl_logic;
        led_found       : out    vl_logic;
        blk1            : in     vl_logic_vector(511 downto 0);
        blk2            : in     vl_logic_vector(95 downto 0);
        data_available_to_be_processed: in     vl_logic;
        data_alredy_being_processed: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of STATE_IDLE : constant is 1;
    attribute mti_svvh_generic_type of STATE_FIRST_BLOCK : constant is 1;
    attribute mti_svvh_generic_type of STATE_SECOND_BLOCK : constant is 1;
    attribute mti_svvh_generic_type of STATE_HASH_OF_HASH : constant is 1;
    attribute mti_svvh_generic_type of STATE_COMPARING_HASHES : constant is 1;
    attribute mti_svvh_generic_type of STATE_INCREASE_NONCE : constant is 1;
    attribute mti_svvh_generic_type of STATE_GOLDEN_NONCE_FOUND : constant is 1;
end miner_core;
