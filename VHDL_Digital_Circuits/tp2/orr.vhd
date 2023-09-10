library IEEE;
use IEEE.std_logic_1164.all;

entity orr is
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	R: out std_logic_vector(3 downto 0)
);
end orr;

architecture orr of orr is
begin
R<= A or not B;
end orr;