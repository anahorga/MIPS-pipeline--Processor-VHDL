----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 05:09:32 PM
-- Design Name: 
-- Module Name: UnitateControl - Behavioral
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

entity UnitateControl is
   Port (  
           instr : in STD_LOGIC_VECTOR (5 downto 0);
                   
           RegDst: out STD_LOGIC;
           ExtOp: out STD_LOGIC;
           ALUSrc: out STD_LOGIC;
           Branch: out STD_LOGIC;
           BranchNot: out STD_LOGIC;
           Jump: out STD_LOGIC;
           ALUOp: out STD_LOGIC_vector(2 downto 0);
           MemtoReg: out STD_LOGIC;
           MemWrite: out STD_LOGIC;
           RegWrite: out STD_LOGIC
       );
end UnitateControl;

architecture Behavioral of UnitateControl is

begin

process(instr)
 begin
     case instr is 
     --instr de tip R
     when "000000"=>RegDst<='1';RegWrite<='1';ALUSrc<='0';Branch<='0';BranchNot<='0';Jump<='0';MemtoReg<='0';MemWrite<='0';ALUOp<="000";ExtOp<='0';
     
     --instr de tip i-addi +
     when "001001"=>RegDst<='0';RegWrite<='1';ALUSrc<='1';Branch<='0';BranchNot<='0';Jump<='0';MemtoReg<='0';MemWrite<='0';ALUOp<="001";ExtOp<='1';
     --lw +
     when "001010"=>RegDst<='0';RegWrite<='1';ALUSrc<='1';Branch<='0';BranchNot<='0';Jump<='0';MemtoReg<='1';MemWrite<='0';ALUOp<="001";ExtOp<='1';
     --sw +
     when "001011"=>RegDst<='0';RegWrite<='0';ALUSrc<='1';Branch<='0';BranchNot<='0';Jump<='0';MemtoReg<='0';MemWrite<='1';ALUOp<="001";ExtOp<='1';
     --beq -
     when "001100"=>RegDst<='0';RegWrite<='0';ALUSrc<='0';Branch<='1';BranchNot<='0';Jump<='0';MemtoReg<='0';MemWrite<='0';ALUOp<="010";ExtOp<='1';
    --bne -
     when "001101"=>RegDst<='1';RegWrite<='0';ALUSrc<='0';Branch<='0';BranchNot<='1';Jump<='0';MemtoReg<='0';MemWrite<='0';ALUOp<="010";ExtOp<='1';
     --ori |
     when "001110"=>RegDst<='0';RegWrite<='1';ALUSrc<='1';Branch<='0';BranchNot<='0';Jump<='0';MemtoReg<='0';MemWrite<='0';ALUOp<="011";ExtOp<='0';
     
     --instr de tip j-jump
     when others=>RegDst<='0';RegWrite<='0';ALUSrc<='0';Branch<='0';BranchNot<='0';Jump<='1';MemtoReg<='0';MemWrite<='0';ALUOp<="000";ExtOp<='0';
    
     end case;
     
   
     
 end process; 

end Behavioral;
