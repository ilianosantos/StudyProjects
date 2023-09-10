LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity mux2_1 is 
port(
	A, B: in std_logic_vector (3 downto 0);
	S: in std_logic;
	R: out std_logic_vector (3 downto 0)
);
end mux2_1;

architecture mux2_1 of mux2_1 is

begin
R(0) <= (A(0) and S) or (B(0) and not S);
R(1) <= (A(1) and S) or (B(1) and not S);
R(2) <= (A(2) and S) or (B(2) and not S);
R(3) <= (A(3) and S) or (B(3) and not S);
end mux2_1;