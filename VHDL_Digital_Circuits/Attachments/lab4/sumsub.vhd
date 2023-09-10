LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity sumsub is
port (
A : in std_logic_vector(3 downto 0);
B : in std_logic_vector(3 downto 0);
CBi : in std_logic;
OPau: in std_logic;
S : out std_logic_vector(3 downto 0);
B3xor, Below : out std_logic
);
end sumsub;

architecture sumsub of sumsub is

component adder
port(
		A : in std_logic_vector(3 downto 0);
		B : in std_logic_vector(3 downto 0);
		CYi : in std_logic;
		S : out std_logic_vector(3 downto 0);
		C4: out std_logic
	);
end component;

signal term: std_logic_vector(3 downto 0);
signal C0, term5, term6: std_logic;
begin
	
	term(0) <= B(0) xor OPau;
	term(1) <= B(1) xor OPau;
	term(2) <= B(2) xor OPau;
	term(3) <= B(3) xor OPau;

	C0 <= CBi xor OPau;
	term6 <= term5 xor OPau;

	adder0: adder port map (
			A => A,
			B(0) => term(0),
			B(1) => term(1),
			B(2) => term(2),
			B(3) => term(3),
			CYi => C0,
			S => S,
			C4 => term5
);
			Below <= term6;
			B3xor <= term(3);
					
end sumsub;

