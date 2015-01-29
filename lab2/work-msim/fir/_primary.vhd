library verilog;
use verilog.vl_types.all;
entity fir is
    port(
        clk             : in     vl_logic;
        i_data          : in     vl_logic_vector(15 downto 0);
        o_data          : out    vl_logic_vector(15 downto 0)
    );
end fir;
