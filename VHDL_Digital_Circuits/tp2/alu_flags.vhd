LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity ALU_Flags is

port(
	iOV,iCB, CY, OP2: in std_logic;
	R: in std_logic_vector (3 downto 0);
	BE, GE, Z, OV, oCB: out std_logic
);
end ALU_Flags;

architecture arq_ALU_Flags of ALU_Flags is

begin
oCB <= (iCB and OP2) or (CY and not OP2);
OV <= iOV;
Z <= not (R(0) or R(1) or R(2) or R(3));
GE <= not (R(3) xor iOV);
BE <= iCB or (not (R(3) or R(2) or R(1) or R(0)));
end arq_ALU_Flags;