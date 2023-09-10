LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity flags is
port (
A3 : in std_logic;
B3 : in std_logic;
R3 : in std_logic;
iCBo : in std_logic;
OVo: out std_logic;
CBo : out std_logic
);
end flags;

architecture flags of flags is
begin
	OVo <= (A3 and B3 and not R3) or (not A3 and not B3 and R3);
	CBo <= iCBo;
end flags;
