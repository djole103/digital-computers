library ieee;
use ieee.std_logic_1164.all;

entity sum is
       port ( i_a, i_b, i_cin : in std_logic;
              o_sum :       out std_logic
       );
end sum;

architecture main of sum is
BEGIN
	o_sum <= i_a xor i_b xor i_cin;

end architecture;

-- question 1
  -- we have pins i_cin and i_a being inputted into logical xor block ix1.
  -- output of this and the i_b pin are being fed into logical xor block ix3.
  -- the output of ix3 is o_sum
