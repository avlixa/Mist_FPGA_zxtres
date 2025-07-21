-- ****
-- dpram - generic dpram to be used with xilinx cores
-- 
-- Copyright (c) 2025 AvlixA (avlixa@gmail.com)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--
-- Limitations :
--
-- File history :
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;

package dpram_Pack is

	component dpram
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
	end component;

end;
