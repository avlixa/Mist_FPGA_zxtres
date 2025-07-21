-- -----------------------------------------------------------------------
--
-- Syntiac's generic VHDL support files.
--
-- -----------------------------------------------------------------------
-- Copyright 2005-2008 by Peter Wendrich (pwsoft@syntiac.com)
-- http://www.syntiac.com/fpga64.html
--
-- Modified April 2016 by Dar (darfpga@aol.fr) 
-- http://darfpga.blogspot.fr
--   Remove address register when writing
--
-- -----------------------------------------------------------------------
--
-- dpram.vhd
--
-- -----------------------------------------------------------------------
--
-- generic ram.
--
-- -----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- -----------------------------------------------------------------------

entity dpram is
	generic (
		addr_width_g : integer := 10;
		data_width_g : integer := 8
	);
	port (
		clock_a : in std_logic;
		wren_a : in std_logic := '0';
		address_a : in std_logic_vector((addr_width_g-1) downto 0);
		data_a : in std_logic_vector((data_width_g-1) downto 0) := (others => '0');
		q_a : out std_logic_vector((data_width_g-1) downto 0);
		enable_a : in std_logic := '1';

		clock_b : in std_logic;
		wren_b : in std_logic := '0';
		address_b : in std_logic_vector((addr_width_g-1) downto 0);
		data_b : in std_logic_vector((data_width_g-1) downto 0) := (others => '0');
		q_b : out std_logic_vector((data_width_g-1) downto 0);
		enable_b : in std_logic := '1'
	);
end dpram;

-- -----------------------------------------------------------------------

architecture rtl of dpram is
	subtype addressRange is integer range 0 to ((2**addr_width_g)-1);
	type ramDef is array(addressRange) of std_logic_vector((data_width_g-1) downto 0);
	signal ram: ramDef;
	signal address_a_reg: std_logic_vector((addr_width_g-1) downto 0);
	signal address_b_reg: std_logic_vector((addr_width_g-1) downto 0);
begin

-- -----------------------------------------------------------------------
	process(clock_a)
	begin
		if rising_edge(clock_a) and enable_a = '1' then
			if wren_a = '1' then
				ram(to_integer(unsigned(address_a))) <= data_a;
			end if;
			q_a <= ram(to_integer(unsigned(address_a)));
		end if;
	end process;

	process(clock_b)
	begin
		if rising_edge(clock_b) and enable_b = '1' then
			if wren_b = '1' then
				ram(to_integer(unsigned(address_b))) <= data_b;
			end if;
			q_b <= ram(to_integer(unsigned(address_b)));
		end if;
	end process;
	
end rtl;

