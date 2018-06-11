library verilog;
use verilog.vl_types.all;
entity sha256_core is
    generic(
        SHA224_H0_0     : vl_logic_vector(31 downto 0) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0);
        SHA224_H0_1     : integer := 914150663;
        SHA224_H0_2     : integer := 812702999;
        SHA224_H0_3     : vl_logic_vector(31 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1);
        SHA224_H0_4     : vl_logic_vector(31 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1);
        SHA224_H0_5     : integer := 1750603025;
        SHA224_H0_6     : integer := 1694076839;
        SHA224_H0_7     : vl_logic_vector(31 downto 0) := (Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        SHA256_H0_0     : integer := 1779033703;
        SHA256_H0_1     : vl_logic_vector(31 downto 0) := (Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1);
        SHA256_H0_2     : integer := 1013904242;
        SHA256_H0_3     : vl_logic_vector(31 downto 0) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0);
        SHA256_H0_4     : integer := 1359893119;
        SHA256_H0_5     : vl_logic_vector(31 downto 0) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0);
        SHA256_H0_6     : integer := 528734635;
        SHA256_H0_7     : integer := 1541459225;
        SHA256_ROUNDS   : integer := 63;
        CTRL_IDLE       : integer := 0;
        CTRL_ROUNDS     : integer := 1;
        CTRL_DONE       : integer := 2
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        init            : in     vl_logic;
        \next\          : in     vl_logic;
        mode            : in     vl_logic;
        \block\         : in     vl_logic_vector(511 downto 0);
        ready           : out    vl_logic;
        digest          : out    vl_logic_vector(255 downto 0);
        digest_valid    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SHA224_H0_0 : constant is 1;
    attribute mti_svvh_generic_type of SHA224_H0_1 : constant is 1;
    attribute mti_svvh_generic_type of SHA224_H0_2 : constant is 1;
    attribute mti_svvh_generic_type of SHA224_H0_3 : constant is 1;
    attribute mti_svvh_generic_type of SHA224_H0_4 : constant is 1;
    attribute mti_svvh_generic_type of SHA224_H0_5 : constant is 1;
    attribute mti_svvh_generic_type of SHA224_H0_6 : constant is 1;
    attribute mti_svvh_generic_type of SHA224_H0_7 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_H0_0 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_H0_1 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_H0_2 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_H0_3 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_H0_4 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_H0_5 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_H0_6 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_H0_7 : constant is 1;
    attribute mti_svvh_generic_type of SHA256_ROUNDS : constant is 1;
    attribute mti_svvh_generic_type of CTRL_IDLE : constant is 1;
    attribute mti_svvh_generic_type of CTRL_ROUNDS : constant is 1;
    attribute mti_svvh_generic_type of CTRL_DONE : constant is 1;
end sha256_core;
