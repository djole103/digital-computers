library verilog;
use verilog.vl_types.all;
entity i2c_ctrl_notri is
    port(
        p_i2c_sdat      : in     vl_logic;
        p_finish_xfr    : out    vl_logic;
        p_i2c_data_4    : in     vl_logic_vector(2 downto 0);
        p_i2c_data_3    : in     vl_logic_vector(4 downto 4);
        p_i2c_data_2    : in     vl_logic_vector(7 downto 6);
        p_i2c_data_1    : in     vl_logic_vector(12 downto 9);
        p_i2c_data_5    : in     vl_logic_vector(22 downto 21);
        p_i2c_sclk      : out    vl_logic;
        p_start_xfr     : in     vl_logic;
        p_reset_rtlc_164_and_32: in     vl_logic_vector(2 downto 2);
        p_ack           : out    vl_logic;
        p_not_sdo       : out    vl_logic;
        p_clock         : in     vl_logic;
        p_sdo           : out    vl_logic;
        p_p_clk         : in     vl_logic;
        p_m_i2c_ctrl_clk_dup_364: in     vl_logic;
        p_not_reset_n   : in     vl_logic;
        px362           : in     vl_logic
    );
end i2c_ctrl_notri;
