library IEEE;
use IEEE.std_logic_1164.all;

entity logic_module is
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	OP:in std_logic_vector(1 downto 0);
	R: out std_logic_vector(3 downto 0);
	CY: out std_logic
);
end logic_module;


architecture logic_module of logic_module is
component lsr
port(
	A: in std_logic_vector(3 downto 0);
	Y: in std_logic_vector(1 downto 0);
	R: out std_logic_vector(3 downto 0);
	CY: out std_logic
	);
end component;

component asr
port(
	A: in std_logic_vector(3 downto 0);
	Y: in std_logic_vector(1 downto 0);
	R: out std_logic_vector(3 downto 0);
	CY: out std_logic
	);
end component;

component orr
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	R: out std_logic_vector(3 downto 0)
	);
end component;

component xnorr
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	R: out std_logic_vector(3 downto 0)
	);
end component;

component mux4_4_1
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	C: in std_logic_vector(3 downto 0);
	D: in std_logic_vector(3 downto 0);
	S: in std_logic_vector(1 downto 0);
	R: out std_logic_vector(3 downto 0)
);
end component;

signal term0, term1, term2, term3 : std_logic_vector(3 downto 0);
signal cy0, cy1 : std_logic;

begin

lsr0: lsr port map(
		A=>A,
		Y(0)=>B(0),
		Y(1)=>B(1),
		R=>term0,
		CY=>cy0
);

asr0: asr port map(
		A=>A,
		Y(0)=>B(0),
		Y(1)=>B(1),
		R=>term1,
		CY=>cy1
);

or0: orr port map(
		A=>A,
		B=>B,
		R=>term2
);

xnor0: xnorr port map(
		A=>A,
		B=>B,
		R=>term3
);

mux4bits: mux4_4_1 port map(
	A=> term0,
	B=> term1,
	C=> term2,
	D=> term3,
	S=> OP,
	R=> R
);

CY <= (cy0 and not OP(0)) or (cy1 and OP(0));
end logic_module;