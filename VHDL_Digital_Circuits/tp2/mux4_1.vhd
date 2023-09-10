library IEEE;
use IEEE.std_logic_1164.all;

entity mux4_1 is
port(
	A: in std_logic_vector(3 downto 0);
	S: in std_logic_vector(1 downto 0);
	R: out std_logic
);
end mux4_1;

architecture mux4_1 of mux4_1 is
begin
	R<= (A(0) and not S(0) and not S(1)) or (A(1) and S(0) and not S(1)) or (A(2) and not S(0) and S(1)) or (A(3) and S(0) and S(1));
end mux4_1;
