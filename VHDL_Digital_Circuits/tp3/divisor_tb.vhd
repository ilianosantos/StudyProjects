LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.all;

ENTITY divisor_tb IS
END divisor_tb;

ARCHITECTURE behavior OF divisor_tb IS 

-- Component Declaration for the Unit Under Test (UUT)
COMPONENT divisor IS
	Port( 
		RESET : in STD_LOGIC;
		CLK : in std_logic;
		Start: in std_logic;
		Dividendo, Divis : in std_logic_vector(3 downto 0);
		Rdy : OUT STD_LOGIC;		
		Quociente, Resto : out std_logic_vector(3 downto 0);
		HEX0, HEX1, HEX4, HEX5 : out std_logic_vector(7 downto 0)
		
	);
END COMPONENT;

--Inputs
SIGNAL RESET, CLK, Start :  std_logic := '0';
signal Dividendo, Divis : std_logic_vector(3 downto 0) := "0000";

--Outputs
SIGNAL Rdy : std_logic := '0';
signal Quociente, Resto : std_logic_vector(3 downto 0) := "0000";

signal HEX0, HEX1, HEX4, HEX5 : std_logic_vector(7 downto 0) := "00000000";


BEGIN

-- Instantiate the Unit Under Test (UUT)
uut: divisor PORT MAP(
	RESET => RESET,
	CLK => CLK,
	Start => Start,
	Dividendo => Dividendo,
	Divis => Divis,
	Rdy => Rdy,
	Quociente => Quociente,
	Resto => Resto,
	HEX0 => HEX0,
	HEX1 => HEX1,
	HEX4 => HEX4,
	HEX5 => HEX5
	
	
	
);

CLK <= not CLK after 5 ns;

tb : PROCESS
BEGIN

	wait for 10 ns;
	RESET <= '1';
	Start <= '0';
	
	wait for 20 ns;
	
	RESET <= '0';	
	
	wait for 20 ns;
	
	Dividendo <= "1111";
	Divis <= "0010";
	
	wait for 20 ns;	
	
	Start <= '1';
		
	wait for 20 ns;	
	Start <= '0';
			
	
	wait;

END PROCESS;

END;
