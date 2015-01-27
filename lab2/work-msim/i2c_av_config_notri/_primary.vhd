library verilog;
use verilog.vl_types.all;
entity i2c_av_config_notri is
    port(
        p_u0_not_sdo    : out    vl_logic;
        p_i2c_sclk      : out    vl_logic;
        p_i2c_sdat      : in     vl_logic;
        p_clk           : in     vl_logic;
        p_sdo           : out    vl_logic
    );
end i2c_av_config_notri;
