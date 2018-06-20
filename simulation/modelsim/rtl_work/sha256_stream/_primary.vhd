library verilog;
use verilog.vl_types.all;
entity sha256_stream is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        mode            : in     vl_logic;
        s_tdata_i       : in     vl_logic_vector(511 downto 0);
        s_tlast_i       : in     vl_logic;
        s_tvalid_i      : in     vl_logic;
        s_tready_o      : out    vl_logic;
        digest_o        : out    vl_logic_vector(255 downto 0);
        digest_valid_o  : out    vl_logic
    );
end sha256_stream;
