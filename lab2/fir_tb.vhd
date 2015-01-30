------------------------------------------------------------------------
-- fir test bench
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.fir_synth_pkg.all;

entity fir_tb is
end entity;

------------------------------------------------------------------------

architecture main of fir_tb is
   signal ind, outd: word;
   signal clkd  : std_logic := '0';
begin

	uut : entity work.fir(low_pass)
	 port map (
		 i_data    => ind,
		 o_data    => outd,
		 clk  => clkd
	 );

	process
	begin
		
		ind <= x"0000";
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		wait until rising_edge(clkd);
		ind <= x"1000";
		wait until rising_edge(clkd);
		ind <= x"0000";

	end process;

	process
	begin
		clkd <= not clkd;
		wait for 5 ns;
	end process;
  
end architecture;
------------------------------------------------------------------------

