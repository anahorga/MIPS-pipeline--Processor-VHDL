----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2024 04:28:56 PM
-- Design Name: 
-- Module Name: IFetch - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFetch is
     Port (clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
            rst:in std_logic;--butonul 0 MPG        
           jump: in STD_LOGIC;
           pcSrc: in STD_LOGIC;
            instruction: out std_logic_vector(31 downto 0);
            pc4: out std_logic_vector(31 downto 0);
            jumpAdress: in std_logic_vector(31 downto 0);
            branchAdress: in std_logic_vector(31 downto 0)
           );
end IFetch;

architecture Behavioral of IFetch is

 type rom_array is array (0 to 31) of std_logic_vector(31 downto 0);

 signal mem_ROM : rom_array:=(
         0 => B"000000_00000_00000_00001_00000_000001",--instr X"00000801" Add $1,$0,$0   initializeaza contorul buclei la 0     
         1  => B"001001_00000_00100_0000000000001010", --instr X"2404000A" Addi $4,$0,10  numarul maxim de iteratii      
         2 => B"000000_00000_00000_00010_00000_000001",--instr X"00001001" Add $2,$0,$0   initializarea indexului locatiei de memorie         
         3=> B"000000_00000_00000_00101_00000_000001",--instr X"00002801" Add $5,$0,$0   initializarea sumei la 0         
         4=> B"001100_00100_00001_0000000000001110",--instr X"3081000E" Beq $4,$1,14    daca s-au facut 10 iteratii sarim in afara buclei 
         5 =>  B"000000_00000_00000_00000_00000_000001",--noop "00000001"
         6 =>   B"000000_00000_00000_00000_00000_000001",--noop
         7 =>    B"000000_00000_00000_00000_00000_000001", --noop               
         8=> B"001010_00010_00011_0000000000001010",--instr X"2843000A"  Lw $3,10($2)  in $3 se aduce elemntul curent din sir (sirul in memorie incepe de la adresa 10)                
         9 =>   B"000000_00000_00000_00000_00000_000001",--noop
         10 =>   B"000000_00000_00000_00000_00000_000001", --noop 
         11=> B"000000_00000_00011_00011_00010_000011",--instr X"00031883"  Sll $3,$3,2  elementul curent*4                 
         12=> B"001011_00010_00011_0000000000001010",--instr X"2C43000A" Sw $3,10($2)  salvam noua valoare in memorie  
         13 =>   B"000000_00000_00000_00000_00000_000001", --noop              
         14=> B"000000_00101_00011_00101_00000_000001",--instr X"00A32801" Add $5,$5,$3  aduagam noua valoare in suma                
         15=> B"001001_00010_00010_0000000000000100",--instr X"24420004"  Addi $2,$2,4   trecem la uramtorul element din sir                
          16=> B"001001_00001_00001_0000000000000001",--instr X"24210001" Addi $1,$1,1  crestem contorul buclei              
          17=> B"001111_00000000000000000000000100",--instr X"3C000004" J 4  revenim la instr de branch  
          18 =>  B"000000_00000_00000_00000_00000_000001",--noop                
         others=> B"001011_00000_00101_0000000000110010"--instr X"2C050032" Sw $5,50($0) daca am ajuns la final salvam suma, in memorie, la adresa 50                
   
 );

signal Pc: std_logic_vector(31 downto 0):=(others=>'0');--iesirePC
signal pcIn: std_logic_vector(31 downto 0):=(others=>'0');--iesireMux2 sau intrare PC
signal pcPlus4: std_logic_vector(31 downto 0):=(others=>'0');
signal iesireMux1: std_logic_vector(31 downto 0):=(others=>'0');--iesireMux1
signal rst3:std_logic;--butonul 3 MPG
begin



rst3<=btn(3);


process(clk,rst,rst3)
begin
    
    if rst3 ='1' then 
         Pc<=X"00000000"; 
     else if rising_edge(clk) then
               if rst='1' then
                   Pc <= pcIn;
               end if;
           end if;
     end if;

end process;
pcPlus4<=Pc+4;
instruction<=mem_ROM(conv_integer(Pc(6 downto 2)));

process(jump)
begin 

  if jump='1'then
     pcIn<=jumpAdress;
     else pcIn<=iesireMux1; 
  end if;
  end process;
 
 process(pcSrc)
  begin 
  
    if pcSrc='1'then
       iesireMux1<=branchAdress;
       else 
         iesireMux1<=pcPlus4;
    end if;     

end process;

pc4<=pcPlus4;

end Behavioral;
