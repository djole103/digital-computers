------------------------------------------------------------------------
-- finite-impulse response filters
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.fir_synth_pkg.all;

entity fir is
  port(
    clk     : in  std_logic;
    i_data  : in  word;
    o_data  : out word
  );
end entity;

architecture avg of fir is

  signal tap0, tap1 , tap2 , tap3 , tap4
             , prod1, prod2, prod3, prod4
                    , sum2 , sum3 , sum4
       : word;

  constant coef1 : word := x"0400";
  constant coef2 : word := x"0400";
  constant coef3 : word := x"0400";
  constant coef4 : word := x"0400";
  
begin

  -- delay line of flops to hold samples of input data
  tap0 <= i_data;
  delay_line : process(clk)
  begin
    if (rising_edge(clk)) then
      tap1 <= tap0;
      tap2 <= tap1;
      tap3 <= tap2;
      tap4 <= tap3;
    end if;
  end process;
  
  -- simple averaging circuit
  --
  -- Note that mult is a quick 'n' dirty multiplier
  -- However, a multiplier is NOT built in hardware because one input is a particular
  --  constant allowing optimizations to be done.  If you had to multiply by 2 or 4 or 16
  --  in hardware could you do it WITHOUT any adders, shifters or multipliers?
  --
  prod1 <= mult( tap1, coef1);
  prod2 <= mult( tap2, coef2);
  prod3 <= mult( tap3, coef3);
  prod4 <= mult( tap4, coef4);

  sum2  <= prod1 + prod2;
  sum3  <= sum2  + prod3;
  sum4  <= sum3  + prod4;
  
  o_data <= sum4;

end architecture;

------------------------------------------------------------------------
-- low-pass filter
------------------------------------------------------------------------

architecture low_pass of fir is

  -- Use the signal names tap, prod, and sum, but change the type to
  -- match your needs.
  
  signal tap : word_vector(1 to num_taps);
  signal prod: word_vector(1 to num_taps);
  signal sum : word_vector(1 to num_taps-2);

  attribute logic_block of tap, prod, sum : signal is true;
  -- The attribute line below is usually needed to avoid a warning
  -- from PrecisionRTL that signals could be implemented using
  -- memory arrays.  

  
begin

  tap(1) <= i_data;

  delay_line : for i in 1 to num_taps-1 generate
	process(clk)
	begin
	  if (rising_edge(clk)) then
		tap(i+1) <= tap(i);
	  end if;
	end process;
  end generate delay_line;

  prod_process : for i in 1 to num_taps generate
	prod(i) <= mult( tap(i), lpcoef(i));
  end generate prod_process;

  
  sum(1) <= prod(1) + prod(2);

  sum_process : for i in 2 to num_taps-2 generate
	sum(i) <= sum(i-1) + prod(i+1);
  end generate sum_process;

  o_data <= sum(15);

end architecture;

-- question 2
  -- looking at the file lab2/RPT/area_logic.rpt we see that an adder with carry takes up 16 LUTs and on with no carry takes up 15 LUTs

-- question 3
  -- first we could not see any multipliers in the design because the compiler was getting rid of them in the optimization process but then we added a line o_data <= mult(i_data,i_data) to force a multiplier and commented everything else out. result was interesting. no LUTs were occupied by the multiplier
