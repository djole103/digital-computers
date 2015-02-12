library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab3 is
  port (
    clk       : in  std_logic;             -- the system clock
    reset     : in  std_logic;             -- reset
    i_valid   : in  std_logic;             -- input data is valid
    i_data    : in  unsigned(7 downto 0);  -- input data
    o_data    : out unsigned(7 downto 0);   -- output data
		o_address : out std_logic_vector(3 downto 0);
		o_totalrow : out unsigned(3 downto 0);
		o_enoughdata : out std_logic;
		o_wnotr : out std_logic_vector(2 downto 0);
		o_count : out unsigned(7 downto 0)
  );
end entity lab3;

architecture main of lab3 is
	signal wnotr: std_logic_vector(2 downto 0):="000";
	signal add: std_logic_vector (3 downto 0):="0000"; 
  type rows is array(2 downto 0) of std_logic_vector(7 downto 0);
	signal row : rows;
	signal enoughData : std_logic;
	signal totalRow : unsigned(3 downto 0);
	signal count : unsigned(7 downto 0):="00000000";



begin

	o_address <= add;
	o_totalrow <= totalRow;
	o_enoughdata <= enoughData;
	o_count <= count;
	o_wnotr <= wnotr;
	o_data <= count; 
	mem_1 : entity work.mem(main) port map (
		address  => add,
		clock    => clk,
		data     => std_logic_vector(i_data),
		wren     => wnotr(0),
		q        => row(0)
	);
  
  mem_2 : entity work.mem(main) port map (
	  address  => add,
	  clock    => clk,
	  data     => std_logic_vector(i_data),
	  wren     => wnotr(1),
	  q        => row(1)
    );
  
  mem_3 : entity work.mem(main) port map (
	  address  => add,
	  clock    => clk,
	  data     => std_logic_vector(i_data),
	  wren     => wnotr(2),
	  q        => row(2)
    );


control : process 
begin
	wait until rising_edge(clk);
	-- reset or done table
	--count <= "00000111";
	if(reset = '1' or totalRow = 15) then
		wnotr <= "001";
		add <= "0000";
		enoughData <= '0';
		totalRow <= "0000";
		count <= "00000000";
	--enough data
	end if;
	if(totalRow = 2) then
		enoughData <= '1';
	end if;
	if(i_valid = '1' and reset = '0') then
			add <= std_logic_vector(unsigned(add)+1);
	end if;
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

counter : process
begin
	wait until rising_edge(clk);
	if(i_valid = '1' and reset = '0' and enoughData = '1') then
		case wnotr is
			when "001" =>
				if(signed(row(1)) + signed(row(2)) - signed(row(0)) >=0) then
				 	count <= count+1;
				end if;
			when "010" =>
				if(signed(row(2)) + signed(row(0)) - signed(row(1)) >= 0) then
					count <= count+1;
				end if;
			when "100" =>
				if(signed(row(0)) + signed(row(1)) - signed(row(2))>=0) then
					count <= count+1;
				end if;
			when others =>
				count <= count;
			end case;
	end if;
end process;

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
