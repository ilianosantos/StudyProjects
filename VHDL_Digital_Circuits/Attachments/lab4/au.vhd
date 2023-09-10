LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity au is
port (
		A: in std_logic_vector(3 downto 0);
		B: in std_logic_vector(3 downto 0);
		CBi, OPau: in std_logic;
		R: out std_logic_vector(3 downto 0);
		OV, CBo: out std_logic
);
end au;

architecture au of au is

component sumsub
port (
		A : in std_logic_vector(3 downto 0);
	B : in std_logic_vector(3 downto 0);
	CBi : in std_logic;
	OPau: in std_logic;
	iCBo: out std_logic;
	S : out std_logic_vector(3 downto 0);
	B3xor : out std_logic
	);
end component;

component flags
port (
		A3 : in std_logic;
		B3 : in std_logic;
		R3 : in std_logic;
		iCBo : in std_logic;
		OVo: out std_logic;
		CBo : out std_logic
);
end component;


signal term: std_logic_vector(3 downto 0);
signal term1, term2, term3: std_logic;

      
begin

sumsub0: sumsub port map(
			A => A,
			B => B,
			CBi => CBi,
			OPau => OPau,
			iCBo => term1,
			S => term,
			B3xor => term3
);

flags0: flags port map(
		A3 => A(3),
		B3 => term3,
		R3 => term(3),
		iCBo => term1,
		OVo => OV,
		CBo => CBo
);

R<= term;
end au;
