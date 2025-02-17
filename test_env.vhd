----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/29/2024 05:12:33 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is
signal s: std_logic_vector(31 downto 0):=(others=>'0');--il folosesc ca sa afisez ceva pe ssd

signal jump: STD_LOGIC;
signal RegWr: STD_LOGIC;
signal ExtOp: STD_LOGIC;
signal RegDst: STD_LOGIC;
signal ALUSrc: STD_LOGIC;
signal ALUOp: std_logic_vector(2 downto 0):=(others=>'0');
signal switch: std_logic_vector(2 downto 0):=(others=>'0');
signal MemtoReg: STD_LOGIC;
signal MemWrite: STD_LOGIC;
signal RD1: std_logic_vector(31 downto 0):=(others=>'0');
--signal func_ext: std_logic_vector(31 downto 0):=(others=>'0');
--signal sa_ext: std_logic_vector(31 downto 0):=(others=>'0');
signal RD2: std_logic_vector(31 downto 0):=(others=>'0');
signal WD: std_logic_vector(31 downto 0):=(others=>'0');
signal sa: std_logic_vector(4 downto 0):=(others=>'0');
signal func: std_logic_vector(5 downto 0):=(others=>'0');
signal rt: std_logic_vector(4 downto 0):=(others=>'0');
signal rd: std_logic_vector(4 downto 0):=(others=>'0');
signal ext_imm: std_logic_vector(31 downto 0):=(others=>'0');
signal branch: STD_LOGIC;
signal branch_not: STD_LOGIC;
signal rst: STD_LOGIC;--pt buton mpg/enable
signal rWA :  STD_LOGIC_VECTOR (4 downto 0);

            
    signal    pcSrc:  STD_LOGIC;
    signal    zero:  STD_LOGIC;
    signal    not_zero:  STD_LOGIC;
     signal    instruction:  std_logic_vector(31 downto 0);
      signal   pcPLus4:  std_logic_vector(31 downto 0);
     signal   jumpAdress:  std_logic_vector(31 downto 0);
     signal  branchAdress:  std_logic_vector(31 downto 0);
     signal  ALURes:  std_logic_vector(31 downto 0);
     signal  ALUResout:  std_logic_vector(31 downto 0);
     signal  MemData:  std_logic_vector(31 downto 0);
     
     
     --semnale registre pipeline
     signal instr_IF_ID: std_logic_vector(31 downto 0);
     signal PCPlus4_IF_ID: std_logic_vector(31 downto 0);
     
     signal rt_ID_EX: std_logic_vector(4 downto 0);
      signal rd_ID_EX: std_logic_vector(4 downto 0);
      signal RegDst_ID_EX: std_logic;
      signal ALUSrc_ID_EX: std_logic;
      signal Branch_ID_EX: std_logic;
      signal BranchNot_ID_EX: std_logic;
      signal ALUOp_ID_EX: std_logic_vector(2 downto 0);
      signal MemWr_ID_EX: std_logic;
      signal MemtoReg_ID_EX: std_logic;
      signal RegWr_ID_EX: std_logic;
     signal RD1_ID_EX: std_logic_vector(31 downto 0);
     signal RD2_ID_EX: std_logic_vector(31 downto 0);
     signal ExtImm_ID_EX: std_logic_vector(31 downto 0);
     signal func_ID_EX: std_logic_vector(5 downto 0);
     signal sa_ID_EX: std_logic_vector(4 downto 0);
     signal PCPlus4_ID_EX: std_logic_vector(31 downto 0);
     
     signal Branch_EX_MEM: std_logic;
           signal BranchNot_EX_MEM: std_logic;
           signal MemWr_EX_MEM: std_logic;
           signal MemtoReg_EX_MEM: std_logic;
           signal RegWr_EX_MEM: std_logic;
           signal Zero_EX_MEM:std_logic;
           signal NotZero_EX_MEM:std_logic;
           signal BrAddr_EX_MEM:std_logic_vector(31 downto 0);
           signal AluRes_EX_MEM:std_logic_vector(31 downto 0);
           signal RD2_EX_MEM:std_logic_vector(31 downto 0);
           signal Wa_EX_MEM:std_logic_vector(4 downto 0);
      
     signal Wa_MEM_WB:std_logic_vector(4 downto 0);
      signal MemtoReg_MEM_WB: std_logic;
      signal RegWr_MEM_WB: std_logic;
      signal AluRes_MEM_WB:std_logic_vector(31 downto 0);
      signal MemData_MEM_WB:std_logic_vector(31 downto 0);

component IFetch is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);               
           jump: in STD_LOGIC;
            pcSrc: in STD_LOGIC;
            instruction: out std_logic_vector(31 downto 0);
            pc4: out std_logic_vector(31 downto 0);
            jumpAdress: in std_logic_vector(31 downto 0);
            branchAdress: in std_logic_vector(31 downto 0)
           );
 end component;
 
 component UnitateControl is
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
 end component;
 
 component InstrDecode is
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
 end component;
 
 component ALU is
   Port (  
           ALUSrc : in STD_LOGIC;
            RegDst : in STD_LOGIC;
              RD1 : in STD_LOGIC_VECTOR (31 downto 0);        
              RD2 : in STD_LOGIC_VECTOR (31 downto 0);        
              Ext_Imm : in STD_LOGIC_VECTOR (31 downto 0);        
              sa : in STD_LOGIC_VECTOR (4 downto 0);        
              func : in STD_LOGIC_VECTOR (5 downto 0);        
              ALUOp : in STD_LOGIC_VECTOR (2 downto 0);        
              PcPlus4 : in STD_LOGIC_VECTOR (31 downto 0);                    
              ALURes : out STD_LOGIC_VECTOR (31 downto 0);                    
              BranchAdress : out STD_LOGIC_VECTOR (31 downto 0);                    
              Zero : out STD_LOGIC;                    
              NotZero : out STD_LOGIC;    
              rWA : out STD_LOGIC_VECTOR (4 downto 0);
              rt : in STD_LOGIC_VECTOR (4 downto 0);        
               rd : in STD_LOGIC_VECTOR (4 downto 0)                
    );
 end component;
 
 component ram_wr_1st is
     Port ( clk : in STD_LOGIC;
            MemWrite : in STD_LOGIC;
            En : in STD_LOGIC;--buton
            ALUResin : in STD_LOGIC_VECTOR (31 downto 0);
            WriteData : in STD_LOGIC_VECTOR (31 downto 0);
            ReadData : out STD_LOGIC_VECTOR (31 downto 0);
            ALUResout : out STD_LOGIC_VECTOR (31 downto 0));
 end component;

begin
jumpAdress<=PCPlus4_IF_ID(31 downto 28)&instr_IF_ID(25 downto 0)& "00";
pcSrc<=(Branch_EX_MEM and Zero_EX_MEM) or (BranchNot_EX_MEM and NotZero_EX_MEM);
instructionFetch:IFetch port map
(
    clk=>clk,
    btn=>btn,
    rst=>rst,
    jump=>jump,
      pcSrc=>    pcSrc,
      instruction=>    instruction,
       pc4=>   pcPLus4,
       jumpAdress=>   jumpAdress,
       branchAdress=>   BrAddr_EX_MEM
);
button:entity WORK.mpg port map
(
btn=>btn(0),
clk=>clk,
en=>rst
);
display:entity WORK.ssd port map
(
   clk=>clk,
   cat=>cat,
   an=>an,
   data=>s
);

UC:UnitateControl port map
(
    instr =>instr_IF_ID(31 downto 26),
                    
            RegDst=>RegDst,
            ExtOp=>ExtOp,
            ALUSrc=>ALUSrc,
            Branch=>branch,
            BranchNot=>branch_not,
            Jump=>jump,
            ALUOp=>ALUOp,
            MemtoReg=>MemtoReg,
            MemWrite=>MemWrite,
            RegWrite=>RegWr
    
);

ID:InstrDecode port map
(
    clk =>clk,
            instr =>instr_IF_ID(25 downto 0),        
            RegWrite=>RegWr_MEM_WB,
            en=>rst,
            rt=>rt,
             rd=>rd,
             Wa=>Wa_MEM_WB,
             ExtOp=>ExtOp,
             WD=>WD,
             RD1=>RD1,
             RD2=>RD2,
             EXT_IMM=>ext_imm,
             func=>func,
             sa=>sa
);

EX:ALU port map
(
       ALUSrc =>ALUSrc_ID_EX,
       RegDst =>RegDst_ID_EX,
         RD1 =>RD1_ID_EX,        
         RD2 =>RD2_ID_EX,       
          Ext_Imm =>ExtImm_ID_EX,        
          sa =>sa_ID_EX,        
          func =>func_ID_EX,        
          ALUOp =>ALUOp_ID_EX,        
         PcPlus4 =>PCPlus4_ID_EX,                    
          ALURes =>ALURes,                    
          BranchAdress =>branchAdress,                    
          Zero =>zero,                    
           NotZero =>not_zero,
           rWA=>rWA,
           rt=>rt_ID_EX,
           rd=>rd_ID_EX
);
MEM:ram_wr_1st port map
(
           clk =>clk,
            MemWrite =>MemWr_EX_MEM,
            En =>rst,--buton
            ALUResin =>AluRes_EX_MEM,
            WriteData =>RD2_EX_MEM,
            ReadData =>MemData,
            ALUResout =>ALUResout
);

process(MemtoReg_MEM_WB)
begin
     if(MemtoReg_MEM_WB='1') then 
        WD<=MemData_MEM_WB;
     else
         WD<=AluRes_MEM_WB;
     end if;   
end process;

--aici setam in registre
process(clk)
begin
     if(rising_edge(clk))then
        if(rst='1')then
           instr_IF_ID<=instruction;
           PCPlus4_IF_ID<=pcPLus4;
           
            rt_ID_EX<=rt;
                  rd_ID_EX<=rd;
                  RegDst_ID_EX<=RegDst;
                  ALUSrc_ID_EX<=ALUSrc;
                  Branch_ID_EX<=branch;
                  BranchNot_ID_EX<=branch_not;
                  ALUOp_ID_EX<=ALUOp;
                  MemWr_ID_EX<=MemWrite;
                  MemtoReg_ID_EX<=MemtoReg;
                  RegWr_ID_EX<=RegWr;
                 RD1_ID_EX<=RD1;
                 RD2_ID_EX<=RD2;
                 ExtImm_ID_EX<=ext_imm;
                 func_ID_EX<=func;
                 sa_ID_EX<=sa;
                 PCPlus4_ID_EX<=PCPlus4_IF_ID;
                 
                 Branch_EX_MEM<=Branch_ID_EX;
                  BranchNot_EX_MEM<=BranchNot_ID_EX;
                  MemWr_EX_MEM<=MemWr_ID_EX;
                  MemtoReg_EX_MEM<=MemtoReg_ID_EX;
                  RegWr_EX_MEM<=RegWr_ID_EX;
                  Zero_EX_MEM<=zero;
                  NotZero_EX_MEM<=not_zero;
                  BrAddr_EX_MEM<=branchAdress;
                  AluRes_EX_MEM<=ALURes;
                  RD2_EX_MEM<=RD2_ID_EX;
                  Wa_EX_MEM<=rWA;
                  
                  Wa_MEM_WB<=Wa_EX_MEM;
                   MemtoReg_MEM_WB<=MemtoReg_EX_MEM;
                  RegWr_MEM_WB<= RegWr_EX_MEM;
                   AluRes_MEM_WB<=ALUResout;
                  MemData_MEM_WB<=MemData;
                 
       end if;
      end if;
end process;


led(11 downto 0)<=ALUOp & RegDst & ExtOp & ALUSrc & branch & branch_not & jump & MemWrite & MemtoReg & RegWr;

switch<=sw(7 downto 5);

process(switch)
begin
case switch is
    when "000" => s<=instruction;
    when "001" => s<=pcPlus4;
    when "010" => s<=RD1;
    when "011" => s<=RD2;
    when "100" => s<=ext_imm;
    when "101" => s<=ALUResout;
    when "110" => s<=MemData;
    when others => s<=WD;
    
  end case;

end process;

end Behavioral;
