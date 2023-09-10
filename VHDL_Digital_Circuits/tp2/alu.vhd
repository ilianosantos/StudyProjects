library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
port(
	W: in std_logic_vector(3 downto 0);
	Y: in std_logic_vector(3 downto 0);
	OP:in std_logic_vector(2 downto 0);
	CBi: in std_logic;
	F: out std_logic_vector(3 downto 0);
	BE, GE, Z, OV, CBo: out std_logic
);
end alu;

architecture alu of alu is
component au 
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	CBi, OPau: in std_logic;
	R: out std_logic_vector(3 downto 0);
	OV, CBo: out std_logic
);
end component;

component logic_module
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	OP:in std_logic_vector(1 downto 0);
	R: out std_logic_vector(3 downto 0);
	CY: out std_logic
);
end component;

component alu_flags
port(
	iOV,iCB, CY, OP2: in std_logic;
	R: in std_logic_vector (3 downto 0);
	BE, GE, Z, OV, oCB: out std_logic
);
end component;

component mux2_1 is
port(
	A, B: in std_logic_vector (3 downto 0);
	S: in std_logic;
	Y: out std_logic_vector (3 downto 0)
);
end component;


signal term0, term3, term5, term6:std_logic_vector(3 downto 0);
signal term1, term2, term4: std_logic;
begin

term6(0)<= Y(0) and OP(1);
term6(1)<= Y(1) and OP(1);
term6(2)<= Y(2) and OP(1);
term6(3)<= Y(3) and OP(1);

au0: au port map(
	A=> W,
	B=>term6,
	CBi=> CBi,
	OPau=> OP(0),
	R=> term0,
	OV=> term1,
	CBo=> term2
);

logic_module0 : logic_module port map(
	A=>W,
	B=>Y,
	OP(0)=> OP(0),
	OP(1)=> OP(1),
	R=> term3,
	CY=> term4 
);

mux: mux2_1 port map(
	A=> term0,
	B=> term3,
	S=> OP(2),
	Y=> term5
);

flags: alu_flags port map(
	iOV=> term1,
	iCB=> term2,
	CY=> term4,
	OP2=> OP(2),
	R=> term5,
	BE=> BE, 
	GE=> GE, 
	Z=> Z, 
	OV=> OV, 
	oCB=> CBo
);

--final
F<=term5;
end alu;
