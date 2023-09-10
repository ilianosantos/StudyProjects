LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity divisor is
port(
	RESET : in STD_LOGIC;
	CLK : in std_logic;
	Start: in std_logic;
	Dividendo, Divis : in std_logic_vector(3 downto 0);
	Rdy : OUT STD_LOGIC;		
	Quociente, Resto : out std_logic_vector(3 downto 0);
	HEX0, HEX1, HEX4, HEX5 : out std_logic_vector(7 downto 0)
);
end divisor;


architecture arq_divisor of divisor is

component caminhoDados is
port(
	Dividendo, Divisor : in std_logic_vector(3 downto 0);
	S, EDD, EDS, R, CE, CLEAR, CLK : in std_logic;
	HEX0, HEX1,HEX2,HEX3 :out std_logic_vector(7 downto 0);
	Q, Resto : out std_logic_vector(3 downto 0);
	Below: out std_logic
);
end component;

component ROM is
port (MCLK, START, B, RST: in std_logic;
		S,EDD, EDS, R, CE, CLEAR, RDY: out std_logic
		);
end component;



signal term0, term1, term2, term3, term4, term5, term6 : std_logic;

begin
 
U_ROM: ROM port map(
	
	--IN--
	MCLK => CLK,
	RST => RESET,
	START => Start,
	B => term6,
	
	--OUT--
	S => term0,
	R => term1,
	CE => term2,
	CLEAR => term3,
	RDY => Rdy,
	EDD => term4,
	EDS => term5
);
 
 
 U_caminhoDados: caminhoDados port map(
	
	--IN--
	Dividendo => Dividendo,
	Divisor => Divis,
	S => term0, 
	EDD => term4,
	EDS => term5,
	R => term1, 
	CE => term2, 
	CLEAR => term3, 
	CLK => CLK,
	
	--OUT--
	HEX0 => HEX0, 
	HEX1 => HEX1,
	HEX2 => HEX4,
	HEX3 => HEX5,
	Q => Quociente,
	Resto => Resto,
	Below => term6
 );
 
end arq_divisor;