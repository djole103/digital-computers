library ieee;
use ieee.std_logic_1164.all;

package heat_pkg is
  subtype heat_ty is std_logic_vector(1 downto 0);
  constant off  : heat_ty := "00";
  constant low  : heat_ty := "01";
  constant high : heat_ty := "11";
end heat_pkg;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.heat_pkg.all;

entity heatingsys is                           -- finite state machine
  port(i_cur_temp       : in signed(7 downto 0); -- current temp
       i_des_temp       : in signed(7 downto 0); -- desired temp
       i_reset          : in std_logic;          -- i_reset
       i_clock          : in std_logic;          -- clock
       o_heatmode       : out heat_ty            -- mode
      );
end heatingsys;

architecture main of heatingsys is
  signal state : heat_ty;   
begin

  -- insert your vhdl code here
  proc_statemachine : process
  begin
    wait until rising_edge(i_clock);
    if(i_reset = '1') then
        state <= off;
    else
        case state is 
            when off =>
                 if  (5 <= i_des_temp - i_cur_temp) then
                     state <= high;
                 elsif(3 <= i_des_temp - i_cur_temp and 5 > i_des_temp - i_cur_temp ) then
                     state <= low;
                 else state <= off;
                 end if;
            when low =>
                 if(7 <= i_des_temp - i_cur_temp) then
                     state <= high;
                 elsif(2 < i_cur_temp - i_des_temp) then
                     state <= off;
                 else
                     state <= low;
                 end if;
            when high =>
                if(3 < i_cur_temp - i_des_temp) then
                    state <= low;
                else
                    state <= high;
                end if; 
            when others =>
                state <= off;
        end case;
    end if;
  end process;
o_heatmode <= state;

end main;

-- question 1
  -- 2 1-bit flipflops
  -- 0 latches
  -- 11 ANDs
  -- 12 ORs
  -- 0 XORs
  -- 16 NOTs
  -- 0 Adder
  -- 2 Subtracters
  -- 0 Comparators
  -- 0 Multiplexers



