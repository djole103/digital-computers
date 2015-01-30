library verilog;
use verilog.vl_types.all;
entity modgen_counter_6_0 is
    port(
        clock           : in     vl_logic;
        q               : out    vl_logic_vector(5 downto 0);
        clk_en          : in     vl_logic;
        aclear          : in     vl_logic;
        sload           : in     vl_logic;
        data            : in     vl_logic_vector(5 downto 0);
        aset            : in     vl_logic;
        sclear          : in     vl_logic;
        updn            : in     vl_logic;
        cnt_en          : in     vl_logic;
        p_p_reset       : in     vl_logic;
        p_p_clk         : in     vl_logic;
        p_m_i2c_ctrl_clk_dup_364: in     vl_logic;
        px755           : in     vl_logic;
        p_p_clock       : in     vl_logic
    );
end modgen_counter_6_0;
