-- Copyright (C) 2019  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"

-- DATE "11/25/2022 11:59:28"

-- 
-- Device: Altera 10M50DAF484C6GES Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_G2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_L4,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_M5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_H9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_G9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_F8,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	alu IS
    PORT (
	W : IN std_logic_vector(3 DOWNTO 0);
	Y : IN std_logic_vector(3 DOWNTO 0);
	OP : IN std_logic_vector(2 DOWNTO 0);
	CBi : IN std_logic;
	F : BUFFER std_logic_vector(3 DOWNTO 0);
	BE : BUFFER std_logic;
	GE : BUFFER std_logic;
	Z : BUFFER std_logic;
	OV : BUFFER std_logic;
	CBo : BUFFER std_logic
	);
END alu;

-- Design Ports Information
-- F[0]	=>  Location: PIN_C7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F[1]	=>  Location: PIN_J10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F[2]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F[3]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- BE	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- GE	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Z	=>  Location: PIN_Y10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- OV	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CBo	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Y[0]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- W[3]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- W[1]	=>  Location: PIN_C14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Y[1]	=>  Location: PIN_H11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- W[2]	=>  Location: PIN_B7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- W[0]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- OP[1]	=>  Location: PIN_E11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- OP[2]	=>  Location: PIN_A4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CBi	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- OP[0]	=>  Location: PIN_A6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Y[2]	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Y[3]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF alu IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_W : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Y : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_OP : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_CBi : std_logic;
SIGNAL ww_F : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_BE : std_logic;
SIGNAL ww_GE : std_logic;
SIGNAL ww_Z : std_logic;
SIGNAL ww_OV : std_logic;
SIGNAL ww_CBo : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \F[0]~output_o\ : std_logic;
SIGNAL \F[1]~output_o\ : std_logic;
SIGNAL \F[2]~output_o\ : std_logic;
SIGNAL \F[3]~output_o\ : std_logic;
SIGNAL \BE~output_o\ : std_logic;
SIGNAL \GE~output_o\ : std_logic;
SIGNAL \Z~output_o\ : std_logic;
SIGNAL \OV~output_o\ : std_logic;
SIGNAL \CBo~output_o\ : std_logic;
SIGNAL \OP[2]~input_o\ : std_logic;
SIGNAL \W[0]~input_o\ : std_logic;
SIGNAL \CBi~input_o\ : std_logic;
SIGNAL \OP[1]~input_o\ : std_logic;
SIGNAL \Y[0]~input_o\ : std_logic;
SIGNAL \mux|Y[0]~4_combout\ : std_logic;
SIGNAL \OP[0]~input_o\ : std_logic;
SIGNAL \mux|Y[0]~5_combout\ : std_logic;
SIGNAL \W[3]~input_o\ : std_logic;
SIGNAL \Y[1]~input_o\ : std_logic;
SIGNAL \W[1]~input_o\ : std_logic;
SIGNAL \mux|Y[0]~2_combout\ : std_logic;
SIGNAL \W[2]~input_o\ : std_logic;
SIGNAL \mux|Y[0]~3_combout\ : std_logic;
SIGNAL \mux|Y[0]~19_combout\ : std_logic;
SIGNAL \mux|Y[0]~20_combout\ : std_logic;
SIGNAL \mux|Y[1]~6_combout\ : std_logic;
SIGNAL \flags|oCB~0_combout\ : std_logic;
SIGNAL \mux|Y[1]~7_combout\ : std_logic;
SIGNAL \mux|Y[1]~8_combout\ : std_logic;
SIGNAL \au0|sumsub0|adder0|fulladder0|CyOut~0_combout\ : std_logic;
SIGNAL \mux|Y[1]~18_combout\ : std_logic;
SIGNAL \mux|Y[1]~9_combout\ : std_logic;
SIGNAL \mux|Y[2]~10_combout\ : std_logic;
SIGNAL \mux|Y[2]~12_combout\ : std_logic;
SIGNAL \Y[2]~input_o\ : std_logic;
SIGNAL \mux|Y[2]~11_combout\ : std_logic;
SIGNAL \mux|Y[2]~13_combout\ : std_logic;
SIGNAL \au0|sumsub0|adder0|fulladder1|CyOut~0_combout\ : std_logic;
SIGNAL \au0|sumsub0|adder0|fulladder2|R~combout\ : std_logic;
SIGNAL \mux|Y[2]~14_combout\ : std_logic;
SIGNAL \Y[3]~input_o\ : std_logic;
SIGNAL \mux|Y[3]~15_combout\ : std_logic;
SIGNAL \mux|Y[3]~16_combout\ : std_logic;
SIGNAL \au0|sumsub0|adder0|fulladder3|R~0_combout\ : std_logic;
SIGNAL \au0|sumsub0|adder0|fulladder2|CyOut~0_combout\ : std_logic;
SIGNAL \mux|Y[3]~17_combout\ : std_logic;
SIGNAL \term6[3]~0_combout\ : std_logic;
SIGNAL \au0|sumsub0|adder0|fulladder3|CyOut~0_combout\ : std_logic;
SIGNAL \flags|BE~0_combout\ : std_logic;
SIGNAL \flags|BE~combout\ : std_logic;
SIGNAL \au0|flags0|OVo~0_combout\ : std_logic;
SIGNAL \flags|GE~0_combout\ : std_logic;
SIGNAL \flags|oCB~1_combout\ : std_logic;
SIGNAL \flags|oCB~2_combout\ : std_logic;
SIGNAL term6 : std_logic_vector(3 DOWNTO 0);
SIGNAL \au0|flags0|ALT_INV_OVo~0_combout\ : std_logic;
SIGNAL \flags|ALT_INV_BE~0_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_W <= W;
ww_Y <= Y;
ww_OP <= OP;
ww_CBi <= CBi;
F <= ww_F;
BE <= ww_BE;
GE <= ww_GE;
Z <= ww_Z;
OV <= ww_OV;
CBo <= ww_CBo;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
\au0|flags0|ALT_INV_OVo~0_combout\ <= NOT \au0|flags0|OVo~0_combout\;
\flags|ALT_INV_BE~0_combout\ <= NOT \flags|BE~0_combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y45_N16
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X34_Y39_N2
\F[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mux|Y[0]~20_combout\,
	devoe => ww_devoe,
	o => \F[0]~output_o\);

-- Location: IOOBUF_X34_Y39_N9
\F[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mux|Y[1]~9_combout\,
	devoe => ww_devoe,
	o => \F[1]~output_o\);

-- Location: IOOBUF_X31_Y39_N16
\F[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mux|Y[2]~14_combout\,
	devoe => ww_devoe,
	o => \F[2]~output_o\);

-- Location: IOOBUF_X29_Y39_N9
\F[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mux|Y[3]~17_combout\,
	devoe => ww_devoe,
	o => \F[3]~output_o\);

-- Location: IOOBUF_X46_Y54_N2
\BE~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \flags|BE~combout\,
	devoe => ww_devoe,
	o => \BE~output_o\);

-- Location: IOOBUF_X29_Y39_N2
\GE~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \flags|GE~0_combout\,
	devoe => ww_devoe,
	o => \GE~output_o\);

-- Location: IOOBUF_X34_Y0_N9
\Z~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \flags|ALT_INV_BE~0_combout\,
	devoe => ww_devoe,
	o => \Z~output_o\);

-- Location: IOOBUF_X29_Y39_N16
\OV~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \au0|flags0|ALT_INV_OVo~0_combout\,
	devoe => ww_devoe,
	o => \OV~output_o\);

-- Location: IOOBUF_X46_Y54_N23
\CBo~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \flags|oCB~2_combout\,
	devoe => ww_devoe,
	o => \CBo~output_o\);

-- Location: IOIBUF_X31_Y39_N22
\OP[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_OP(2),
	o => \OP[2]~input_o\);

-- Location: IOIBUF_X31_Y39_N29
\W[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_W(0),
	o => \W[0]~input_o\);

-- Location: IOIBUF_X46_Y54_N29
\CBi~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CBi,
	o => \CBi~input_o\);

-- Location: IOIBUF_X36_Y39_N15
\OP[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_OP(1),
	o => \OP[1]~input_o\);

-- Location: IOIBUF_X36_Y39_N22
\Y[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Y(0),
	o => \Y[0]~input_o\);

-- Location: LCCOMB_X36_Y37_N24
\term6[0]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- term6(0) = (\OP[1]~input_o\ & \Y[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \OP[1]~input_o\,
	datac => \Y[0]~input_o\,
	combout => term6(0));

-- Location: LCCOMB_X35_Y37_N28
\mux|Y[0]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[0]~4_combout\ = (\OP[2]~input_o\ & (\W[0]~input_o\ $ (\CBi~input_o\ $ (term6(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000001000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[2]~input_o\,
	datab => \W[0]~input_o\,
	datac => \CBi~input_o\,
	datad => term6(0),
	combout => \mux|Y[0]~4_combout\);

-- Location: IOIBUF_X34_Y39_N29
\OP[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_OP(0),
	o => \OP[0]~input_o\);

-- Location: LCCOMB_X35_Y37_N6
\mux|Y[0]~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[0]~5_combout\ = (\W[0]~input_o\ & ((\Y[0]~input_o\) # (!\OP[0]~input_o\))) # (!\W[0]~input_o\ & ((!\Y[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \W[0]~input_o\,
	datac => \OP[0]~input_o\,
	datad => \Y[0]~input_o\,
	combout => \mux|Y[0]~5_combout\);

-- Location: IOIBUF_X36_Y39_N29
\W[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_W(3),
	o => \W[3]~input_o\);

-- Location: IOIBUF_X34_Y39_N15
\Y[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Y(1),
	o => \Y[1]~input_o\);

-- Location: IOIBUF_X58_Y54_N15
\W[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_W(1),
	o => \W[1]~input_o\);

-- Location: LCCOMB_X35_Y37_N24
\mux|Y[0]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[0]~2_combout\ = (\Y[0]~input_o\ & ((\Y[1]~input_o\ & (\W[3]~input_o\)) # (!\Y[1]~input_o\ & ((\W[1]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \W[3]~input_o\,
	datab => \Y[1]~input_o\,
	datac => \W[1]~input_o\,
	datad => \Y[0]~input_o\,
	combout => \mux|Y[0]~2_combout\);

-- Location: IOIBUF_X34_Y39_N22
\W[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_W(2),
	o => \W[2]~input_o\);

-- Location: LCCOMB_X35_Y37_N10
\mux|Y[0]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[0]~3_combout\ = (!\Y[0]~input_o\ & ((\Y[1]~input_o\ & ((\W[2]~input_o\))) # (!\Y[1]~input_o\ & (\W[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \W[0]~input_o\,
	datab => \W[2]~input_o\,
	datac => \Y[1]~input_o\,
	datad => \Y[0]~input_o\,
	combout => \mux|Y[0]~3_combout\);

-- Location: LCCOMB_X35_Y37_N12
\mux|Y[0]~19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[0]~19_combout\ = (\OP[1]~input_o\ & (\mux|Y[0]~5_combout\)) # (!\OP[1]~input_o\ & (((\mux|Y[0]~2_combout\) # (\mux|Y[0]~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mux|Y[0]~5_combout\,
	datab => \mux|Y[0]~2_combout\,
	datac => \OP[1]~input_o\,
	datad => \mux|Y[0]~3_combout\,
	combout => \mux|Y[0]~19_combout\);

-- Location: LCCOMB_X35_Y37_N30
\mux|Y[0]~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[0]~20_combout\ = (\mux|Y[0]~4_combout\) # ((!\OP[2]~input_o\ & \mux|Y[0]~19_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mux|Y[0]~4_combout\,
	datac => \OP[2]~input_o\,
	datad => \mux|Y[0]~19_combout\,
	combout => \mux|Y[0]~20_combout\);

-- Location: LCCOMB_X35_Y37_N4
\mux|Y[1]~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[1]~6_combout\ = (\W[3]~input_o\ & ((\OP[0]~input_o\) # (!\Y[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Y[0]~input_o\,
	datac => \OP[0]~input_o\,
	datad => \W[3]~input_o\,
	combout => \mux|Y[1]~6_combout\);

-- Location: LCCOMB_X35_Y37_N18
\flags|oCB~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \flags|oCB~0_combout\ = (\Y[0]~input_o\ & (\W[2]~input_o\)) # (!\Y[0]~input_o\ & ((\W[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \W[2]~input_o\,
	datac => \W[1]~input_o\,
	datad => \Y[0]~input_o\,
	combout => \flags|oCB~0_combout\);

-- Location: LCCOMB_X35_Y37_N22
\mux|Y[1]~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[1]~7_combout\ = (\Y[1]~input_o\ & (\mux|Y[1]~6_combout\)) # (!\Y[1]~input_o\ & ((\flags|oCB~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Y[1]~input_o\,
	datac => \mux|Y[1]~6_combout\,
	datad => \flags|oCB~0_combout\,
	combout => \mux|Y[1]~7_combout\);

-- Location: LCCOMB_X35_Y37_N16
\mux|Y[1]~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[1]~8_combout\ = (\OP[2]~input_o\ & (\OP[0]~input_o\ $ (((\W[1]~input_o\))))) # (!\OP[2]~input_o\ & ((\Y[1]~input_o\ & ((!\W[1]~input_o\))) # (!\Y[1]~input_o\ & (\OP[0]~input_o\ & \W[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \Y[1]~input_o\,
	datac => \W[1]~input_o\,
	datad => \OP[2]~input_o\,
	combout => \mux|Y[1]~8_combout\);

-- Location: LCCOMB_X35_Y37_N8
\au0|sumsub0|adder0|fulladder0|CyOut~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \au0|sumsub0|adder0|fulladder0|CyOut~0_combout\ = (\CBi~input_o\ & ((term6(0) & (!\OP[0]~input_o\)) # (!term6(0) & ((\W[0]~input_o\))))) # (!\CBi~input_o\ & ((term6(0) & ((\W[0]~input_o\))) # (!term6(0) & (\OP[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101110011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \W[0]~input_o\,
	datac => \CBi~input_o\,
	datad => term6(0),
	combout => \au0|sumsub0|adder0|fulladder0|CyOut~0_combout\);

-- Location: LCCOMB_X35_Y37_N26
\mux|Y[1]~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[1]~18_combout\ = (\OP[2]~input_o\ & (\au0|sumsub0|adder0|fulladder0|CyOut~0_combout\ $ (((\OP[1]~input_o\ & \Y[1]~input_o\))))) # (!\OP[2]~input_o\ & (\OP[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[2]~input_o\,
	datab => \OP[1]~input_o\,
	datac => \au0|sumsub0|adder0|fulladder0|CyOut~0_combout\,
	datad => \Y[1]~input_o\,
	combout => \mux|Y[1]~18_combout\);

-- Location: LCCOMB_X35_Y37_N2
\mux|Y[1]~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[1]~9_combout\ = (\mux|Y[1]~18_combout\ & (((!\mux|Y[1]~8_combout\)))) # (!\mux|Y[1]~18_combout\ & ((\OP[2]~input_o\ & ((\mux|Y[1]~8_combout\))) # (!\OP[2]~input_o\ & (\mux|Y[1]~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mux|Y[1]~7_combout\,
	datab => \mux|Y[1]~8_combout\,
	datac => \mux|Y[1]~18_combout\,
	datad => \OP[2]~input_o\,
	combout => \mux|Y[1]~9_combout\);

-- Location: LCCOMB_X35_Y36_N26
\mux|Y[2]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[2]~10_combout\ = (!\Y[0]~input_o\ & (!\Y[1]~input_o\ & (!\OP[1]~input_o\ & \W[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Y[0]~input_o\,
	datab => \Y[1]~input_o\,
	datac => \OP[1]~input_o\,
	datad => \W[2]~input_o\,
	combout => \mux|Y[2]~10_combout\);

-- Location: LCCOMB_X35_Y36_N14
\mux|Y[2]~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[2]~12_combout\ = (\W[3]~input_o\ & ((\Y[1]~input_o\ & (\OP[0]~input_o\)) # (!\Y[1]~input_o\ & ((\Y[0]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \Y[1]~input_o\,
	datac => \Y[0]~input_o\,
	datad => \W[3]~input_o\,
	combout => \mux|Y[2]~12_combout\);

-- Location: IOIBUF_X31_Y39_N1
\Y[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Y(2),
	o => \Y[2]~input_o\);

-- Location: LCCOMB_X35_Y36_N12
\mux|Y[2]~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[2]~11_combout\ = (\OP[1]~input_o\ & ((\W[2]~input_o\ & ((\Y[2]~input_o\) # (!\OP[0]~input_o\))) # (!\W[2]~input_o\ & (!\Y[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \W[2]~input_o\,
	datab => \Y[2]~input_o\,
	datac => \OP[1]~input_o\,
	datad => \OP[0]~input_o\,
	combout => \mux|Y[2]~11_combout\);

-- Location: LCCOMB_X35_Y36_N8
\mux|Y[2]~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[2]~13_combout\ = (\mux|Y[2]~10_combout\) # ((\mux|Y[2]~11_combout\) # ((\mux|Y[2]~12_combout\ & !\OP[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mux|Y[2]~10_combout\,
	datab => \mux|Y[2]~12_combout\,
	datac => \OP[1]~input_o\,
	datad => \mux|Y[2]~11_combout\,
	combout => \mux|Y[2]~13_combout\);

-- Location: LCCOMB_X36_Y37_N18
\term6[1]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- term6(1) = (\Y[1]~input_o\ & \OP[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Y[1]~input_o\,
	datad => \OP[1]~input_o\,
	combout => term6(1));

-- Location: LCCOMB_X35_Y37_N20
\au0|sumsub0|adder0|fulladder1|CyOut~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \au0|sumsub0|adder0|fulladder1|CyOut~0_combout\ = (\au0|sumsub0|adder0|fulladder0|CyOut~0_combout\ & ((\W[1]~input_o\) # (\OP[0]~input_o\ $ (term6(1))))) # (!\au0|sumsub0|adder0|fulladder0|CyOut~0_combout\ & (\W[1]~input_o\ & (\OP[0]~input_o\ $ 
-- (term6(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \au0|sumsub0|adder0|fulladder0|CyOut~0_combout\,
	datac => \W[1]~input_o\,
	datad => term6(1),
	combout => \au0|sumsub0|adder0|fulladder1|CyOut~0_combout\);

-- Location: LCCOMB_X36_Y36_N24
\term6[2]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- term6(2) = (\Y[2]~input_o\ & \OP[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Y[2]~input_o\,
	datad => \OP[1]~input_o\,
	combout => term6(2));

-- Location: LCCOMB_X35_Y36_N24
\au0|sumsub0|adder0|fulladder2|R\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \au0|sumsub0|adder0|fulladder2|R~combout\ = \OP[0]~input_o\ $ (\au0|sumsub0|adder0|fulladder1|CyOut~0_combout\ $ (\W[2]~input_o\ $ (term6(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \au0|sumsub0|adder0|fulladder1|CyOut~0_combout\,
	datac => \W[2]~input_o\,
	datad => term6(2),
	combout => \au0|sumsub0|adder0|fulladder2|R~combout\);

-- Location: LCCOMB_X35_Y36_N2
\mux|Y[2]~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[2]~14_combout\ = (\OP[2]~input_o\ & ((\au0|sumsub0|adder0|fulladder2|R~combout\))) # (!\OP[2]~input_o\ & (\mux|Y[2]~13_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[2]~input_o\,
	datac => \mux|Y[2]~13_combout\,
	datad => \au0|sumsub0|adder0|fulladder2|R~combout\,
	combout => \mux|Y[2]~14_combout\);

-- Location: IOIBUF_X31_Y39_N8
\Y[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Y(3),
	o => \Y[3]~input_o\);

-- Location: LCCOMB_X35_Y36_N20
\mux|Y[3]~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[3]~15_combout\ = (\OP[0]~input_o\) # ((!\OP[1]~input_o\ & (!\Y[0]~input_o\ & !\Y[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \OP[1]~input_o\,
	datac => \Y[0]~input_o\,
	datad => \Y[1]~input_o\,
	combout => \mux|Y[3]~15_combout\);

-- Location: LCCOMB_X35_Y36_N6
\mux|Y[3]~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[3]~16_combout\ = (\Y[3]~input_o\ & (\W[3]~input_o\ & ((\mux|Y[3]~15_combout\) # (\OP[1]~input_o\)))) # (!\Y[3]~input_o\ & (\OP[1]~input_o\ $ (((\mux|Y[3]~15_combout\ & \W[3]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Y[3]~input_o\,
	datab => \mux|Y[3]~15_combout\,
	datac => \OP[1]~input_o\,
	datad => \W[3]~input_o\,
	combout => \mux|Y[3]~16_combout\);

-- Location: LCCOMB_X35_Y36_N18
\au0|sumsub0|adder0|fulladder3|R~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \au0|sumsub0|adder0|fulladder3|R~0_combout\ = \OP[0]~input_o\ $ (\W[3]~input_o\ $ (((\OP[1]~input_o\ & \Y[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001010101101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \OP[1]~input_o\,
	datac => \Y[3]~input_o\,
	datad => \W[3]~input_o\,
	combout => \au0|sumsub0|adder0|fulladder3|R~0_combout\);

-- Location: LCCOMB_X35_Y36_N16
\au0|sumsub0|adder0|fulladder2|CyOut~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \au0|sumsub0|adder0|fulladder2|CyOut~0_combout\ = (\au0|sumsub0|adder0|fulladder1|CyOut~0_combout\ & ((\W[2]~input_o\) # (\OP[0]~input_o\ $ (term6(2))))) # (!\au0|sumsub0|adder0|fulladder1|CyOut~0_combout\ & (\W[2]~input_o\ & (\OP[0]~input_o\ $ 
-- (term6(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \au0|sumsub0|adder0|fulladder1|CyOut~0_combout\,
	datac => \W[2]~input_o\,
	datad => term6(2),
	combout => \au0|sumsub0|adder0|fulladder2|CyOut~0_combout\);

-- Location: LCCOMB_X35_Y36_N4
\mux|Y[3]~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \mux|Y[3]~17_combout\ = (\OP[2]~input_o\ & ((\au0|sumsub0|adder0|fulladder3|R~0_combout\ $ (\au0|sumsub0|adder0|fulladder2|CyOut~0_combout\)))) # (!\OP[2]~input_o\ & (\mux|Y[3]~16_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mux|Y[3]~16_combout\,
	datab => \au0|sumsub0|adder0|fulladder3|R~0_combout\,
	datac => \OP[2]~input_o\,
	datad => \au0|sumsub0|adder0|fulladder2|CyOut~0_combout\,
	combout => \mux|Y[3]~17_combout\);

-- Location: LCCOMB_X35_Y36_N30
\term6[3]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \term6[3]~0_combout\ = (\OP[1]~input_o\ & \Y[3]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \OP[1]~input_o\,
	datac => \Y[3]~input_o\,
	combout => \term6[3]~0_combout\);

-- Location: LCCOMB_X35_Y36_N0
\au0|sumsub0|adder0|fulladder3|CyOut~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \au0|sumsub0|adder0|fulladder3|CyOut~0_combout\ = (\au0|sumsub0|adder0|fulladder2|CyOut~0_combout\ & ((\W[3]~input_o\) # (\OP[0]~input_o\ $ (\term6[3]~0_combout\)))) # (!\au0|sumsub0|adder0|fulladder2|CyOut~0_combout\ & (\W[3]~input_o\ & (\OP[0]~input_o\ 
-- $ (\term6[3]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \au0|sumsub0|adder0|fulladder2|CyOut~0_combout\,
	datac => \term6[3]~0_combout\,
	datad => \W[3]~input_o\,
	combout => \au0|sumsub0|adder0|fulladder3|CyOut~0_combout\);

-- Location: LCCOMB_X35_Y36_N10
\flags|BE~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \flags|BE~0_combout\ = (\mux|Y[1]~9_combout\) # ((\mux|Y[3]~17_combout\) # ((\mux|Y[0]~20_combout\) # (\mux|Y[2]~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mux|Y[1]~9_combout\,
	datab => \mux|Y[3]~17_combout\,
	datac => \mux|Y[0]~20_combout\,
	datad => \mux|Y[2]~14_combout\,
	combout => \flags|BE~0_combout\);

-- Location: LCCOMB_X35_Y36_N28
\flags|BE\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \flags|BE~combout\ = (\OP[0]~input_o\ $ (\au0|sumsub0|adder0|fulladder3|CyOut~0_combout\)) # (!\flags|BE~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \au0|sumsub0|adder0|fulladder3|CyOut~0_combout\,
	datad => \flags|BE~0_combout\,
	combout => \flags|BE~combout\);

-- Location: LCCOMB_X35_Y36_N22
\au0|flags0|OVo~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \au0|flags0|OVo~0_combout\ = (\au0|sumsub0|adder0|fulladder2|CyOut~0_combout\ & ((\W[3]~input_o\) # (\OP[0]~input_o\ $ (\term6[3]~0_combout\)))) # (!\au0|sumsub0|adder0|fulladder2|CyOut~0_combout\ & ((\OP[0]~input_o\ $ (!\term6[3]~0_combout\)) # 
-- (!\W[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110101111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \au0|sumsub0|adder0|fulladder2|CyOut~0_combout\,
	datac => \term6[3]~0_combout\,
	datad => \W[3]~input_o\,
	combout => \au0|flags0|OVo~0_combout\);

-- Location: LCCOMB_X31_Y37_N8
\flags|GE~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \flags|GE~0_combout\ = \mux|Y[3]~17_combout\ $ (\au0|flags0|OVo~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mux|Y[3]~17_combout\,
	datad => \au0|flags0|OVo~0_combout\,
	combout => \flags|GE~0_combout\);

-- Location: LCCOMB_X35_Y37_N14
\flags|oCB~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \flags|oCB~1_combout\ = (\Y[1]~input_o\ & (((\flags|oCB~0_combout\)))) # (!\Y[1]~input_o\ & (\W[0]~input_o\ & ((\Y[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \W[0]~input_o\,
	datab => \flags|oCB~0_combout\,
	datac => \Y[1]~input_o\,
	datad => \Y[0]~input_o\,
	combout => \flags|oCB~1_combout\);

-- Location: LCCOMB_X35_Y37_N0
\flags|oCB~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \flags|oCB~2_combout\ = (\OP[2]~input_o\ & (\OP[0]~input_o\ $ ((\au0|sumsub0|adder0|fulladder3|CyOut~0_combout\)))) # (!\OP[2]~input_o\ & (((\flags|oCB~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \OP[0]~input_o\,
	datab => \au0|sumsub0|adder0|fulladder3|CyOut~0_combout\,
	datac => \flags|oCB~1_combout\,
	datad => \OP[2]~input_o\,
	combout => \flags|oCB~2_combout\);

-- Location: UNVM_X0_Y40_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X43_Y52_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

-- Location: ADCBLOCK_X43_Y51_N0
\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 2,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

ww_F(0) <= \F[0]~output_o\;

ww_F(1) <= \F[1]~output_o\;

ww_F(2) <= \F[2]~output_o\;

ww_F(3) <= \F[3]~output_o\;

ww_BE <= \BE~output_o\;

ww_GE <= \GE~output_o\;

ww_Z <= \Z~output_o\;

ww_OV <= \OV~output_o\;

ww_CBo <= \CBo~output_o\;
END structure;


