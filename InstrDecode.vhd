----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 04:37:23 PM
-- Design Name: 
-- Module Name: InstrDecode - Behavioral
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

entity InstrDecode is
  Port (   clk : in STD_LOGIC;
           instr : in STD_LOGIC_VECTOR (25 downto 0);        
           RegWrite: in STD_LOGIC;
           en: in STD_LOGIC;
            ExtOp: in std_logic;
            WD: in std_logic_vector(31 downto 0);
            RD1: out std_logic_vector(31 downto 0);
            RD2: out std_logic_vector(31 downto 0);
            EXT_IMM:out std_logic_vector(31 downto 0);
            func:out std_logic_vector(5 downto 0);
            sa:out std_logic_vector(4 downto 0);
            rt:out std_logic_vector(4 downto 0);
            rd:out std_logic_vector(4 downto 0);
            Wa:in std_logic_vector(4 downto 0)
             );
end InstrDecode;

architecture Behavioral of InstrDecode is
component RF is
    Port ( clk : in STD_LOGIC;
            ra1 : in STD_LOGIC_VECTOR (4 downto 0);
            ra2 : in STD_LOGIC_VECTOR (4 downto 0);
            wa : in STD_LOGIC_VECTOR (4 downto 0);
           wd : in STD_LOGIC_VECTOR (31 downto 0);
            regwr : in STD_LOGIC;
            en : in STD_LOGIC;
           rd1 : out STD_LOGIC_VECTOR (31 downto 0);
            rd2 : out STD_LOGIC_VECTOR (31 downto 0));
 end component;
 
 
 
begin

reg_file: RF port map
(
    clk=>clk,
    ra1=>instr(25 downto 21),
    ra2=>instr(20 downto 16),
    wa=>Wa,
    regwr=>RegWrite,
    en=>en,
    wd=>WD,
    rd1=>RD1,
    rd2=>RD2
);


rt<=instr(20 downto 16);
rd<=instr(15 downto 11);
process(ExtOp)
begin
    if(ExtOp='1')then
       Ext_Imm<=instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15)&instr(15 downto 0);
    else
        Ext_Imm<=X"0000"&instr(15 downto 0);
        end if;
end process;

func<=instr(5 downto 0);
sa<=instr(10 downto 6);

end Behavioral;
