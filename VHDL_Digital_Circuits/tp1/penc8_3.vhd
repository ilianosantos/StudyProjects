LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity penc8_3 is 
port(
		I : in std_logic_vector(7 downto 0);
		O : out std_logic_vector(2 downto 0);
		V : out std_logic		
);
end penc8_3;


architecture tlab1 of penc8_3 is

component penc 
port( 
		I : in std_logic_vector(3 downto 0);
		O : out std_logic_vector(1 downto 0);
		V : OUT std_logic
	);
	end component;
	
component mux2
port(
		I0, I1 : in std_logic_VECTOR(1 downto 0);
		S: in std_logic;
		O1, O0 : out std_logic
	);
end component;

signal SO0, SO1, SO2, MUXOUT: std_logic_vector(1 downto 0);
signal V0, V1, V2, S: std_logic;

begin

PENC1 : penc port map (
		I(0) => I(0),
		I(1) => I(1),
		I(2) => I(2),
		I(3) => I(3),
		O => SO0,
		V => V0		
);

PENC2 : penc port map (
		I(0) => I(4),
		I(1) => I(5),
		I(2) => I(6),
		I(3) => I(7),
		O => SO1,
		V => V1
);

PENC3 : 	penc port map (
		I(0) => V0,
		I(1) => V1,
		I(2) => '0',
		I(3) => '0',
		O => SO2,
		V => V2
);

MUX : mux2 port map(
	I0 => SO0,
	I1 => SO1,
	S => SO2(0),
	O0 => MUXOUT(0), 
	O1 => MUXOUT(1)
);

--final--
O(0) <= 	MUXOUT(0);
O(1) <= MUXOUT(1);
O(2) <= SO2(0);
V <= V2;

end tlab1;