library IEEE;
use IEEE.std_logic_1164.all;

entity xnorr is
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	R: out std_logic_vector(3 downto 0)
);
end xnorr;

architecture xnorr of xnorr is
begin
R<= A xnor B;
end xnorr;