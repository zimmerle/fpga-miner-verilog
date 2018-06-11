library verilog;
use verilog.vl_types.all;
entity sha256_k_constants is
    port(
        addr            : in     vl_logic_vector(5 downto 0);
        K               : out    vl_logic_vector(31 downto 0)
    );
end sha256_k_constants;
