library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab3 is
  port (
    clk       : in  std_logic;             -- the system clock
    reset     : in  std_logic;             -- reset
    i_valid   : in  std_logic;             -- input data is valid
    i_data    : in  unsigned(7 downto 0);  -- input data
    o_data    : out unsigned(7 downto 0)   -- output data
  );
end entity lab3;

architecture main of lab3 is
	signal mem1_add : unsigned(7 downto 0);
	signal mem1_data : unsigned(7 downto 0);
	signal mem1_out : unsigned(7 downto 0);
	signal mem2_add : unsigned(7 downto 0);
	signal mem2_data : unsigned(7 downto 0);
	signal mem2_out : unsigned(7 downto 0);
	signal mem3_add : unsigned(7 downto 0);
	signal mem3_data : unsigned(7 downto 0);
	signal mem3_out : unsigned(7 downto 0);
  -- A function to rotate left (rol) a vector by n bits
  function "rol" ( a : std_logic_vector; n : natural )
    return std_logic_vector
  is
  begin
    return std_logic_vector( unsigned(a) rol n );
  end function;



begin
  
  mem_1 : entity work.mem(main)
    port map (
	  address  => mem1_add,
	  clock    => clk,
	  data     => i_data,
	  wren     => i_valid,
	  q        => mem1_out,
    );
  
  mem_2 : entity work.mem(main)
    port map (
	  address  => mem2_add,
	  clock    => clk,
	  data     => i_data,
	  wren     => i_valid,
	  q        => mem2_out,
    );
  
  mem_3 : entity work.mem(main)
    port map (
	  address  => mem3_add,
	  clock    => clk,
	  data     => i_data,
	  wren     => i_valid,
	  q        => mem3_out,
    );

a <= "00000000";
b <= "10000000";
c <= i_data;


sub1 <= a - b;

main : process 
begin
	wait until rising_edge(clk);
	r2 <= c;
	r1 <= sub1;
	wait until rising_edge(clk);
	r3 <= r1+r2;


    --c need to be registered
	--grab bytes from reg for a, b, c
	
	
end process;

o_data <= r3;
  
end architecture main;

-- Q1: number of flip flops and lookup tables?
--

-- Q2: maximum clock frequency?
--

-- Q3: source and destination signals of critical path?
-- 

-- Q4: does your implementation function correctly?  If not,
-- explain bug and how you would fix it if you had more time.
-- 
