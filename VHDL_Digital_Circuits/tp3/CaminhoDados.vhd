LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity caminhoDados is
port(
	Dividendo, Divisor : in std_logic_vector(3 downto 0);
	S, EDD, EDS, R, CE, CLEAR, CLK : in std_logic;
	HEX0, HEX1, HEX2, HEX3 :out std_logic_vector(7 downto 0);
	Q, Resto : out std_logic_vector(3 downto 0);
	Below: out std_logic
);
end caminhoDados;


architecture caminhoDados of caminhoDados is

component reg4bits is
port(	D : in std_logic_vector(3 downto 0);
		CLK : in std_logic;
		E : in std_logic;
		Q : out std_logic_vector(3 downto 0)
		);
end component;


component mux2_1 is 
port(
	A, B: in std_logic_vector (3 downto 0);
	S: in std_logic;
	R: out std_logic_vector (3 downto 0)
);
end component;

component countup is
port(	DataIn : in std_logic_vector(3 downto 0);
		CE, PL, CLK : in std_logic; 
		Q : out std_logic_vector(3 downto 0);
		TC : out std_logic
		);
end component;

component sumsub is
port (
A : in std_logic_vector(3 downto 0);
B : in std_logic_vector(3 downto 0);
CBi : in std_logic;
OPau: in std_logic;
S : out std_logic_vector(3 downto 0);
B3xor, Below : out std_logic
);
end component;

component decoderHex is
port (
Q, R : in std_logic_vector(3 downto 0);
clear : in std_logic;
HEX0, HEX1, HEX4, HEX5 : out std_logic_vector(7 downto 0)
);		
end component;

signal term0, term1, term2, term3, term4 : std_logic_vector(3 downto 0);

begin

Cont0: countup port map(
	DataIn(0) => '0',
	DataIn(1) => '0',
	DataIn(2) => '0',
	DataIn(3) => '0',
	CE => CE,
	PL => R,
	CLK => CLK,
	Q => term0
);

Mux0: mux2_1 port map(
	A => term2,
	B => Dividendo,
	S => S,
	R => term3
);

Reg0: reg4bits port map(
	D => term3,
	CLK => CLK,
	E => EDD,
	Q => term4
);

Reg1: reg4bits port map(
	D => Divisor,
	CLK => CLK,
	E => EDS,
	Q => term1
);

Sub0: sumsub port map(
	A => term4,
	B => term1,
	CBi => '0',
	OPau => '1',
	S => term2,
	Below => Below
);

DecHex0: decoderHex port map(
	Q => term0,
	R => term4,
	clear => CLEAR,
	HEX0 => HEX0,
	HEX1 => HEX1,
	HEX4 => HEX2,
	HEX5 => HEX3
);

Q <= term0;
Resto <= term4;


end caminhoDados;