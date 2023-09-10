library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

entity TLab2_full_tb is
end TLab2_full_tb;

architecture arc_tlab2_full_tb of TLab2_full_tb is

	component alu port(
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
	
	-- SWU
	signal F_SW: std_logic_vector(operands_width-1 downto 0);
	signal CBo_SW, OV_SW, Z_SW, BE_SW, GE_SW: std_logic;

	begin
		UUT: alu port map(
			W => W_TB, Y => Y_TB, OP => OP_TB, CBi => CBi_TB,
			F => F_TB, CBo => CBo_TB, OV => OV_TB, Z => Z_TB, BE => BE_TB, GE => GE_TB);

	
	
	stimulus: process
	-- execute simulation for 2**operation_width * 2**operands_width * 2**operands_width * operation_delay
	-- 2^3 * 2^4 * 2^4 * 10 ns = 20480 ns ~= 20.5 us All of this multiplied by two because of CBi with 0 and 1.
	-- It means 20.5 * 2 = 41 us (microseconds)
	begin
	for k in 0 to 2**operation_width-1 loop
		OP_TB <= std_logic_vector(to_unsigned(k,operation_width));
		for i in 0 to 2**operands_width-1 loop
			W_TB <= std_logic_vector(to_unsigned(i,operands_width));
			for j in 0 to 2**operands_width-1 loop
				Y_TB <= std_logic_vector(to_unsigned(j,operands_width));
				CBi_TB <= '0';
				wait for operation_delay;
				CBi_TB <= '1';
				wait for operation_delay;
			end loop;
		end loop;
		report "Done op=" & integer'image(k);
	end loop;

	report "Simulation Done!!!!!";
	wait;		
	end process;
	
	
	SWU: process(W_TB,Y_TB, CBi_TB)
	constant LSR_OP  : std_logic_vector(1 downto 0) := "00";
	constant ASR_OP  : std_logic_vector(1 downto 0) := "01";
	constant OR_OP   : std_logic_vector(1 downto 0) := "10";
	constant XNOR_OP : std_logic_vector(1 downto 0) := "11";
	constant INC_OP  : std_logic_vector(1 downto 0) := "00";
	constant DEC_OP  : std_logic_vector(1 downto 0) := "01";
	constant ADDC_OP : std_logic_vector(1 downto 0) := "10";
	constant SUBB_OP : std_logic_vector(1 downto 0) := "11";
	constant ARITH_OP : std_logic := '1';
	constant LOGIC_OP : std_logic := '0';

	variable lsr_value, or_value, xnor_value : unsigned(operands_width downto 0);
	variable inc_value, dec_value, addc_value, subb_value : unsigned(operands_width downto 0);
	variable uwvar, uyvar, uafvar, ulfvar, ufvar: unsigned(operands_width downto 0);
	variable swvar, syvar: signed(operands_width downto 0);
	variable zvar, bevar, ovvar, cbovar, cylvar, gevar, cbivar: std_logic;
	variable asr_value: signed(operands_width downto 0);

	begin			
		-- Inputs
		uwvar := unsigned('0' & W_TB);
		uyvar := unsigned('0' & Y_TB);
		cbivar := CBi_TB;
		swvar(0) := W_TB(0);
		swvar(1) := W_TB(1);
		swvar(2) := W_TB(2);
		swvar(3) := W_TB(3);
		swvar(4) := W_TB(3);
		-- Logic operations
		lsr_value:= shift_right(uwvar, to_integer(uyvar) rem 4);
		asr_value:= shift_right(swvar , to_integer(uyvar) rem 4);
		or_value:= uwvar or not uyvar;
		xnor_value:= not (uwvar xor uyvar);
		-- Carry of shift operations
		case (to_integer(uyvar) rem 4) is
			when 0	 	=> cylvar := '0';
			when OTHERS => cylvar := std_logic(shift_right(uwvar, (to_integer(uyvar) rem 4) - 1)(0));
		end case;

		case OP_TB(1 downto 0) is
			when LSR_OP => ulfvar := lsr_value;
			when ASR_OP => ulfvar := unsigned(asr_value);
			when OR_OP  => ulfvar := or_value;
			when XNOR_OP=> ulfvar := xnor_value;
			when OTHERS => ulfvar := "00000";
		end case;

		-- Arithmetic operations
		inc_value:= uwvar + unsigned'('0' & cbivar);
		dec_value:= uwvar - unsigned'('0' & cbivar);
		addc_value:= uwvar + uyvar + unsigned'('0' & cbivar);
		subb_value:= uwvar - uyvar - unsigned'('0' & cbivar);
		
		case OP_TB(1 downto 0) is
			when INC_OP  => uafvar := inc_value;
			when DEC_OP  => uafvar := dec_value;
			when ADDC_OP => uafvar := addc_value;
			when SUBB_OP => uafvar := subb_value;
			when OTHERS  => uafvar := "00000";
		end case;
	
		-- Mux logic/arith operations
		case OP_TB(2) is
			when LOGIC_OP => ufvar := ulfvar;
			when ARITH_OP => ufvar := uafvar;
			when OTHERS	  => uafvar := "00000";
		end case;
	

		-- Flags generation
		-- generate overflow for all operations
		case OP_TB(1 downto 0) is
			when INC_OP =>  ovvar := (not uwvar(3) and not '0' and uafvar(3)) or (uwvar(3) and '0' and not uafvar(3));
			when DEC_OP =>  ovvar := (not uwvar(3) and '0' and uafvar(3)) or (uwvar(3) and not '0' and not uafvar(3));
			when ADDC_OP => ovvar := (not uwvar(3) and not uyvar(3) and uafvar(3)) or (uwvar(3) and uyvar(3) and not uafvar(3));
			when SUBB_OP => ovvar := (not uwvar(3) and uyvar(3) and uafvar(3)) or (uwvar(3) and not uyvar(3) and not uafvar(3));
			when OTHERS =>	ovvar := '0';
		end case;

		zvar := not(ufvar(3) or ufvar(2) or ufvar(1) or ufvar(0));
		case OP_TB(2) is 
			when '0' => cbovar := cylvar;
			when '1' => cbovar := uafvar(4);
			when OTHERS => cbovar := '0';
		end case;
		gevar := not ovvar xor ufvar(3);
		bevar := uafvar(4) or zvar;

		-- allow var to be outside of process
		F_SW <= std_logic_vector(ufvar(3 downto 0));
		CBo_SW <= std_logic(cbovar);
		OV_SW <= std_logic(ovvar);
		GE_SW <= std_logic(gevar);
		Z_SW <= std_logic(zvar);
		BE_SW <= std_logic(bevar);
	end process;
	

	comparison: process
	begin
	-- assert result and all Flags
		wait for operation_delay;
		assert (F_SW = F_TB) 	 report "Failure Result" severity FAILURE;
		assert (CBo_SW = CBo_TB) report "Failure flag CBo" severity FAILURE;
		assert (OV_SW = OV_TB) 	 report "Failure flag OV" severity FAILURE;
		assert (Z_SW = Z_TB) 	 report "Failure flag Z" severity FAILURE;
		assert (GE_SW = GE_TB) 	 report "Failure flag GE" severity FAILURE;
		assert (BE_SW = BE_TB) 	 report "Failure flag BE" severity FAILURE;
	end process;
	
	
end arc_tlab2_full_tb;