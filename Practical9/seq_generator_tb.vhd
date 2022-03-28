---------------------------------------------------------------------
-- FILE:    seq_generator_tb.vhd
--
-- DESCRIPTION:
-- This file is a testbench for the LED sequence generator design. 
-- Note that when simulating, the clock is divided only by a small 
-- ratio, to permit easy visualisation. Therefore, the time value 
-- 'sim_time' is defined for specifying stimulus patterns.
--
-- AUTHOR: Louise Crockett, University of Strathclyde
-- DATE:   last modified January 2016
--
---------------------------------------------------------------------


-------------------------------
-- library declarations --
-------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-------------------------------
-- entity declaration --
-------------------------------
entity seq_gen_tb is
end entity seq_gen_tb;

-------------------------------
-- architecture body --
-------------------------------
architecture arch of seq_gen_tb is

-- component declaration for UUT
component seq_gen is
  port (clk_in : in std_logic;
        reset  : in std_logic;
        enable : in std_logic;
        LEDs   : out std_logic_vector(15 downto 0));
end component;

-- signals required to test design
signal clk_in, reset, enable : std_logic;
signal LEDs : std_logic_vector(15 downto 0);

-- clock period - actual clock input is 100MHz (see just above the "Basys 3" logo on the board)
constant T_clk : time := 10 ns;
-- divided clock period (useful for specifying stimulus - short periods between changes)
constant sim_clk : time := 5 * T_clk;

-- number of clock cycles to simulate
constant n_cycles : integer := 10000;

begin
  
  -- instantiation of seq_gen, unit under test
  -----------------------------------------------
  UUT : seq_gen 
  port map(
    clk_in => clk_in,
    reset  => reset,
    enable => enable,
    LEDs   => LEDs);
  
  
  -- stimulus process, to create all input signals apart from the clock
  ----------------------------------------------------------------------  
  stimulus : process is
   
   begin
     
     reset <= '1'; enable <= '1'; wait for 2*sim_clk;		-- initial reset 
     
     -- *** complete the rest of the stimulus process ***
     -- ***  (add your code below these comments...)  ***
     
     reset <= '0'; enable <= '1'; wait for 10*sim_clk;
     	
     
     
     
     
     
     -- *************************************************
     

     wait;
     
   end process;
   
   
   -- clock generator process
   ----------------------------  
   clk_gen : process is
   
   begin
     
     while now <= (n_cycles*sim_clk) loop       
       
         clk_in <= '1'; wait for T_clk/2;
         clk_in <= '0'; wait for T_clk/2;
         
       end loop;
	
	wait;
       
   end process;
   
 end arch;
    
  