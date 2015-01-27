------------------------------------------------------------------------
-- heating system testbench
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity heatingsys_tb is
end heatingsys_tb;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.heat_pkg.all;

architecture main of heatingsys_tb is
   signal des_temp, cur_temp : signed(7 downto 0);
   signal res  : std_logic;
   signal clk  : std_logic := '0';
   signal mode : heat_ty;
begin
   
	uut : entity work.heatingsys(main)
	 port map (
		 i_cur_temp    => cur_temp,
		 i_des_temp    => des_temp,
		 i_reset  => res,
	 i_clock  => clk,
		 o_heatmode  => mode
	 );
	
	process
	begin
	-- --------------------
	-- OFF
	-- --------------------
	--mode <= off;
	res <= '0'; cur_temp <= "00000011"; des_temp <= "00011100";
	wait until rising_edge(clk);
	-- --------------------
	res <= '0'; cur_temp <= "00000100"; des_temp <= "00000101";
	wait until rising_edge(clk);
	-- --------------------
	res <= '0'; cur_temp <= to_signed(0,8); des_temp <= to_signed(4,8);
	wait until rising_edge(clk);
	-- --------------------
	-- reset case for OFF
	res <= '1'; cur_temp <= to_signed(0,8); des_temp <= to_signed(4,8);
	wait until rising_edge(clk);
	-- --------------------
	-- LOW
	-- --------------------
	res <= '0'; cur_temp <= to_signed(0,8); des_temp <= to_signed(7,8);
	wait until rising_edge(clk);
	-- --------------------
	res <= '0'; cur_temp <= to_signed(3,8); des_temp <= to_signed(0,8);
	wait until rising_edge(clk);
	-- --------------------
	res <= '0'; cur_temp <= to_signed(1,8); des_temp <= to_signed(0,8);
	wait until rising_edge(clk);
	-- --------------------
	res <= '0'; cur_temp <= to_signed(0,8); des_temp <= to_signed(5,8);
	wait until rising_edge(clk);
	-- --------------------
	-- reset case for LOW
	res <= '1'; cur_temp <= to_signed(3,8); des_temp <= to_signed(0,8);
	wait until rising_edge(clk);
	-- --------------------
	-- HIGH
	-- --------------------
	res <= '0'; cur_temp <= to_signed(4,8); des_temp <= to_signed(0,8);
	wait until rising_edge(clk);
	-- --------------------
	res <= '0'; cur_temp <= to_signed(2,8); des_temp <=  to_signed(0,8);
	wait until rising_edge(clk);
	-- --------------------
	-- reset case for HIGH
	res <= '1'; cur_temp <= to_signed(4,8); des_temp <= to_signed(0,8);
	wait until rising_edge(clk);
	-- --------------------
	end process;

	process
	begin
		wait for 5 ns;
		clk <= not clk;

	end process;
	

end architecture;
