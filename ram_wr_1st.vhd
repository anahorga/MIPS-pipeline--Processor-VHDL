----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2024 12:31:44 PM
-- Design Name: 
-- Module Name: ram_wr_1st - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_wr_1st is
    Port ( clk : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           En : in STD_LOGIC;--buton
           ALUResin : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData : out STD_LOGIC_VECTOR (31 downto 0);
           ALUResout : out STD_LOGIC_VECTOR (31 downto 0));
end ram_wr_1st;

architecture Behavioral of ram_wr_1st is

type ram_type is array (0 to 63) of std_logic_vector(31 downto 0);
signal ram : ram_type := 
(
     10  => "00000000000000000000000000000001", 
     14  => "00000000000000000000000000000010",
     18  => "00000000000000000000000000000011",
     22 => "00000000000000000000000000000100",
     26 => "00000000000000000000000000000011",
     30 => "00000000000000000000000000000011",
     34 => "00000000000000000000000000000011",
     38 => "00000000000000000000000000000011",
     42 => "00000000000000000000000000000011",
     46 => "00000000000000000000000000000011",
     others => "00000000000000000000000000000000"
);
signal addr:std_logic_vector(5 downto 0);
begin

addr<=ALUResin(7 downto 2);
process(clk)
begin
    if rising_edge(clk) then
      IF En='1' THEN
        if MemWrite = '1' then
            ram(conv_integer(ALUResin)) <= WriteData;
            --ReadData<=WriteData;
       -- else
           --ReadData <= ram(conv_integer(ALUResin));
              
        end if;
      end if;
    end if;
    end process;
    ReadData <= ram(conv_integer(ALUResin));
    ALUResout<=ALUResin;  

end Behavioral;

