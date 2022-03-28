----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.03.2022 09:48:10
-- Design Name: 
-- Module Name: unsigned_to_display - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity unsigned_to_display is
    Port ( data : in STD_LOGIC_VECTOR (3 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC);
end unsigned_to_display;

architecture Behavioral of unsigned_to_display is

begin

process (data) is

variable digit : unsigned(3 downto 0):=unsigned(data);

begin

    case to_integer(digit) is
        when 0 =>
        CA<='0';
        CB<='0';
        CC<='0';
        CD<='0';
        CE<='0';
        CF<='0';
        CG<='1';
        when 1 =>
        CA<='1';
        CB<='0';
        CC<='0';
        CD<='1';
        CE<='1';
        CF<='1';
        CG<='1';
        when 2 =>
        CA<='0';
        CB<='0';
        CC<='1';
        CD<='0';
        CE<='0';
        CF<='1';
        CG<='0';
        when 3 =>
        CA<='0';
        CB<='0';
        CC<='0';
        CD<='0';
        CE<='1';
        CF<='1';
        CG<='0';
        when 4 =>
        CA<='1';
        CB<='0';
        CC<='0';
        CD<='1';
        CE<='1';
        CF<='0';
        CG<='0';
        when 5 =>
        CA<='0';
        CB<='1';
        CC<='0';
        CD<='0';
        CE<='1';
        CF<='0';
        CG<='0';
        when 6 =>
        CA<='0';
        CB<='1';
        CC<='0';
        CD<='0';
        CE<='0';
        CF<='0';
        CG<='0';
        when 7 =>
        CA<='0';
        CB<='0';
        CC<='0';
        CD<='1';
        CE<='1';
        CF<='1';
        CG<='1';
        when 8 =>
        CA<='0';
        CB<='0';
        CC<='0';
        CD<='0';
        CE<='0';
        CF<='0';
        CG<='0';
        when 9 =>
        CA<='0';
        CB<='0';
        CC<='0';
        CD<='0';
        CE<='1';
        CF<='0';
        CG<='0';
        when others =>
        CA<='1';
        CB<='1';
        CC<='1';
        CD<='1';
        CE<='1';
        CF<='1';
        CG<='0';
    end case;
    
end process;
end Behavioral;
