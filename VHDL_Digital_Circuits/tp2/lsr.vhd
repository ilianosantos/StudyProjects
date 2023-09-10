library IEEE;
use IEEE.std_logic_1164.all;

entity lsr is
port(
	A: in std_logic_vector(3 downto 0);
	Y: in std_logic_vector(1 downto 0);
	R: out std_logic_vector(3 downto 0);
	CY: out std_logic
);
end lsr;

architecture lsr of lsr is
component mux4_1
port(
		A: in std_logic_vector(3 downto 0);
		S: in std_logic_vector(1 downto 0);
		R: out std_logic
	);
end component;


signal term0, term1, term2, term3, term4 : std_logic;

begin

mux0: mux4_1 port map(
		A=> A,
		S=>Y,
		R=> term0
);

mux1: mux4_1 port map(
		A(0)=> A(1),
		A(1)=> A(2),
		A(2)=> A(3),
		A(3)=> '0',
		S=>Y,
		R=> term1
);

mux2: mux4_1 port map(
		A(0)=> A(2),
		A(1)=> A(3),
		A(2)=> '0',
		A(3)=> '0',
		S=>Y,
		R=> term2
);

mux3: mux4_1 port map(
		A(0)=> A(3),
		A(1)=> '0',
		A(2)=> '0',
		A(3)=> '0',
		S=>Y,
		R=> term3
);

--Final

term4<= ('0' and not Y(0) and not Y(1)) or (A(0) and Y(0) and not Y(1)) or (A(1) and not Y(0) and Y(1)) or (A(2) and Y(0) and Y(1));

R(0)<= term0;
R(1)<= term1;
R(2)<= term2;
R(3)<= term3;
CY <= term4;
end lsr;