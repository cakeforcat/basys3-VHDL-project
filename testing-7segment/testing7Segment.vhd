----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.03.2022 10:20:48
-- Design Name: 
-- Module Name: testing7Segment - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testing7Segment is
    Port ( clk_in : in STD_LOGIC;
           anodes : out STD_LOGIC_VECTOR (0 to 3);
           seg : out STD_LOGIC_VECTOR (0 to 7);
--           DP : out STD_LOGIC;
           selectors : in STD_LOGIC_VECTOR (2 downto 0);
           reset : in STD_LOGIC);
end testing7Segment;

architecture Behavioral of testing7Segment is

    constant max_count : integer := 100000;    -- must count to this number to divide clock frequency from 100MHz to 8Hz.
    --constant max_count : integer := 5;           -- for simulation only (easier to check output!)
    
    -- internal signals
    signal clk : std_logic;
      
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
  
  segment: process (clk) is
    variable count : unsigned(1 downto 0) := "00"; 
  
  begin
    if rising_edge(clk) then
        if (reset = '1') then
            
        end if;
        count := count + 1;
        
    end if;
    
    case count is
        when "00" =>
            anodes <= "1110";
            seg <= "10011111";
        when "01" =>
            anodes <= "1101";
            seg <= "00001100";
        when "10" =>
            anodes <= "1011";
            seg <= "00000011";
        when "11" =>    
            anodes <= "0111";
            seg <= "00001100";
    end case;
  end process;
  
--  segment : process (clk) is
  
--  begin
--    case selectors is
    
--        when "001" =>
            
--        when "010" =>
        
--        when "100" =>
        
--        when others =>
    
--    end case;
  
--  end process;
    

end Behavioral;
