library verilog;
use verilog.vl_types.all;
entity tb_miner is
    generic(
        CLK_HALF_PERIOD : integer := 2;
        CLK_PERIOD      : vl_notype
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_HALF_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 3;
end tb_miner;
