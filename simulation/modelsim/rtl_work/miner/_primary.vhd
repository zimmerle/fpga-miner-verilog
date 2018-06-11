library verilog;
use verilog.vl_types.all;
entity miner is
    generic(
        STATE_IDLE      : integer := 0;
        STATE_FIRST_BLOCK: integer := 1;
        STATE_SECOND_BLOCK: integer := 2;
        STATE_HASH_OF_HASH: integer := 3;
        STATE_COMPARING_HASHES: integer := 4;
        STATE_INCREASE_NONCE: integer := 5;
        STATE_GOLDEN_NONCE_FOUND: integer := 6;
        CLK_HALF_PERIOD : integer := 2;
        CLK_PERIOD      : vl_notype
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of STATE_IDLE : constant is 1;
    attribute mti_svvh_generic_type of STATE_FIRST_BLOCK : constant is 1;
    attribute mti_svvh_generic_type of STATE_SECOND_BLOCK : constant is 1;
    attribute mti_svvh_generic_type of STATE_HASH_OF_HASH : constant is 1;
    attribute mti_svvh_generic_type of STATE_COMPARING_HASHES : constant is 1;
    attribute mti_svvh_generic_type of STATE_INCREASE_NONCE : constant is 1;
    attribute mti_svvh_generic_type of STATE_GOLDEN_NONCE_FOUND : constant is 1;
    attribute mti_svvh_generic_type of CLK_HALF_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 3;
end miner;
