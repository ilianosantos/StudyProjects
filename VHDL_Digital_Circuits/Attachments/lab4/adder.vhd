LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity adder is
port (
A : in std_logic_vector(3 downto 0);
B : in std_logic_vector(3 downto 0);
CYi : in std_logic;
S : out std_logic_vector(3 downto 0);
C4: out std_logic
);
end adder;

architecture adder of adder is
component fulladder
port(
		A : in std_logic;
		B : in std_logic;
		CYi : in std_logic;
		R : out std_logic;
		CyOut: out std_logic
	);
end component;


signal term: std_logic_vector(2 downto 0);
begin 

fulladder0: fulladder port map (
				A=> A(0),
				B=> B(0),
				CYi=> CYi,
				R=> S(0),
				CyOut=> term(0)
);

fulladder1: fulladder port map (
				A=> A(1),
				B=> B(1),
				CYi=> term(0),
				R=> S(1),
				CyOut=> term(1)
);

fulladder2: fulladder port map (
				A=> A(2),
				B=> B(2),
				CYi=> term(1),
				R=> S(2),
				CyOut=> term(2)
);

fulladder3: fulladder port map (
				A=> A(3),
				B=> B(3),
				CYi=> term(2),
				R=> S(3),
				CyOut=> C4
);
end adder;