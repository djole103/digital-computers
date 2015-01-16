library ieee;
use ieee.std_logic_1164.all;

entity myflipflop is
  port(  i_clock   -- clock
       , i_d       -- flip-flop input
       , i_ce      -- flip-flop chip enable
       , i_reset   -- flip-flop reset
       , i_sel     -- mux selector 
       , i_d2      -- the second data input
       : in std_logic; 
         o_q       -- flip-flop output for basic flop
       , o_q_a     -- flip-flop output for part (a)
       , o_q_b     -- flip-flop output for part (b)
       , o_q_c     -- flip-flop output for part (c)
       , o_q_d     -- flip-flop output for part (d)
       : out std_logic 
  );
end myflipflop;

architecture main of myflipflop is
    signal x_fb : std_logic;
begin
  basic : process
  begin
    wait until rising_edge(i_clock);
    o_q <= i_d;
  end process; 

  proc_a : process
  begin
    wait until rising_edge(i_clock);
    o_q_a <= (i_d and not i_reset);
  end process;

  proc_b : process
  begin
    wait until rising_edge(i_clock);
    if i_ce = '1' then
      o_q_b <= i_d;
    end if;
  end process;

  proc_c : process
  begin
    wait until rising_edge(i_clock);
    case i_sel is
        when '0' => o_q_c <= i_d;
        when others => o_q_c <= i_d2;
    end case;
  end process;

  proc_d : process
  begin
    wait until rising_edge(i_clock);
    case i_sel is
        when '0' => x_fb <= i_d;
        when others => x_fb <= not x_fb;
    end case;
  end process;

  o_q_d <= x_fb;

end architecture;
