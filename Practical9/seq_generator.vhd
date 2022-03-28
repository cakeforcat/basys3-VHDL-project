-----------------------------------------------------------------------------------
-- FILE:    seq_generator.vhd
--
-- DESCRIPTION:
-- This file implements an LED sequence generator design for the Basys-3 board. 
-- This board has 16 LED outputs, and there are 16 steps defined in the sequence.
-- *** ATTENTION  *** Note that the clock division ratio must be set differently
-- for simulation and synthesis.
-- There are initiall some sections left blank for students to complete.
--
-- AUTHOR: Louise Crockett, University of Strathclyde
-- DATE:   last modified January 2016
--
-----------------------------------------------------------------------------------


-------------------------------
-- library declarations --
-------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-------------------------------
-- entity declaration --
-------------------------------
entity seq_gen is
  port (clk_in : in std_logic;
        reset  : in std_logic;
        enable : in std_logic;
        LEDs   : out std_logic_vector(15 downto 0));
end entity seq_gen;

-------------------------------
-- architecture body --
-------------------------------
architecture arch of seq_gen is

-- constants 
-- ( *** make sure to comment one of these out depending on whether you are simulating or implementing! ***)
constant max_count : integer := 6250000;    -- must count to this number to divide clock frequency from 100MHz to 8Hz.
--constant max_count : integer := 5;           -- for simulation only (easier to check output!)

-- internal signals
signal clk : std_logic;                         -- this is the divided clock (i.e. frequency of 8Hz)


begin
  
  -- clock divider process
  ---------------------------------
  clk_divide : process (clk_in) is
  
  variable count : unsigned(22 downto 0):= to_unsigned(0,23);   -- required to count up to 6,250,000!
  variable clk_int : std_logic := '0';                          -- this is a clock internal to the process
  
  begin
    
    if rising_edge(clk_in) then
      
      if count < max_count-1 then     -- highest value count should reach is 6,249,999.
        count := count + 1;           -- increment counter
      else
        count := to_unsigned(0,23);   -- reset count to zero
        clk_int := not clk_int;       -- invert clock variable every time counter resets
      end if;
      
      clk <= clk_int;                 -- assign clock variable to internal clock signal
      
    end if;
    
  end process;
  
  
  -- sequence generator process - to be completed
  ------------------------------------------------
  sequence_generator : process (clk) is

  variable count : unsigned(3 downto 0) := "0000";   -- 16 steps in the sequence...
                                                     -- hence 4 bit counter required here
  
  
  begin
    
    -- reset counter, otherwise if enabled, increment count
    ---------------------------------------------------------
      
    if rising_edge(clk) then
      
      if (reset = '1') then
        
           count := "0000";
          
      elsif (enable = '1') then
        
           count := count + 1;
      
      end if;

    end if;

 
  
  -- use counter value to determine LED outputs
  ----------------------------------------------
  case to_integer(count) is 
    
    when 0 =>
    
        LEDs <= "0000001111000000";
        
    when 1 =>
        
        LEDs <= "0000011001100000";

    when 2 =>
    
        LEDs <= "0000110000110000";
    
    when 3 =>
    
        LEDs <= "0001100000011000";
      
    when 4 =>
    
        LEDs <= "0011000000001100"; 
      
    when 5 =>
    
        LEDs <= "0110000000000110";   
      
    when 6 =>
    
        LEDs <= "1100000000000011";       
        
    when 7 =>
    
        LEDs <= "1010000000000101"; 
        
    when 8 =>
    
        LEDs <= "0101000000001010"; 
        
    when 9 =>
    
        LEDs <= "0010100000010100";
        
    when 10 =>
    
        LEDs <= "0001010000101000";
        
    when 11 =>
    
        LEDs <= "0000101001010000";     
        
    when 12 =>
    
        LEDs <= "0000010110100000";   
        
    when 13 =>
    
        LEDs <= "0000001111000000";  
        
    when 14 =>
    
        LEDs <= "0000001111000000";  
    
    when 15 =>
        LEDs <= "0000010110100000";    
                
    when others =>
      
      LEDs <= (others => '1');   -- set all LEDs to ON if anything unexpected happens!
        
    end case;
    
  end process;
                 
end arch;