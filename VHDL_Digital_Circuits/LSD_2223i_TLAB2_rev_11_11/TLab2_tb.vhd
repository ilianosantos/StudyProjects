library IEEE;
use IEEE.std_logic_1164.all;

entity TLab2_tb is
end entity;

architecture arc_TLab2_tb of TLab2_tb is

	component TLab2 port(
		CBi: in std_logic;
		W: in std_logic_vector(3 downto 0);
		Y: in std_logic_vector(3 downto 0);
		OP: in std_logic_vector(2 downto 0);
		F: out std_logic_vector(3 downto 0);
		CBo: out std_logic;
		OV: out std_logic;
		Z: out std_logic;
		GE: out std_logic;
		BE: out std_logic);
	end component;


	constant operation_delay : time := 10 ns;
	constant operation_width : natural := 3;
	constant operands_width : natural := 4;
	
	-- UUT
	signal W_TB, Y_TB, F_TB: std_logic_vector(operands_width-1 downto 0);
	signal OP_TB: std_logic_vector(operation_width-1 downto 0);
	signal CBo_TB, OV_TB, Z_TB, BE_TB, GE_TB, CBi_TB: std_logic;
	
	begin
		UUT: TLab2 port map(
			W => W_TB, Y => Y_TB, OP => OP_TB, CBi => CBi_TB,
			F => F_TB, CBo => CBo_TB, OV => OV_TB, Z => Z_TB, BE => BE_TB, GE => GE_TB);

	
	
	stimulus: process
	-- It takes 250 ns to complete.
	-- To see step by step, first runs 5 ns and next run in steps of 10 ns.
	begin
	
	-- Inc operation: 
	OP_TB <= "100"; 
	W_TB <= "0000";
	Y_TB <= "1111";
	CBi_TB <= '0';
	wait for 10 ns;
	-- F="0000", CBo='0', OV='0', Z='1'	
	
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="0001", CBo='0', OV='0', Z='0'	
	
	W_TB <= "0111";
	Y_TB <= "1111";
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="1000", CBo='0', OV='1', Z='0'	

	W_TB <= "1111";
	Y_TB <= "1111";
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="0000", CBo='1', OV='0', Z='1'	

	-- Dec operation
	OP_TB <= "101";
	W_TB <= "0000";
	Y_TB <= "1111";
	CBi_TB <= '0';
	wait for 10 ns;
	-- F="0000", CBo='0', OV='0', Z='1'	
	
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="1111", CBo='1', OV='0', Z='0'	

	W_TB <= "1000";
	Y_TB <= "1111";
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="0111", CBo='0', OV='1', Z='0'	

	-- Addc operation
	OP_TB <= "110";
	W_TB <= "0000";
	Y_TB <= "1111";
	CBi_TB <= '0';
	wait for 10 ns;
	-- F="1111", CBo='0', OV='0', Z='0'	
	
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="0000", CBo='1', OV='0', Z='1'	

	W_TB <= "1000";
	Y_TB <= "1111";
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="1000", CBo='1', OV='0', Z='0'	

	W_TB <= "0000";
	Y_TB <= "0111";
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="1000", CBo='0', OV='1', Z='0'	

	-- Subb operation
	OP_TB <= "111";
	W_TB <= "0000";
	Y_TB <= "1111";
	CBi_TB <= '0';
	wait for 10 ns;
	-- F="0001", CBo='1', OV='0', Z='0', BE='1', GE='1'
	
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="0000", CBo='1', OV='0', Z='1', BE='1', GE='1'

	W_TB <= "0000";
	Y_TB <= "1000";
	CBi_TB <= '0';
	wait for 10 ns;
	-- F="1000", CBo='1', OV='1', Z='0', BE='1', GE='1'	

	W_TB <= "1000";
	Y_TB <= "0111";
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="0000", CBo='0', OV='1', Z='1', BE='1', GE='0'	

	-- Lsr operation
	OP_TB <= "000";
	W_TB <= "1000";
	Y_TB <= "1111";
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="0001", CBo='0', Z='0'	
	
	W_TB <= "1100";
	wait for 10 ns;
	-- F="0001", CBo='1', Z='0'	

	Y_TB <= "1100";
	wait for 10 ns;
	-- F="1100", CBo='0', Z='0'	

	-- Asr operation
	OP_TB <= "001";
	W_TB <= "1000";
	Y_TB <= "1111";
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="1111", CBo='0', Z='0'	
	
	W_TB <= "1100";
	wait for 10 ns;
	-- F="1111", CBo='1', Z='0'	

	Y_TB <= "1100";
	wait for 10 ns;
	-- F="1100", CBo='0', Z='0'	

	-- Or operation
	OP_TB <= "010";
	W_TB <= "1100";
	Y_TB <= "0110";
	CBi_TB <= '0';
	wait for 10 ns;
	-- F="1101", Z='0'	
	
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="1101", Z='0'	

	-- Xor operation
	OP_TB <= "011";
	W_TB <= "1100";
	Y_TB <= "0110";
	CBi_TB <= '0';
	wait for 10 ns;
	-- F="0101", Z='0'	
	
	CBi_TB <= '1';
	wait for 10 ns;
	-- F="0101", Z='0'	

	wait;		
	end process;
	
	
end architecture;