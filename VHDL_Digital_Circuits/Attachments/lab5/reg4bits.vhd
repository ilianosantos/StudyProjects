LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg4bits IS
PORT(	D : in std_logic_vector(3 downto 0);
		CLK : in std_logic;
		E : in std_logic;
		Q : out std_logic_vector(3 downto 0)
		);
END reg4bits;

architecture reg4bits of reg4bits is

component FFD port(	
		CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
);
end component;

begin

FFD0: FFD port map(
		CLK => CLK,
		RESET => '0',
		SET => '0',
		D => D(3),
		EN => E,
		Q => Q(3)
);

FFD1: FFD port map(
		CLK => CLK,
		RESET => '0',
		SET => '0',
		D => D(2),
		EN => E,
		Q => Q(2)
);

FFD2: FFD port map(
		CLK => CLK,
		RESET => '0',
		SET => '0',
		D => D(1),
		EN => E,
		Q => Q(1)
);

FFD3: FFD port map(
		CLK => CLK,
		RESET => '0',
		SET => '0',
		D => D(0),
		EN => E,
		Q => Q(0)
);

end reg4bits;
