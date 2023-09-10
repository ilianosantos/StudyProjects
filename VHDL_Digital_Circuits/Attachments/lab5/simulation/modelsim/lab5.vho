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

-- DATE "11/30/2022 12:52:44"

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


LIBRARY ALTERA;
LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	lab5 IS
    PORT (
	Data_in : IN std_logic_vector(3 DOWNTO 0);
	CE : IN std_logic;
	PL : IN std_logic;
	CLK : IN std_logic;
	CLEAR : IN std_logic;
	Q : OUT std_logic_vector(3 DOWNTO 0);
	SEG7 : OUT std_logic_vector(7 DOWNTO 0);
	TC : OUT std_logic
	);
END lab5;

-- Design Ports Information
-- Q[0]	=>  Location: PIN_K14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[1]	=>  Location: PIN_A21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[2]	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[3]	=>  Location: PIN_J14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG7[0]	=>  Location: PIN_B22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG7[1]	=>  Location: PIN_K18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG7[2]	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG7[3]	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG7[4]	=>  Location: PIN_B21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG7[5]	=>  Location: PIN_K19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG7[6]	=>  Location: PIN_J18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG7[7]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- TC	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLEAR	=>  Location: PIN_F17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Data_in[0]	=>  Location: PIN_E20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CE	=>  Location: PIN_D19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PL	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Data_in[1]	=>  Location: PIN_C20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Data_in[2]	=>  Location: PIN_E19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Data_in[3]	=>  Location: PIN_F18,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF lab5 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_Data_in : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_CE : std_logic;
SIGNAL ww_PL : std_logic;
SIGNAL ww_CLK : std_logic;
SIGNAL ww_CLEAR : std_logic;
SIGNAL ww_Q : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_SEG7 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_TC : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \CLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \Q[0]~output_o\ : std_logic;
SIGNAL \Q[1]~output_o\ : std_logic;
SIGNAL \Q[2]~output_o\ : std_logic;
SIGNAL \Q[3]~output_o\ : std_logic;
SIGNAL \SEG7[0]~output_o\ : std_logic;
SIGNAL \SEG7[1]~output_o\ : std_logic;
SIGNAL \SEG7[2]~output_o\ : std_logic;
SIGNAL \SEG7[3]~output_o\ : std_logic;
SIGNAL \SEG7[4]~output_o\ : std_logic;
SIGNAL \SEG7[5]~output_o\ : std_logic;
SIGNAL \SEG7[6]~output_o\ : std_logic;
SIGNAL \SEG7[7]~output_o\ : std_logic;
SIGNAL \TC~output_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \CLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \PL~input_o\ : std_logic;
SIGNAL \Data_in[0]~input_o\ : std_logic;
SIGNAL \CE~input_o\ : std_logic;
SIGNAL \CountUp0|Mux0|Y[0]~0_combout\ : std_logic;
SIGNAL \CountUp0|reg0|FFD3|Q~q\ : std_logic;
SIGNAL \Data_in[1]~input_o\ : std_logic;
SIGNAL \CountUp0|Mux0|Y[1]~1_combout\ : std_logic;
SIGNAL \CountUp0|Mux0|Y[1]~2_combout\ : std_logic;
SIGNAL \CountUp0|reg0|FFD2|Q~q\ : std_logic;
SIGNAL \Data_in[2]~input_o\ : std_logic;
SIGNAL \CountUp0|Adder0|fulladder1|CyOut~0_combout\ : std_logic;
SIGNAL \CountUp0|Mux0|Y[2]~3_combout\ : std_logic;
SIGNAL \CountUp0|reg0|FFD1|Q~q\ : std_logic;
SIGNAL \Data_in[3]~input_o\ : std_logic;
SIGNAL \CountUp0|Mux0|Y[3]~4_combout\ : std_logic;
SIGNAL \CountUp0|Mux0|Y[3]~5_combout\ : std_logic;
SIGNAL \CountUp0|reg0|FFD0|Q~q\ : std_logic;
SIGNAL \DecHex0|U0|dOut[0]~0_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[0]~0_combout\ : std_logic;
SIGNAL \CLEAR~input_o\ : std_logic;
SIGNAL \DecHex0|HEX0[0]~1_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[1]~2_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[1]~3_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[2]~4_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[2]~5_combout\ : std_logic;
SIGNAL \DecHex0|U0|dOut[3]~1_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[3]~6_combout\ : std_logic;
SIGNAL \DecHex0|U0|dOut[4]~2_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[4]~7_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[5]~8_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[5]~9_combout\ : std_logic;
SIGNAL \DecHex0|U0|dOut[6]~3_combout\ : std_logic;
SIGNAL \DecHex0|HEX0[6]~10_combout\ : std_logic;
SIGNAL \CountUp0|TC~combout\ : std_logic;
SIGNAL \CountUp0|reg0|FFD0|ALT_INV_Q~q\ : std_logic;
SIGNAL \CountUp0|reg0|FFD1|ALT_INV_Q~q\ : std_logic;
SIGNAL \CountUp0|reg0|FFD2|ALT_INV_Q~q\ : std_logic;
SIGNAL \CountUp0|reg0|FFD3|ALT_INV_Q~q\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_Data_in <= Data_in;
ww_CE <= CE;
ww_PL <= PL;
ww_CLK <= CLK;
ww_CLEAR <= CLEAR;
Q <= ww_Q;
SEG7 <= ww_SEG7;
TC <= ww_TC;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\CLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLK~input_o\);
\CountUp0|reg0|FFD0|ALT_INV_Q~q\ <= NOT \CountUp0|reg0|FFD0|Q~q\;
\CountUp0|reg0|FFD1|ALT_INV_Q~q\ <= NOT \CountUp0|reg0|FFD1|Q~q\;
\CountUp0|reg0|FFD2|ALT_INV_Q~q\ <= NOT \CountUp0|reg0|FFD2|Q~q\;
\CountUp0|reg0|FFD3|ALT_INV_Q~q\ <= NOT \CountUp0|reg0|FFD3|Q~q\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y41_N16
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

-- Location: IOOBUF_X78_Y41_N24
\Q[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CountUp0|reg0|FFD3|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Q[0]~output_o\);

-- Location: IOOBUF_X78_Y44_N2
\Q[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CountUp0|reg0|FFD2|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Q[1]~output_o\);

-- Location: IOOBUF_X78_Y41_N16
\Q[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CountUp0|reg0|FFD1|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Q[2]~output_o\);

-- Location: IOOBUF_X78_Y44_N24
\Q[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CountUp0|reg0|FFD0|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Q[3]~output_o\);

-- Location: IOOBUF_X78_Y43_N9
\SEG7[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \DecHex0|HEX0[0]~1_combout\,
	devoe => ww_devoe,
	o => \SEG7[0]~output_o\);

-- Location: IOOBUF_X78_Y42_N23
\SEG7[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \DecHex0|HEX0[1]~3_combout\,
	devoe => ww_devoe,
	o => \SEG7[1]~output_o\);

-- Location: IOOBUF_X78_Y42_N2
\SEG7[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \DecHex0|HEX0[2]~5_combout\,
	devoe => ww_devoe,
	o => \SEG7[2]~output_o\);

-- Location: IOOBUF_X78_Y43_N16
\SEG7[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \DecHex0|HEX0[3]~6_combout\,
	devoe => ww_devoe,
	o => \SEG7[3]~output_o\);

-- Location: IOOBUF_X78_Y43_N2
\SEG7[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \DecHex0|HEX0[4]~7_combout\,
	devoe => ww_devoe,
	o => \SEG7[4]~output_o\);

-- Location: IOOBUF_X78_Y42_N9
\SEG7[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \DecHex0|HEX0[5]~9_combout\,
	devoe => ww_devoe,
	o => \SEG7[5]~output_o\);

-- Location: IOOBUF_X78_Y42_N16
\SEG7[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \DecHex0|HEX0[6]~10_combout\,
	devoe => ww_devoe,
	o => \SEG7[6]~output_o\);

-- Location: IOOBUF_X46_Y54_N30
\SEG7[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \SEG7[7]~output_o\);

-- Location: IOOBUF_X78_Y40_N9
\TC~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CountUp0|TC~combout\,
	devoe => ww_devoe,
	o => \TC~output_o\);

-- Location: IOIBUF_X0_Y18_N15
\CLK~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLK,
	o => \CLK~input_o\);

-- Location: CLKCTRL_G3
\CLK~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLK~inputclkctrl_outclk\);

-- Location: IOIBUF_X78_Y37_N15
\PL~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PL,
	o => \PL~input_o\);

-- Location: IOIBUF_X78_Y40_N1
\Data_in[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Data_in(0),
	o => \Data_in[0]~input_o\);

-- Location: IOIBUF_X78_Y41_N1
\CE~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CE,
	o => \CE~input_o\);

-- Location: LCCOMB_X77_Y40_N24
\CountUp0|Mux0|Y[0]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CountUp0|Mux0|Y[0]~0_combout\ = (\PL~input_o\ & (!\Data_in[0]~input_o\)) # (!\PL~input_o\ & ((\CountUp0|reg0|FFD3|Q~q\ $ (\CE~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010011101110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PL~input_o\,
	datab => \Data_in[0]~input_o\,
	datac => \CountUp0|reg0|FFD3|Q~q\,
	datad => \CE~input_o\,
	combout => \CountUp0|Mux0|Y[0]~0_combout\);

-- Location: FF_X77_Y40_N25
\CountUp0|reg0|FFD3|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \CountUp0|Mux0|Y[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CountUp0|reg0|FFD3|Q~q\);

-- Location: IOIBUF_X78_Y41_N8
\Data_in[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Data_in(1),
	o => \Data_in[1]~input_o\);

-- Location: LCCOMB_X77_Y40_N18
\CountUp0|Mux0|Y[1]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CountUp0|Mux0|Y[1]~1_combout\ = (!\PL~input_o\ & (\CountUp0|reg0|FFD2|Q~q\ $ (((\CountUp0|reg0|FFD3|Q~q\) # (!\CE~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010101000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PL~input_o\,
	datab => \CE~input_o\,
	datac => \CountUp0|reg0|FFD2|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \CountUp0|Mux0|Y[1]~1_combout\);

-- Location: LCCOMB_X77_Y40_N14
\CountUp0|Mux0|Y[1]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CountUp0|Mux0|Y[1]~2_combout\ = (!\CountUp0|Mux0|Y[1]~1_combout\ & ((!\PL~input_o\) # (!\Data_in[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Data_in[1]~input_o\,
	datac => \PL~input_o\,
	datad => \CountUp0|Mux0|Y[1]~1_combout\,
	combout => \CountUp0|Mux0|Y[1]~2_combout\);

-- Location: FF_X77_Y40_N15
\CountUp0|reg0|FFD2|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \CountUp0|Mux0|Y[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CountUp0|reg0|FFD2|Q~q\);

-- Location: IOIBUF_X78_Y40_N22
\Data_in[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Data_in(2),
	o => \Data_in[2]~input_o\);

-- Location: LCCOMB_X77_Y40_N28
\CountUp0|Adder0|fulladder1|CyOut~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CountUp0|Adder0|fulladder1|CyOut~0_combout\ = (\CE~input_o\ & (!\CountUp0|reg0|FFD2|Q~q\ & !\CountUp0|reg0|FFD3|Q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \CE~input_o\,
	datac => \CountUp0|reg0|FFD2|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \CountUp0|Adder0|fulladder1|CyOut~0_combout\);

-- Location: LCCOMB_X77_Y40_N20
\CountUp0|Mux0|Y[2]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CountUp0|Mux0|Y[2]~3_combout\ = (\PL~input_o\ & (!\Data_in[2]~input_o\)) # (!\PL~input_o\ & ((\CountUp0|reg0|FFD1|Q~q\ $ (\CountUp0|Adder0|fulladder1|CyOut~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010011101110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PL~input_o\,
	datab => \Data_in[2]~input_o\,
	datac => \CountUp0|reg0|FFD1|Q~q\,
	datad => \CountUp0|Adder0|fulladder1|CyOut~0_combout\,
	combout => \CountUp0|Mux0|Y[2]~3_combout\);

-- Location: FF_X77_Y40_N21
\CountUp0|reg0|FFD1|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \CountUp0|Mux0|Y[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CountUp0|reg0|FFD1|Q~q\);

-- Location: IOIBUF_X78_Y40_N15
\Data_in[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Data_in(3),
	o => \Data_in[3]~input_o\);

-- Location: LCCOMB_X77_Y40_N22
\CountUp0|Mux0|Y[3]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CountUp0|Mux0|Y[3]~4_combout\ = (\PL~input_o\ & (\Data_in[3]~input_o\)) # (!\PL~input_o\ & ((!\CountUp0|reg0|FFD1|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Data_in[3]~input_o\,
	datac => \PL~input_o\,
	datad => \CountUp0|reg0|FFD1|Q~q\,
	combout => \CountUp0|Mux0|Y[3]~4_combout\);

-- Location: LCCOMB_X77_Y40_N2
\CountUp0|Mux0|Y[3]~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CountUp0|Mux0|Y[3]~5_combout\ = (\PL~input_o\ & (!\CountUp0|Mux0|Y[3]~4_combout\)) # (!\PL~input_o\ & (\CountUp0|reg0|FFD0|Q~q\ $ (((\CountUp0|Mux0|Y[3]~4_combout\ & \CountUp0|Adder0|fulladder1|CyOut~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101011001110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|Mux0|Y[3]~4_combout\,
	datab => \PL~input_o\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CountUp0|Adder0|fulladder1|CyOut~0_combout\,
	combout => \CountUp0|Mux0|Y[3]~5_combout\);

-- Location: FF_X77_Y40_N3
\CountUp0|reg0|FFD0|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \CountUp0|Mux0|Y[3]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CountUp0|reg0|FFD0|Q~q\);

-- Location: LCCOMB_X77_Y42_N12
\DecHex0|U0|dOut[0]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|U0|dOut[0]~0_combout\ = (\CountUp0|reg0|FFD1|Q~q\ & (!\CountUp0|reg0|FFD2|Q~q\ & (!\CountUp0|reg0|FFD0|Q~q\ & !\CountUp0|reg0|FFD3|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD1|Q~q\,
	datab => \CountUp0|reg0|FFD2|Q~q\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \DecHex0|U0|dOut[0]~0_combout\);

-- Location: LCCOMB_X77_Y42_N22
\DecHex0|HEX0[0]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[0]~0_combout\ = (\CountUp0|reg0|FFD1|Q~q\ & ((\CountUp0|reg0|FFD3|Q~q\) # (!\CountUp0|reg0|FFD0|Q~q\))) # (!\CountUp0|reg0|FFD1|Q~q\ & (\CountUp0|reg0|FFD0|Q~q\ $ (\CountUp0|reg0|FFD3|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD1|Q~q\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \DecHex0|HEX0[0]~0_combout\);

-- Location: IOIBUF_X78_Y43_N22
\CLEAR~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLEAR,
	o => \CLEAR~input_o\);

-- Location: LCCOMB_X77_Y42_N28
\DecHex0|HEX0[0]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[0]~1_combout\ = (\DecHex0|U0|dOut[0]~0_combout\) # ((\CLEAR~input_o\) # ((\CountUp0|reg0|FFD2|Q~q\ & !\DecHex0|HEX0[0]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \DecHex0|U0|dOut[0]~0_combout\,
	datab => \CountUp0|reg0|FFD2|Q~q\,
	datac => \DecHex0|HEX0[0]~0_combout\,
	datad => \CLEAR~input_o\,
	combout => \DecHex0|HEX0[0]~1_combout\);

-- Location: LCCOMB_X77_Y42_N14
\DecHex0|HEX0[1]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[1]~2_combout\ = (!\CountUp0|reg0|FFD1|Q~q\ & ((\CountUp0|reg0|FFD2|Q~q\ & (\CountUp0|reg0|FFD0|Q~q\ $ (\CountUp0|reg0|FFD3|Q~q\))) # (!\CountUp0|reg0|FFD2|Q~q\ & ((\CountUp0|reg0|FFD3|Q~q\) # (!\CountUp0|reg0|FFD0|Q~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010101000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD1|Q~q\,
	datab => \CountUp0|reg0|FFD2|Q~q\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \DecHex0|HEX0[1]~2_combout\);

-- Location: LCCOMB_X77_Y42_N4
\DecHex0|HEX0[1]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[1]~3_combout\ = (\DecHex0|U0|dOut[0]~0_combout\) # ((\DecHex0|HEX0[1]~2_combout\) # (\CLEAR~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \DecHex0|U0|dOut[0]~0_combout\,
	datac => \DecHex0|HEX0[1]~2_combout\,
	datad => \CLEAR~input_o\,
	combout => \DecHex0|HEX0[1]~3_combout\);

-- Location: LCCOMB_X77_Y42_N6
\DecHex0|HEX0[2]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[2]~4_combout\ = (\CountUp0|reg0|FFD2|Q~q\ & (!\CountUp0|reg0|FFD0|Q~q\ & !\CountUp0|reg0|FFD3|Q~q\)) # (!\CountUp0|reg0|FFD2|Q~q\ & (\CountUp0|reg0|FFD0|Q~q\ & \CountUp0|reg0|FFD3|Q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \CountUp0|reg0|FFD2|Q~q\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \DecHex0|HEX0[2]~4_combout\);

-- Location: LCCOMB_X77_Y42_N8
\DecHex0|HEX0[2]~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[2]~5_combout\ = (\CLEAR~input_o\) # ((\CountUp0|reg0|FFD1|Q~q\ & (\CountUp0|reg0|FFD0|Q~q\ & \DecHex0|HEX0[2]~4_combout\)) # (!\CountUp0|reg0|FFD1|Q~q\ & (!\CountUp0|reg0|FFD0|Q~q\ & !\DecHex0|HEX0[2]~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD1|Q~q\,
	datab => \CountUp0|reg0|FFD0|Q~q\,
	datac => \DecHex0|HEX0[2]~4_combout\,
	datad => \CLEAR~input_o\,
	combout => \DecHex0|HEX0[2]~5_combout\);

-- Location: LCCOMB_X77_Y42_N18
\DecHex0|U0|dOut[3]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|U0|dOut[3]~1_combout\ = (\CountUp0|reg0|FFD3|Q~q\ & ((\CountUp0|reg0|FFD1|Q~q\ & (!\CountUp0|reg0|FFD2|Q~q\ & !\CountUp0|reg0|FFD0|Q~q\)) # (!\CountUp0|reg0|FFD1|Q~q\ & (\CountUp0|reg0|FFD2|Q~q\ & \CountUp0|reg0|FFD0|Q~q\)))) # 
-- (!\CountUp0|reg0|FFD3|Q~q\ & (\CountUp0|reg0|FFD1|Q~q\ $ ((!\CountUp0|reg0|FFD2|Q~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100001010011001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD1|Q~q\,
	datab => \CountUp0|reg0|FFD2|Q~q\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \DecHex0|U0|dOut[3]~1_combout\);

-- Location: LCCOMB_X77_Y42_N24
\DecHex0|HEX0[3]~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[3]~6_combout\ = (\DecHex0|U0|dOut[3]~1_combout\) # (\CLEAR~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \DecHex0|U0|dOut[3]~1_combout\,
	datad => \CLEAR~input_o\,
	combout => \DecHex0|HEX0[3]~6_combout\);

-- Location: LCCOMB_X77_Y42_N30
\DecHex0|U0|dOut[4]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|U0|dOut[4]~2_combout\ = (\CountUp0|reg0|FFD2|Q~q\ & ((\CountUp0|reg0|FFD1|Q~q\ & ((!\CountUp0|reg0|FFD3|Q~q\))) # (!\CountUp0|reg0|FFD1|Q~q\ & (\CountUp0|reg0|FFD0|Q~q\)))) # (!\CountUp0|reg0|FFD2|Q~q\ & (((\CountUp0|reg0|FFD0|Q~q\ & 
-- !\CountUp0|reg0|FFD3|Q~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD1|Q~q\,
	datab => \CountUp0|reg0|FFD2|Q~q\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \DecHex0|U0|dOut[4]~2_combout\);

-- Location: LCCOMB_X77_Y42_N0
\DecHex0|HEX0[4]~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[4]~7_combout\ = (\DecHex0|U0|dOut[4]~2_combout\) # (\CLEAR~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \DecHex0|U0|dOut[4]~2_combout\,
	datad => \CLEAR~input_o\,
	combout => \DecHex0|HEX0[4]~7_combout\);

-- Location: LCCOMB_X77_Y42_N2
\DecHex0|HEX0[5]~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[5]~8_combout\ = (\CountUp0|reg0|FFD3|Q~q\ & (!\CountUp0|reg0|FFD2|Q~q\ & \CountUp0|reg0|FFD1|Q~q\)) # (!\CountUp0|reg0|FFD3|Q~q\ & (\CountUp0|reg0|FFD2|Q~q\ & !\CountUp0|reg0|FFD1|Q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \CountUp0|reg0|FFD3|Q~q\,
	datac => \CountUp0|reg0|FFD2|Q~q\,
	datad => \CountUp0|reg0|FFD1|Q~q\,
	combout => \DecHex0|HEX0[5]~8_combout\);

-- Location: LCCOMB_X77_Y42_N16
\DecHex0|HEX0[5]~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[5]~9_combout\ = (\CLEAR~input_o\) # ((\CountUp0|reg0|FFD3|Q~q\ & (\DecHex0|HEX0[5]~8_combout\ & \CountUp0|reg0|FFD0|Q~q\)) # (!\CountUp0|reg0|FFD3|Q~q\ & (\DecHex0|HEX0[5]~8_combout\ $ (\CountUp0|reg0|FFD0|Q~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD3|Q~q\,
	datab => \DecHex0|HEX0[5]~8_combout\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CLEAR~input_o\,
	combout => \DecHex0|HEX0[5]~9_combout\);

-- Location: LCCOMB_X77_Y42_N26
\DecHex0|U0|dOut[6]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|U0|dOut[6]~3_combout\ = (\CountUp0|reg0|FFD3|Q~q\ & ((\CountUp0|reg0|FFD1|Q~q\ $ (\CountUp0|reg0|FFD0|Q~q\)) # (!\CountUp0|reg0|FFD2|Q~q\))) # (!\CountUp0|reg0|FFD3|Q~q\ & ((\CountUp0|reg0|FFD1|Q~q\ $ (\CountUp0|reg0|FFD2|Q~q\)) # 
-- (!\CountUp0|reg0|FFD0|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111101101101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD1|Q~q\,
	datab => \CountUp0|reg0|FFD2|Q~q\,
	datac => \CountUp0|reg0|FFD0|Q~q\,
	datad => \CountUp0|reg0|FFD3|Q~q\,
	combout => \DecHex0|U0|dOut[6]~3_combout\);

-- Location: LCCOMB_X77_Y42_N20
\DecHex0|HEX0[6]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \DecHex0|HEX0[6]~10_combout\ = (\CLEAR~input_o\) # (!\DecHex0|U0|dOut[6]~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \DecHex0|U0|dOut[6]~3_combout\,
	datad => \CLEAR~input_o\,
	combout => \DecHex0|HEX0[6]~10_combout\);

-- Location: LCCOMB_X77_Y40_N16
\CountUp0|TC\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CountUp0|TC~combout\ = (!\CountUp0|reg0|FFD1|Q~q\ & (!\CountUp0|reg0|FFD0|Q~q\ & (!\CountUp0|reg0|FFD3|Q~q\ & !\CountUp0|reg0|FFD2|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CountUp0|reg0|FFD1|Q~q\,
	datab => \CountUp0|reg0|FFD0|Q~q\,
	datac => \CountUp0|reg0|FFD3|Q~q\,
	datad => \CountUp0|reg0|FFD2|Q~q\,
	combout => \CountUp0|TC~combout\);

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

ww_Q(0) <= \Q[0]~output_o\;

ww_Q(1) <= \Q[1]~output_o\;

ww_Q(2) <= \Q[2]~output_o\;

ww_Q(3) <= \Q[3]~output_o\;

ww_SEG7(0) <= \SEG7[0]~output_o\;

ww_SEG7(1) <= \SEG7[1]~output_o\;

ww_SEG7(2) <= \SEG7[2]~output_o\;

ww_SEG7(3) <= \SEG7[3]~output_o\;

ww_SEG7(4) <= \SEG7[4]~output_o\;

ww_SEG7(5) <= \SEG7[5]~output_o\;

ww_SEG7(6) <= \SEG7[6]~output_o\;

ww_SEG7(7) <= \SEG7[7]~output_o\;

ww_TC <= \TC~output_o\;
END structure;


