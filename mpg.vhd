----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2024 11:48:51 AM
-- Design Name: 
-- Module Name: mpg - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mpg is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           en : out STD_LOGIC);
end mpg;

architecture Behavioral of mpg is
signal counter:std_logic_vector(15 downto 0):=(others=>'0');
signal q1:std_logic;
signal q2:std_logic;
signal q3:std_logic;
begin
    en<=not(q3)and q2;
    process(clk)
    begin
       if clk'event and clk='1' then
          counter<=counter+1;
          if counter="1111111111111111" then
             q1<=btn;
          end if;
          q2<=q1;
          q3<=q2;
          end if;
          end process;

end Behavioral;
