LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity decoderHex IS
	PORT (
		Q, R : in std_logic_vector(3 downto 0);
		clear : in std_logic;
		HEX0, HEX1, HEX4, HEX5 : out std_logic_vector(7 downto 0)
	);		
END decoderHex;

Architecture logicFuntion of decoderHex is

component int7seg
PORT(	d0, d1, d2, d3: IN STD_LOGIC;
		dOut: out std_logic_vector(7 downto 0)
		);
END component;

component bin2dec_int
    Port ( bin : in  STD_LOGIC_VECTOR (7 downto 0);
           dec : out  STD_LOGIC_VECTOR (7 downto 0));
end component;


SIGNAL a0s, a1s, a0u, a1u : std_logic_vector(3 downto 0);
signal a0, a1, a2, a3 : std_logic;
signal b0, b1, b2, b3 : std_logic;
signal q0, q1, q2, q3 : std_logic;
signal r0, r1, r2, r3 : std_logic;

signal HEX5t, HEX4t, HEX1t, HEX0t: std_logic_vector(7 downto 0);
signal Esqdec, Dirdec: std_logic_vector(7 downto 0);

signal Qb, Rb, Qbcd, Rbcd : STD_LOGIC_VECTOR (7 downto 0);


BEGIN

Qb <= "0000" & Q;
Rb <= "0000" & R;

Ua : bin2dec_int port map(Qb, Qbcd);
Ub : bin2dec_int port map(Rb, Rbcd);

UQ0: int7seg port map(Qbcd(0), Qbcd(1), Qbcd(2), Qbcd(3), HEX4t);
UQ1: int7seg port map(Qbcd(4), Qbcd(5), Qbcd(6), Qbcd(7), HEX5t);

UR0: int7seg port map(Rbcd(0), Rbcd(1), Rbcd(2), Rbcd(3), HEX0t);
UR1: int7seg port map(Rbcd(4), Rbcd(5), Rbcd(6), Rbcd(7), HEX1t);

HEX0 <= HEX0t when clear = '0' else "11111111";
HEX1 <= HEX1t when clear = '0' else "11111111";
HEX4 <= HEX4t when clear = '0' else "11111111";
HEX5 <= HEX5t when clear = '0' else "11111111";
									
END logicFuntion;	