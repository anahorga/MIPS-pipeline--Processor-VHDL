----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2024 04:37:07 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;


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

entity ALU is
  Port (  
          ALUSrc : in STD_LOGIC;
          RegDst : in STD_LOGIC;
             RD1 : in STD_LOGIC_VECTOR (31 downto 0);        
             RD2 : in STD_LOGIC_VECTOR (31 downto 0);        
             Ext_Imm : in STD_LOGIC_VECTOR (31 downto 0);        
             sa : in STD_LOGIC_VECTOR (4 downto 0);        
             rt : in STD_LOGIC_VECTOR (4 downto 0);        
             rd : in STD_LOGIC_VECTOR (4 downto 0);        
             rWA : out STD_LOGIC_VECTOR (4 downto 0);        
             func : in STD_LOGIC_VECTOR (5 downto 0);        
             ALUOp : in STD_LOGIC_VECTOR (2 downto 0);        
             PcPlus4 : in STD_LOGIC_VECTOR (31 downto 0);                    
             ALURes : out STD_LOGIC_VECTOR (31 downto 0);                    
             BranchAdress : out STD_LOGIC_VECTOR (31 downto 0);                    
             Zero : out STD_LOGIC;                    
             NotZero : out STD_LOGIC                    
   );
end ALU;

architecture Behavioral of ALU is
signal iesire_mux: std_logic_vector(31 downto 0):=(others=>'0');
signal C: std_logic_vector(31 downto 0):=(others=>'0');--iesire alu
signal Alu_Ctrl: std_logic_vector(2 downto 0):=(others=>'0');
begin

ALUControl:process(ALUOp,func)
begin

   case ALUOp is 
   when "000"=>
        case func is
              when "000001" => Alu_Ctrl<="001";--add cod adunare
              when "000010" => Alu_Ctrl<="010";--sub cod minus
              when "000011" => Alu_Ctrl<="110";--sll  
              when "000100" => Alu_Ctrl<="111";--slr
              when "000101" => Alu_Ctrl<="000";--and
              when "000110" => Alu_Ctrl<="011";--sau  cod sau
              when "000111" => Alu_Ctrl<="100";-- mult
              when others => Alu_Ctrl<="101";--xor
              end case;
   when "001"=>Alu_Ctrl<="001"; --adunare
   when "010"=>Alu_Ctrl<="010";-- minus
   when others=>Alu_Ctrl<="011";--sau
   end case;
              
end process;

process(ALUSrc)
begin
     if(ALUSrc='0')then
        iesire_mux<=RD2;
     else
         iesire_mux<=Ext_imm;
     end if;
end process;

BranchAdress <= PcPlus4 + (Ext_Imm(29 downto 0)&"00");

Operatii:process(Alu_Ctrl)
begin
    case Alu_Ctrl is 
    when "001"=>C<=RD1+iesire_mux;
    when "010"=>C<=RD1-iesire_mux;
    when "011"=>C<=RD1 or iesire_mux;
    when "000"=>C<=RD1 and iesire_mux;
    when "100"=>C<=RD1(15 downto 0)*iesire_mux(15 downto 0);
    when "101"=>C<=RD1 xor iesire_mux;
    when "110"=>C<=to_stdlogicvector( to_bitvector(iesire_mux) sll conv_integer(sa) );--sll
    when others=>C<=to_stdlogicvector( to_bitvector(iesire_mux) srl conv_integer(sa) );--slr
    end case;
 
 end process;
Alu_comapare:process(C)
begin
     if(C=X"00000000")then
        Zero<='1';
        NotZero<='0';
     else
         NotZero<='1';
         Zero<='0';
     end if;
end process;

process(RegDst)
begin
    if(RegDst='0')then
       rWA<=rt;
    else
        rWA<=rd;
        end if;
end process;
ALURes<=C;
end Behavioral;
