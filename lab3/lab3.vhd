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
	signal wnotr: std_logic_vector(2 downto 0):="000";
	signal add: std_logic_vector (3 downto 0):="0000"; 
  type rows is array(2 downto 0) of std_logic_vector(7 downto 0);
	signal row : rows;
	signal enoughData : std_logic;
	signal totalRow : unsigned(3 downto 0);

	



begin
	  mem_1 : entity work.mem(main) port map (
		  address  => add,
		  clock    => clk,
		  data     => i_data,
		  wren     => wnotr(0),
		  q        => row(0)
		);
  
  mem_2 : entity work.mem(main)
    port map (
	  address  => add,
	  clock    => clk,
	  data     => i_data,
	  wren     => wnotr(1),
	  q        => row(1)
    );
  
  mem_3 : entity work.mem(main)
    port map (
	  address  => add,
	  clock    => clk,
	  data     => i_data,
	  wren     => wnotr(2),
	  q        => row(2)
    );

main : process
begin
	wait until rising_edge(clk);
	if(i_valid and not reset) then
			add <= add + 1;
	end if;
end process;

control : process 
begin
	wait until rising_edge(clk);
	-- reset or done table
	if(reset = '1' or totalRow = to_unsigned(15)) then
		wnotr <= "001";
		add <= "0000";
		enoughData <= "0";
		totalRow <= "0000";
	--enough data
	elsif(totalRow = to_unsigned(2)) then
		enoughData <= "1";
	end if;
end process;

wrcontrol : process
begin
	wait until rising_edge(clk);
	--finished writing to a row need to reset and change wren
	if(add="1111") then
		add <= "0000";
		totalRow <= totalRow + 1; 
		case wnotr is
			when "001" =>
				wnotr <= "010";
			when "010" =>
				wnotr <= "100";
			when others =>
				wnotr <= "001";
		end case;
	end if;
end process;
--once you have enough data will always be writing to 'c'
arithmetic : process
begin
	if(i_valid and not reset and enoughData) then
		case wnotr is
			when "001" =>
				if(row(1) + row(2) - row(0) >=0) then
				 	count <= count+1;
				end if;
			when "010" =>
				if(row(2) + row(0) - row(1) >= 0) then
					count <= count+1;
				end if;
			when "100" =>
				if(row(0) + row(1) - row(2)>=0) then
					count <= count+1;
				end if;
			when others =>
				count <= count;
			end case;
	end if;
end process;

o_data <= count;
  
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
