----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.03.2022 10:20:44
-- Design Name: 
-- Module Name: display_test - Behavioral
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

entity display is
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
end display;

architecture Behavioral of display is

-- constants 
--constant disp_max_count : integer := 50000;    -- must count to this number to divide clock frequency from 100MHz to 1kHz.
constant disp_max_count : integer := 2;          -- simulation clock division 
--constant led_max_count  : integer := 6250000;    -- must count to this number to divide clock frequency from 100MHz to 8Hz.
constant led_max_count  : integer := 5;          -- simulation clock division
 
-- internal signals
signal disp_clk : std_logic;                         -- this is a ivided display clock
signal led_clk  : std_logic;                         -- this is a divided led clock
signal data     : STD_LOGIC_VECTOR (3 downto 0);     -- this is the currently displayed number
signal dot      : std_logic;                         -- display dot control

-- project member data
type display_array is array (3 downto 0) of STD_LOGIC_VECTOR (3 downto 0);
type led_sequence_array is array (15 downto 0) of STD_LOGIC_VECTOR (15 downto 0);

constant disp_jakub : display_array         := ("0000","0011","0000","0011");
constant led_jakub  : led_sequence_array    := ("1000000000000001",
                                                "0100000000000010",
                                                "0010000000000100",
                                                "0001000000001000",
                                                "0000100000010000",
                                                "0000010000100000",
                                                "0000001001000000",
                                                "0000000110000000",
                                                "0000001001000000",
                                                "0000010000100000",
                                                "0000100000010000",
                                                "0001000000001000",
                                                "0010000000000100",
                                                "0100000000000010",
                                                "1000000000000001",
                                                "0000000000000000");
                                            
constant disp_sultan : display_array        := ("0000","0001","0000","0001");
constant led_sultan  : led_sequence_array   := ("1010101010101010",
                                                "0101010101010101",
                                                "1010101010101010",
                                                "0101010101010101",
                                                "1010101010101010",
                                                "0101010101010101",
                                                "1010101010101010",
                                                "0101010101010101",
                                                "1010101010101010",
                                                "0101010101010101",
                                                "1010101010101010",
                                                "0101010101010101",
                                                "1010101010101010",
                                                "0101010101010101",
                                                "1010101010101010",
                                                "0101010101010101");
                                            
constant disp_ross  : display_array         := ("0001","0011","0000","0011");
constant led_ross   : led_sequence_array    := ("0000000110000000",
                                                "0000001111000000",
                                                "0000011111100000",
                                                "0000111111110000",
                                                "0001111111111000",
                                                "0011111111111100",
                                                "0111111111111110",
                                                "0111111111111110",
                                                "1111111111111111",
                                                "1111111001111111",
                                                "1111110000111111",
                                                "1111100000011111",
                                                "1111000000001111",
                                                "1110000000000111",
                                                "1100000000000011",
                                                "1000000000000001");
begin

translator : entity work.unsigned_to_display
    port map(data=>data, CA=>CA, CB=>CB, CC=>CC, CD=>CD, CE=>CE, CF=>CF, CG=>CG);


    -- clock divider process
---------------------------------
led_clk_divide : process (clk_in) is
  
variable led_count : unsigned(22 downto 0):= to_unsigned(0,23);       -- required to count up to 6,250,000!
variable led_clk_int  : std_logic := '0';                             -- this is a clock internal to the process

begin
    
    if rising_edge(clk_in) then
      
        if led_count < led_max_count-1 then     -- highest value count should reach is 6,249,999.
            led_count := led_count + 1;           -- increment AN
        else
            led_count := to_unsigned(0,23);   -- reset count to zero
            led_clk_int := not led_clk_int;       -- invert clock variable every time counter resets
        end if;
          
    led_clk <= led_clk_int;                 -- assign clock variable to internal clock signal
    
    end if;
    
end process;
  
  
disp_clk_divide : process (clk_in) is
  
variable disp_count : unsigned(22 downto 0):= to_unsigned(0,23);      -- required to count up to signal
variable disp_clk_int : std_logic := '0';                             -- this is a clock internal to the process

begin
    
    if rising_edge(clk_in) then

        if disp_count < disp_max_count-1 then     -- highest value count should reach is 100000.
            disp_count := disp_count + 1;           -- increment counter
        else
            disp_count := to_unsigned(0,23);   -- reset count to zero
            disp_clk_int := not disp_clk_int;       -- invert clock variable every time counter resets
        end if;
      
    disp_clk <= disp_clk_int;                 -- assign clock variable to internal clock signal
      
    end if;
    
end process;
  
segment : process (disp_clk, selector)
variable count  : unsigned(1 downto 0) := "00";
variable person : display_array := disp_jakub;
begin
    if rising_edge(disp_clk) then
        count := count +1;
    end if;
    
    case selector is 
        when "00" => 
            person := disp_jakub;
        when "01" => 
            person := disp_sultan;
--        when "10" => 
--            person := disp_sultan;
--        when "11" => 
--            person := disp_ross;
        when others =>
            person := disp_ross;
    end case;
    
    case count is
        when "00" =>
            AN <= "1110";
            data <= person(0);
            DP <= '1';
        when "01" =>
            AN <= "1101";
            data <= person(1);
            DP <= '1';
        when "10" =>
            AN <= "1011";
            data <= person(2);
            DP <= '0';
        when "11" =>    
            AN <= "0111";
            data <= person(3);
            DP <= '1';
        when others =>            -- for simulation
            AN <= "0111";
            data <= person(3);
            DP <= '1';
    end case;
    
end process;

led_sequence_generator : process (led_clk, selector) is
variable count : unsigned(3 downto 0) := "0000";
variable person : led_sequence_array := led_jakub;
begin
    if rising_edge(led_clk) then
        count := count +1;
    end if;
    
    case selector is 
        when "00" => 
            person := led_jakub;
        when "01" => 
            person := led_sultan;
--        when "10" => 
--            person := led_sultan;
--        when "11" => 
--            person := led_ross;
        when others =>
            person := led_ross;
    end case;
    
    case to_integer(count) is
    when 0 =>
        led <= person(0);
    when 1 =>
        led <= person(1);
    when 2 =>
        led <= person(2);
    when 3 =>
        led <= person(3);
    when 4 =>
        led <= person(4);
    when 5 =>
        led <= person(5);
    when 6 =>
        led <= person(6);
    when 7 =>
        led <= person(7);
    when 8 =>
        led <= person(8);
    when 9 =>
        led <= person(9);
    when 10 =>
        led <= person(10);
    when 11 =>
        led <= person(11);
    when 12 =>
        led <= person(12);
    when 13 =>
        led <= person(13);
    when 14 =>
        led <= person(14);
    when 15 =>
        led <= person(15);
    when others => 
        led <= "1111111111111111";
    end case;
end process;
end Behavioral;
