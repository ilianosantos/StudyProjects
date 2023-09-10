library ieee;
use ieee.std_logic_1164.all;

entity countup is
port(	DataIn : in std_logic_vector(3 downto 0);
		CE, PL, CLK : in std_logic; 
		Q : out std_logic_vector(3 downto 0);
		TC : out std_logic
		);
end countup;

architecture countup of countup is
component reg4bits port(
		D : in std_logic_vector(3 downto 0);
		CLK, E : in std_logic; 
		Q : out std_logic_vector(3 downto 0)
);
end component;

component mux2_1 port(
	A, B: in std_logic_vector (3 downto 0);
	S: in std_logic;
	R: out std_logic_vector (3 downto 0)
);
end component;

component adder port (
A : in std_logic_vector(3 downto 0);
B : in std_logic_vector(3 downto 0);
CYi : in std_logic;
S : out std_logic_vector(3 downto 0);
C4: out std_logic
);
end component;


signal term0, term1, term2: std_logic_vector(3 downto 0);

begin

Adder0: adder port map(
	A(3) => '0',
	A(2) => '0',
	A(1) => '0',
	A(0) => CE,
	B => term0,
	CYi => '0',
	S => term1
);

Mux0: mux2_1 port map(
	A => DataIn,
	B => term1,
	S => PL,
	R => term2
);

reg0: reg4bits port map(
	D => term2,
	CLK => CLK,
	E => '1',
	Q => term0
);

--Final

Q <= term0;
TC <= term0(0) and term0(1) and term0(2) and term0(3);

end countup;
