library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
port (MCLK, START, B, RST: in std_logic;
		S, EDD, EDS, R, CE, CLEAR, RDY: out std_logic
		);
end ROM;

architecture arq_ROM of ROM is

	component FFD
	port(	CLK, RESET, SET, D, EN : in std_logic;
			Q : out std_logic
			);
	end component;
	signal ADDR: std_logic_vector (3 downto 0);
	signal DATA: std_logic_vector (8 downto 0);
	signal EP: std_logic_vector(1 downto 0);

	-- A(3) = Q1; A(2) = Q0; A(1) = START; A(0) = B
	-- D(3) = R; D(2) = CE; D(1) = CLEAR; D(0) = RDY
	-- D(8) = Q1+1; D(7) = Q0+1; D(6) = S; D(5) = EDD; D(4) = EDS;
	type ROM_type is array (0 to 15) of std_logic_vector(8 downto 0);
	
	constant ROM: ROM_type := (0 	=> "001111000",
										1 	=> "001111000",
										2 	=> "101111000",
										3 	=> "101111000",
										
										4 	=> "101100110",
										5 	=> "101100110",
										6 	=> "101100110",
										7 	=> "101100110",
										
										8 	=> "011000000",
										9 	=> "111000000",
										10	=> "011000000",
										11	=> "111000000",
										
										12	=> "000000001",
										13	=> "000000001",
										14	=> "110000001",
										15	=> "110000001");
											
begin

	U_FF0: FFD port map (CLK => MCLK, RESET => RST, SET => '0', 
							 D => DATA(7), EN => '1', Q => EP(0));
	U_FF1: FFD port map (CLK => MCLK, RESET => RST, SET => '0', 
							 D => DATA(8), EN => '1', Q => EP(1));
	ADDR <= EP(1) & EP(0) & START & B; --concatenação de bits
	DATA <= ROM( to_integer(unsigned(ADDR)));
	CLEAR <= DATA(6);
	EDD <= DATA(5);
	EDS <= DATA(4);
	R <= DATA(3);
	CE <= DATA(2);
	S <= DATA(1);
	RDY <= DATA(0);
	
end arq_ROM;