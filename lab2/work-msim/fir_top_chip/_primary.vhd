library verilog;
use verilog.vl_types.all;
entity fir_top_chip is
    port(
        clock_50        : in     vl_logic;
        clock_27        : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 0);
        sw              : in     vl_logic_vector(17 downto 0);
        ledg            : out    vl_logic_vector(8 downto 0);
        ledr            : out    vl_logic_vector(17 downto 0);
        hex0            : out    vl_logic_vector(6 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex4            : out    vl_logic_vector(6 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0);
        hex6            : out    vl_logic_vector(6 downto 0);
        hex7            : out    vl_logic_vector(6 downto 0);
        aud_xck         : out    vl_logic;
        aud_bclk        : inout  vl_logic;
        aud_dacdat      : out    vl_logic;
        aud_daclrck     : out    vl_logic;
        aud_adclrck     : out    vl_logic;
        i2c_sdat        : inout  vl_logic;
        i2c_sclk        : out    vl_logic
    );
end fir_top_chip;
