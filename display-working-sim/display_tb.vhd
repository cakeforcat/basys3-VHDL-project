----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2022 14:03:42
-- Design Name: 
-- Module Name: display_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_tb is
--  Port ( );
end display_tb;

architecture Behavioral of display_tb is
-- component declaration for UUT
    component display is
      Port ( selector : in STD_LOGIC_VECTOR (1 downto 0);
           clk_in   : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

-- signals required
signal selector : std_logic_vector(1 downto 0);
signal clk_in, CA, CB, CC, CD, CE, CF, CG, DP : std_logic;
signal AN : std_logic_vector (3 downto 0);
signal led : std_logic_vector (15 downto 0);


-- clock period
constant clk_period : time := 20 ns;
-- number of clock cycles to simulate
constant n_cycles : integer := 10000;

begin

  -- instantiation of display unit under test
  -----------------------------------------------
  UUT : display 
  port map(
    selector=>selector,
    clk_in=>clk_in,
    CA=>CA,
    CB=>CB,
    CC=>CC,
    CD=>CD,
    CE=>CE,
    CF=>CF,
    CG=>CG,
    DP=>DP,
    AN=>AN,
    led=>led);
    
    
   -- clock generator process
   ----------------------------  
   clk_gen : process is
   begin   
     while now <= (n_cycles*clk_period) loop        
         clk_in <= '1'; wait for clk_period/2;
         clk_in <= '0'; wait for clk_period/2;
       end loop;
	wait;    
   end process;
   
   
     -- stimulus process, to create all input signals apart from the clock
  ----------------------------------------------------------------------  
  stimulus : process is
   begin
     
     selector <= "00"; wait for 4 us; 
     selector <= "01"; wait for 4 us; 
     selector <= "10"; wait for 4 us; 
     selector <= "11"; wait for 4 us; 

     wait;
   end process;

end Behavioral;
