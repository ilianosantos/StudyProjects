library IEEE;
use IEEE.std_logic_1164.all;

entity mux4_4_1 is
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	C: in std_logic_vector(3 downto 0);
	D: in std_logic_vector(3 downto 0);
	S: in std_logic_vector(1 downto 0);
	R: out std_logic_vector(3 downto 0)
);
end mux4_4_1;

architecture mux4_4_1 of mux4_4_1 is
begin
	R(0)<= (A(0) and not S(0) and not S(1)) or (B(0) and S(0) and not S(1)) or (C(0) and not S(0) and S(1)) or (D(0) and S(0) and S(1));
	R(1)<= (A(1) and not S(0) and not S(1)) or (B(1) and S(0) and not S(1)) or (C(1) and not S(0) and S(1)) or (D(1) and S(0) and S(1));
	R(2)<= (A(2) and not S(0) and not S(1)) or (B(2) and S(0) and not S(1)) or (C(2) and not S(0) and S(1)) or (D(2) and S(0) and S(1));
	R(3)<= (A(3) and not S(0) and not S(1)) or (B(3) and S(0) and not S(1)) or (C(3) and not S(0) and S(1)) or (D(3) and S(0) and S(1));
	end mux4_4_1;