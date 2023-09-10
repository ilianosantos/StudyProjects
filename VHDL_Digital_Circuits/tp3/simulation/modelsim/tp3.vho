-- Copyright (C) 2020  Intel Corporation. All rights reserved.
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
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "01/09/2023 15:04:46"

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

ENTITY 	divisor IS
    PORT (
	RESET : IN std_logic;
	CLK : IN std_logic;
	Start : IN std_logic;
	Dividendo : IN std_logic_vector(3 DOWNTO 0);
	Divis : IN std_logic_vector(3 DOWNTO 0);
	Rdy : OUT std_logic;
	Quociente : OUT std_logic_vector(3 DOWNTO 0);
	Resto : OUT std_logic_vector(3 DOWNTO 0);
	HEX0 : OUT std_logic_vector(7 DOWNTO 0);
	HEX1 : OUT std_logic_vector(7 DOWNTO 0);
	HEX4 : OUT std_logic_vector(7 DOWNTO 0);
	HEX5 : OUT std_logic_vector(7 DOWNTO 0)
	);
END divisor;

-- Design Ports Information
-- Rdy	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Quociente[0]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Quociente[1]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Quociente[2]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Quociente[3]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Resto[0]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Resto[1]	=>  Location: PIN_E14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Resto[2]	=>  Location: PIN_D14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Resto[3]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[0]	=>  Location: PIN_C14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[1]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[2]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[3]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[4]	=>  Location: PIN_E16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[5]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[6]	=>  Location: PIN_C17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[7]	=>  Location: PIN_D15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[0]	=>  Location: PIN_C18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[1]	=>  Location: PIN_D18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[2]	=>  Location: PIN_E18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[3]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[4]	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[5]	=>  Location: PIN_A18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[6]	=>  Location: PIN_B17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[7]	=>  Location: PIN_A16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX4[0]	=>  Location: PIN_F18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX4[1]	=>  Location: PIN_E20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX4[2]	=>  Location: PIN_E19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX4[3]	=>  Location: PIN_J18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX4[4]	=>  Location: PIN_H19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX4[5]	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX4[6]	=>  Location: PIN_F20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX4[7]	=>  Location: PIN_F17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX5[0]	=>  Location: PIN_J20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX5[1]	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX5[2]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX5[3]	=>  Location: PIN_N18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX5[4]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX5[5]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX5[6]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX5[7]	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Start	=>  Location: PIN_B14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RESET	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Dividendo[0]	=>  Location: PIN_C10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Dividendo[1]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Dividendo[2]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Dividendo[3]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Divis[3]	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Divis[2]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Divis[1]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Divis[0]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF divisor IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_RESET : std_logic;
SIGNAL ww_CLK : std_logic;
SIGNAL ww_Start : std_logic;
SIGNAL ww_Dividendo : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Divis : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Rdy : std_logic;
SIGNAL ww_Quociente : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Resto : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_HEX0 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_HEX1 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_HEX4 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_HEX5 : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \CLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \Rdy~output_o\ : std_logic;
SIGNAL \Quociente[0]~output_o\ : std_logic;
SIGNAL \Quociente[1]~output_o\ : std_logic;
SIGNAL \Quociente[2]~output_o\ : std_logic;
SIGNAL \Quociente[3]~output_o\ : std_logic;
SIGNAL \Resto[0]~output_o\ : std_logic;
SIGNAL \Resto[1]~output_o\ : std_logic;
SIGNAL \Resto[2]~output_o\ : std_logic;
SIGNAL \Resto[3]~output_o\ : std_logic;
SIGNAL \HEX0[0]~output_o\ : std_logic;
SIGNAL \HEX0[1]~output_o\ : std_logic;
SIGNAL \HEX0[2]~output_o\ : std_logic;
SIGNAL \HEX0[3]~output_o\ : std_logic;
SIGNAL \HEX0[4]~output_o\ : std_logic;
SIGNAL \HEX0[5]~output_o\ : std_logic;
SIGNAL \HEX0[6]~output_o\ : std_logic;
SIGNAL \HEX0[7]~output_o\ : std_logic;
SIGNAL \HEX1[0]~output_o\ : std_logic;
SIGNAL \HEX1[1]~output_o\ : std_logic;
SIGNAL \HEX1[2]~output_o\ : std_logic;
SIGNAL \HEX1[3]~output_o\ : std_logic;
SIGNAL \HEX1[4]~output_o\ : std_logic;
SIGNAL \HEX1[5]~output_o\ : std_logic;
SIGNAL \HEX1[6]~output_o\ : std_logic;
SIGNAL \HEX1[7]~output_o\ : std_logic;
SIGNAL \HEX4[0]~output_o\ : std_logic;
SIGNAL \HEX4[1]~output_o\ : std_logic;
SIGNAL \HEX4[2]~output_o\ : std_logic;
SIGNAL \HEX4[3]~output_o\ : std_logic;
SIGNAL \HEX4[4]~output_o\ : std_logic;
SIGNAL \HEX4[5]~output_o\ : std_logic;
SIGNAL \HEX4[6]~output_o\ : std_logic;
SIGNAL \HEX4[7]~output_o\ : std_logic;
SIGNAL \HEX5[0]~output_o\ : std_logic;
SIGNAL \HEX5[1]~output_o\ : std_logic;
SIGNAL \HEX5[2]~output_o\ : std_logic;
SIGNAL \HEX5[3]~output_o\ : std_logic;
SIGNAL \HEX5[4]~output_o\ : std_logic;
SIGNAL \HEX5[5]~output_o\ : std_logic;
SIGNAL \HEX5[6]~output_o\ : std_logic;
SIGNAL \HEX5[7]~output_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \CLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \Start~input_o\ : std_logic;
SIGNAL \U_ROM|Mux1~0_combout\ : std_logic;
SIGNAL \RESET~input_o\ : std_logic;
SIGNAL \U_ROM|U_FF0|Q~q\ : std_logic;
SIGNAL \U_ROM|Mux2~2_combout\ : std_logic;
SIGNAL \Dividendo[3]~input_o\ : std_logic;
SIGNAL \Divis[2]~input_o\ : std_logic;
SIGNAL \U_caminhoDados|Reg1|FFD1|Q~0_combout\ : std_logic;
SIGNAL \U_ROM|Mux2~1_combout\ : std_logic;
SIGNAL \U_caminhoDados|Reg1|FFD1|Q~q\ : std_logic;
SIGNAL \Divis[1]~input_o\ : std_logic;
SIGNAL \U_caminhoDados|Reg1|FFD2|Q~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|Reg1|FFD2|Q~q\ : std_logic;
SIGNAL \Divis[0]~input_o\ : std_logic;
SIGNAL \U_caminhoDados|Reg1|FFD3|Q~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|Reg1|FFD3|Q~q\ : std_logic;
SIGNAL \Dividendo[0]~input_o\ : std_logic;
SIGNAL \U_caminhoDados|Mux0|R[0]~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|Reg0|FFD3|Q~q\ : std_logic;
SIGNAL \Dividendo[1]~input_o\ : std_logic;
SIGNAL \U_caminhoDados|Sub0|adder0|fulladder1|R~combout\ : std_logic;
SIGNAL \U_caminhoDados|Mux0|R[1]~1_combout\ : std_logic;
SIGNAL \U_caminhoDados|Reg0|FFD2|Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\ : std_logic;
SIGNAL \Dividendo[2]~input_o\ : std_logic;
SIGNAL \U_caminhoDados|Sub0|adder0|fulladder2|R~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|Mux0|R[2]~2_combout\ : std_logic;
SIGNAL \U_caminhoDados|Reg0|FFD1|Q~q\ : std_logic;
SIGNAL \Divis[3]~input_o\ : std_logic;
SIGNAL \U_caminhoDados|Reg1|FFD0|Q~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|Reg1|FFD0|Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Mux0|R[3]~3_combout\ : std_logic;
SIGNAL \U_caminhoDados|Mux0|R[3]~4_combout\ : std_logic;
SIGNAL \U_caminhoDados|Reg0|FFD0|Q~q\ : std_logic;
SIGNAL \U_ROM|Mux0~0_combout\ : std_logic;
SIGNAL \U_ROM|Mux0~1_combout\ : std_logic;
SIGNAL \U_ROM|Mux0~2_combout\ : std_logic;
SIGNAL \U_ROM|U_FF1|Q~q\ : std_logic;
SIGNAL \U_ROM|Mux2~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|Mux0|R~2_combout\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|reg0|FFD3|Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|Mux0|R~3_combout\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|reg0|FFD2|Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|Mux0|R~5_combout\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|reg0|FFD1|Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|Mux0|R~4_combout\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|reg0|FFD0|Q~q\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[0]~8_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[0]~14_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[1]~9_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[2]~10_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|UR0|Ndout[3]~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[3]~15_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[4]~11_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[5]~12_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[5]~16_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[6]~13_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX0[6]~17_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX1[0]~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[0]~8_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[0]~14_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[1]~9_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[2]~10_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|UQ0|Ndout[3]~0_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[3]~15_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[4]~11_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[5]~12_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[5]~16_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[6]~13_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX4[6]~17_combout\ : std_logic;
SIGNAL \U_caminhoDados|DecHex0|HEX5[0]~0_combout\ : std_logic;
SIGNAL \ALT_INV_RESET~input_o\ : std_logic;
SIGNAL \U_caminhoDados|Reg0|FFD0|ALT_INV_Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Reg0|FFD1|ALT_INV_Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Reg0|FFD2|ALT_INV_Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Reg0|FFD3|ALT_INV_Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|reg0|FFD0|ALT_INV_Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|reg0|FFD1|ALT_INV_Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|reg0|FFD2|ALT_INV_Q~q\ : std_logic;
SIGNAL \U_caminhoDados|Cont0|reg0|FFD3|ALT_INV_Q~q\ : std_logic;
SIGNAL \U_ROM|ALT_INV_Mux2~0_combout\ : std_logic;
SIGNAL \U_ROM|U_FF1|ALT_INV_Q~q\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_RESET <= RESET;
ww_CLK <= CLK;
ww_Start <= Start;
ww_Dividendo <= Dividendo;
ww_Divis <= Divis;
Rdy <= ww_Rdy;
Quociente <= ww_Quociente;
Resto <= ww_Resto;
HEX0 <= ww_HEX0;
HEX1 <= ww_HEX1;
HEX4 <= ww_HEX4;
HEX5 <= ww_HEX5;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\CLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLK~input_o\);
\ALT_INV_RESET~input_o\ <= NOT \RESET~input_o\;
\U_caminhoDados|Reg0|FFD0|ALT_INV_Q~q\ <= NOT \U_caminhoDados|Reg0|FFD0|Q~q\;
\U_caminhoDados|Reg0|FFD1|ALT_INV_Q~q\ <= NOT \U_caminhoDados|Reg0|FFD1|Q~q\;
\U_caminhoDados|Reg0|FFD2|ALT_INV_Q~q\ <= NOT \U_caminhoDados|Reg0|FFD2|Q~q\;
\U_caminhoDados|Reg0|FFD3|ALT_INV_Q~q\ <= NOT \U_caminhoDados|Reg0|FFD3|Q~q\;
\U_caminhoDados|Cont0|reg0|FFD0|ALT_INV_Q~q\ <= NOT \U_caminhoDados|Cont0|reg0|FFD0|Q~q\;
\U_caminhoDados|Cont0|reg0|FFD1|ALT_INV_Q~q\ <= NOT \U_caminhoDados|Cont0|reg0|FFD1|Q~q\;
\U_caminhoDados|Cont0|reg0|FFD2|ALT_INV_Q~q\ <= NOT \U_caminhoDados|Cont0|reg0|FFD2|Q~q\;
\U_caminhoDados|Cont0|reg0|FFD3|ALT_INV_Q~q\ <= NOT \U_caminhoDados|Cont0|reg0|FFD3|Q~q\;
\U_ROM|ALT_INV_Mux2~0_combout\ <= NOT \U_ROM|Mux2~0_combout\;
\U_ROM|U_FF1|ALT_INV_Q~q\ <= NOT \U_ROM|U_FF1|Q~q\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y45_N20
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

-- Location: IOOBUF_X46_Y54_N2
\Rdy~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_ROM|Mux2~0_combout\,
	devoe => ww_devoe,
	o => \Rdy~output_o\);

-- Location: IOOBUF_X46_Y54_N23
\Quociente[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|Cont0|reg0|FFD3|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Quociente[0]~output_o\);

-- Location: IOOBUF_X51_Y54_N16
\Quociente[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|Cont0|reg0|FFD2|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Quociente[1]~output_o\);

-- Location: IOOBUF_X46_Y54_N9
\Quociente[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|Cont0|reg0|FFD1|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Quociente[2]~output_o\);

-- Location: IOOBUF_X56_Y54_N30
\Quociente[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|Cont0|reg0|FFD0|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Quociente[3]~output_o\);

-- Location: IOOBUF_X58_Y54_N23
\Resto[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|Reg0|FFD3|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Resto[0]~output_o\);

-- Location: IOOBUF_X66_Y54_N23
\Resto[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|Reg0|FFD2|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Resto[1]~output_o\);

-- Location: IOOBUF_X56_Y54_N9
\Resto[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|Reg0|FFD1|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Resto[2]~output_o\);

-- Location: IOOBUF_X51_Y54_N9
\Resto[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|Reg0|FFD0|ALT_INV_Q~q\,
	devoe => ww_devoe,
	o => \Resto[3]~output_o\);

-- Location: IOOBUF_X58_Y54_N16
\HEX0[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX0[0]~14_combout\,
	devoe => ww_devoe,
	o => \HEX0[0]~output_o\);

-- Location: IOOBUF_X74_Y54_N9
\HEX0[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX0[1]~9_combout\,
	devoe => ww_devoe,
	o => \HEX0[1]~output_o\);

-- Location: IOOBUF_X60_Y54_N2
\HEX0[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX0[2]~10_combout\,
	devoe => ww_devoe,
	o => \HEX0[2]~output_o\);

-- Location: IOOBUF_X62_Y54_N30
\HEX0[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX0[3]~15_combout\,
	devoe => ww_devoe,
	o => \HEX0[3]~output_o\);

-- Location: IOOBUF_X74_Y54_N2
\HEX0[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX0[4]~11_combout\,
	devoe => ww_devoe,
	o => \HEX0[4]~output_o\);

-- Location: IOOBUF_X74_Y54_N16
\HEX0[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX0[5]~16_combout\,
	devoe => ww_devoe,
	o => \HEX0[5]~output_o\);

-- Location: IOOBUF_X74_Y54_N23
\HEX0[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX0[6]~17_combout\,
	devoe => ww_devoe,
	o => \HEX0[6]~output_o\);

-- Location: IOOBUF_X66_Y54_N16
\HEX0[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \HEX0[7]~output_o\);

-- Location: IOOBUF_X69_Y54_N23
\HEX1[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX1[0]~0_combout\,
	devoe => ww_devoe,
	o => \HEX1[0]~output_o\);

-- Location: IOOBUF_X78_Y49_N9
\HEX1[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_ROM|ALT_INV_Mux2~0_combout\,
	devoe => ww_devoe,
	o => \HEX1[1]~output_o\);

-- Location: IOOBUF_X78_Y49_N2
\HEX1[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_ROM|ALT_INV_Mux2~0_combout\,
	devoe => ww_devoe,
	o => \HEX1[2]~output_o\);

-- Location: IOOBUF_X60_Y54_N9
\HEX1[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX1[0]~0_combout\,
	devoe => ww_devoe,
	o => \HEX1[3]~output_o\);

-- Location: IOOBUF_X64_Y54_N2
\HEX1[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX1[0]~0_combout\,
	devoe => ww_devoe,
	o => \HEX1[4]~output_o\);

-- Location: IOOBUF_X66_Y54_N30
\HEX1[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX1[0]~0_combout\,
	devoe => ww_devoe,
	o => \HEX1[5]~output_o\);

-- Location: IOOBUF_X69_Y54_N30
\HEX1[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \HEX1[6]~output_o\);

-- Location: IOOBUF_X60_Y54_N16
\HEX1[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \HEX1[7]~output_o\);

-- Location: IOOBUF_X78_Y40_N16
\HEX4[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX4[0]~14_combout\,
	devoe => ww_devoe,
	o => \HEX4[0]~output_o\);

-- Location: IOOBUF_X78_Y40_N2
\HEX4[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX4[1]~9_combout\,
	devoe => ww_devoe,
	o => \HEX4[1]~output_o\);

-- Location: IOOBUF_X78_Y40_N23
\HEX4[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX4[2]~10_combout\,
	devoe => ww_devoe,
	o => \HEX4[2]~output_o\);

-- Location: IOOBUF_X78_Y42_N16
\HEX4[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX4[3]~15_combout\,
	devoe => ww_devoe,
	o => \HEX4[3]~output_o\);

-- Location: IOOBUF_X78_Y45_N23
\HEX4[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX4[4]~11_combout\,
	devoe => ww_devoe,
	o => \HEX4[4]~output_o\);

-- Location: IOOBUF_X78_Y40_N9
\HEX4[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX4[5]~16_combout\,
	devoe => ww_devoe,
	o => \HEX4[5]~output_o\);

-- Location: IOOBUF_X78_Y35_N16
\HEX4[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX4[6]~17_combout\,
	devoe => ww_devoe,
	o => \HEX4[6]~output_o\);

-- Location: IOOBUF_X78_Y43_N23
\HEX4[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \HEX4[7]~output_o\);

-- Location: IOOBUF_X78_Y45_N9
\HEX5[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX5[0]~0_combout\,
	devoe => ww_devoe,
	o => \HEX5[0]~output_o\);

-- Location: IOOBUF_X78_Y42_N2
\HEX5[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_ROM|ALT_INV_Mux2~0_combout\,
	devoe => ww_devoe,
	o => \HEX5[1]~output_o\);

-- Location: IOOBUF_X78_Y37_N16
\HEX5[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_ROM|ALT_INV_Mux2~0_combout\,
	devoe => ww_devoe,
	o => \HEX5[2]~output_o\);

-- Location: IOOBUF_X78_Y34_N24
\HEX5[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX5[0]~0_combout\,
	devoe => ww_devoe,
	o => \HEX5[3]~output_o\);

-- Location: IOOBUF_X78_Y34_N9
\HEX5[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX5[0]~0_combout\,
	devoe => ww_devoe,
	o => \HEX5[4]~output_o\);

-- Location: IOOBUF_X78_Y34_N16
\HEX5[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_caminhoDados|DecHex0|HEX5[0]~0_combout\,
	devoe => ww_devoe,
	o => \HEX5[5]~output_o\);

-- Location: IOOBUF_X78_Y34_N2
\HEX5[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \HEX5[6]~output_o\);

-- Location: IOOBUF_X78_Y37_N9
\HEX5[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \HEX5[7]~output_o\);

-- Location: IOIBUF_X34_Y0_N29
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

-- Location: CLKCTRL_G19
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

-- Location: IOIBUF_X56_Y54_N1
\Start~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Start,
	o => \Start~input_o\);

-- Location: LCCOMB_X65_Y53_N8
\U_ROM|Mux1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_ROM|Mux1~0_combout\ = (\U_ROM|U_FF1|Q~q\ & ((\Start~input_o\) # (!\U_ROM|U_FF0|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Start~input_o\,
	datac => \U_ROM|U_FF0|Q~q\,
	datad => \U_ROM|U_FF1|Q~q\,
	combout => \U_ROM|Mux1~0_combout\);

-- Location: IOIBUF_X69_Y54_N1
\RESET~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RESET,
	o => \RESET~input_o\);

-- Location: FF_X65_Y53_N9
\U_ROM|U_FF0|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_ROM|Mux1~0_combout\,
	clrn => \ALT_INV_RESET~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_ROM|U_FF0|Q~q\);

-- Location: LCCOMB_X64_Y53_N30
\U_ROM|Mux2~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_ROM|Mux2~2_combout\ = (\U_ROM|U_FF0|Q~q\ & !\U_ROM|U_FF1|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U_ROM|U_FF0|Q~q\,
	datad => \U_ROM|U_FF1|Q~q\,
	combout => \U_ROM|Mux2~2_combout\);

-- Location: IOIBUF_X54_Y54_N29
\Dividendo[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Dividendo(3),
	o => \Dividendo[3]~input_o\);

-- Location: IOIBUF_X54_Y54_N15
\Divis[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Divis(2),
	o => \Divis[2]~input_o\);

-- Location: LCCOMB_X65_Y53_N12
\U_caminhoDados|Reg1|FFD1|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Reg1|FFD1|Q~0_combout\ = !\Divis[2]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Divis[2]~input_o\,
	combout => \U_caminhoDados|Reg1|FFD1|Q~0_combout\);

-- Location: LCCOMB_X65_Y53_N18
\U_ROM|Mux2~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_ROM|Mux2~1_combout\ = (!\U_ROM|U_FF0|Q~q\ & !\U_ROM|U_FF1|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U_ROM|U_FF0|Q~q\,
	datad => \U_ROM|U_FF1|Q~q\,
	combout => \U_ROM|Mux2~1_combout\);

-- Location: FF_X65_Y53_N13
\U_caminhoDados|Reg1|FFD1|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Reg1|FFD1|Q~0_combout\,
	ena => \U_ROM|Mux2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Reg1|FFD1|Q~q\);

-- Location: IOIBUF_X49_Y54_N1
\Divis[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Divis(1),
	o => \Divis[1]~input_o\);

-- Location: LCCOMB_X54_Y53_N28
\U_caminhoDados|Reg1|FFD2|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Reg1|FFD2|Q~0_combout\ = !\Divis[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Divis[1]~input_o\,
	combout => \U_caminhoDados|Reg1|FFD2|Q~0_combout\);

-- Location: FF_X65_Y53_N27
\U_caminhoDados|Reg1|FFD2|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \U_caminhoDados|Reg1|FFD2|Q~0_combout\,
	sload => VCC,
	ena => \U_ROM|Mux2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Reg1|FFD2|Q~q\);

-- Location: IOIBUF_X54_Y54_N22
\Divis[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Divis(0),
	o => \Divis[0]~input_o\);

-- Location: LCCOMB_X64_Y53_N4
\U_caminhoDados|Reg1|FFD3|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Reg1|FFD3|Q~0_combout\ = !\Divis[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Divis[0]~input_o\,
	combout => \U_caminhoDados|Reg1|FFD3|Q~0_combout\);

-- Location: FF_X65_Y53_N5
\U_caminhoDados|Reg1|FFD3|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \U_caminhoDados|Reg1|FFD3|Q~0_combout\,
	sload => VCC,
	ena => \U_ROM|Mux2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Reg1|FFD3|Q~q\);

-- Location: IOIBUF_X51_Y54_N29
\Dividendo[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Dividendo(0),
	o => \Dividendo[0]~input_o\);

-- Location: LCCOMB_X64_Y53_N6
\U_caminhoDados|Mux0|R[0]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Mux0|R[0]~0_combout\ = (\U_ROM|Mux2~2_combout\ & ((\U_caminhoDados|Reg0|FFD3|Q~q\ $ (!\U_caminhoDados|Reg1|FFD3|Q~q\)))) # (!\U_ROM|Mux2~2_combout\ & (!\Dividendo[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000100011011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|Mux2~2_combout\,
	datab => \Dividendo[0]~input_o\,
	datac => \U_caminhoDados|Reg0|FFD3|Q~q\,
	datad => \U_caminhoDados|Reg1|FFD3|Q~q\,
	combout => \U_caminhoDados|Mux0|R[0]~0_combout\);

-- Location: FF_X64_Y53_N7
\U_caminhoDados|Reg0|FFD3|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Mux0|R[0]~0_combout\,
	ena => \U_ROM|U_FF1|ALT_INV_Q~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Reg0|FFD3|Q~q\);

-- Location: IOIBUF_X51_Y54_N22
\Dividendo[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Dividendo(1),
	o => \Dividendo[1]~input_o\);

-- Location: LCCOMB_X64_Y53_N0
\U_caminhoDados|Sub0|adder0|fulladder1|R\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Sub0|adder0|fulladder1|R~combout\ = \U_caminhoDados|Reg0|FFD2|Q~q\ $ (\U_caminhoDados|Reg1|FFD2|Q~q\ $ (((\U_caminhoDados|Reg1|FFD3|Q~q\) # (!\U_caminhoDados|Reg0|FFD3|Q~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011010001001011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg1|FFD3|Q~q\,
	datab => \U_caminhoDados|Reg0|FFD3|Q~q\,
	datac => \U_caminhoDados|Reg0|FFD2|Q~q\,
	datad => \U_caminhoDados|Reg1|FFD2|Q~q\,
	combout => \U_caminhoDados|Sub0|adder0|fulladder1|R~combout\);

-- Location: LCCOMB_X64_Y53_N28
\U_caminhoDados|Mux0|R[1]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Mux0|R[1]~1_combout\ = (\U_ROM|U_FF1|Q~q\ & (!\Dividendo[1]~input_o\)) # (!\U_ROM|U_FF1|Q~q\ & ((\U_ROM|U_FF0|Q~q\ & ((\U_caminhoDados|Sub0|adder0|fulladder1|R~combout\))) # (!\U_ROM|U_FF0|Q~q\ & (!\Dividendo[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001100100011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF1|Q~q\,
	datab => \Dividendo[1]~input_o\,
	datac => \U_ROM|U_FF0|Q~q\,
	datad => \U_caminhoDados|Sub0|adder0|fulladder1|R~combout\,
	combout => \U_caminhoDados|Mux0|R[1]~1_combout\);

-- Location: FF_X64_Y53_N29
\U_caminhoDados|Reg0|FFD2|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Mux0|R[1]~1_combout\,
	ena => \U_ROM|U_FF1|ALT_INV_Q~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Reg0|FFD2|Q~q\);

-- Location: LCCOMB_X65_Y53_N20
\U_caminhoDados|Sub0|adder0|fulladder1|CyOut\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\ = (\U_caminhoDados|Reg1|FFD2|Q~q\ & ((\U_caminhoDados|Reg1|FFD3|Q~q\) # ((!\U_caminhoDados|Reg0|FFD2|Q~q\) # (!\U_caminhoDados|Reg0|FFD3|Q~q\)))) # (!\U_caminhoDados|Reg1|FFD2|Q~q\ & 
-- (!\U_caminhoDados|Reg0|FFD2|Q~q\ & ((\U_caminhoDados|Reg1|FFD3|Q~q\) # (!\U_caminhoDados|Reg0|FFD3|Q~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101011101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg1|FFD2|Q~q\,
	datab => \U_caminhoDados|Reg1|FFD3|Q~q\,
	datac => \U_caminhoDados|Reg0|FFD3|Q~q\,
	datad => \U_caminhoDados|Reg0|FFD2|Q~q\,
	combout => \U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\);

-- Location: IOIBUF_X51_Y54_N1
\Dividendo[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Dividendo(2),
	o => \Dividendo[2]~input_o\);

-- Location: LCCOMB_X64_Y53_N10
\U_caminhoDados|Sub0|adder0|fulladder2|R~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Sub0|adder0|fulladder2|R~0_combout\ = \U_caminhoDados|Reg1|FFD1|Q~q\ $ (\U_caminhoDados|Reg0|FFD1|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U_caminhoDados|Reg1|FFD1|Q~q\,
	datad => \U_caminhoDados|Reg0|FFD1|Q~q\,
	combout => \U_caminhoDados|Sub0|adder0|fulladder2|R~0_combout\);

-- Location: LCCOMB_X64_Y53_N18
\U_caminhoDados|Mux0|R[2]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Mux0|R[2]~2_combout\ = (\U_ROM|Mux2~2_combout\ & (\U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\ $ (((\U_caminhoDados|Sub0|adder0|fulladder2|R~0_combout\))))) # (!\U_ROM|Mux2~2_combout\ & (((!\Dividendo[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101001110100011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\,
	datab => \Dividendo[2]~input_o\,
	datac => \U_ROM|Mux2~2_combout\,
	datad => \U_caminhoDados|Sub0|adder0|fulladder2|R~0_combout\,
	combout => \U_caminhoDados|Mux0|R[2]~2_combout\);

-- Location: FF_X64_Y53_N19
\U_caminhoDados|Reg0|FFD1|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Mux0|R[2]~2_combout\,
	ena => \U_ROM|U_FF1|ALT_INV_Q~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Reg0|FFD1|Q~q\);

-- Location: IOIBUF_X58_Y54_N29
\Divis[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Divis(3),
	o => \Divis[3]~input_o\);

-- Location: LCCOMB_X58_Y53_N24
\U_caminhoDados|Reg1|FFD0|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Reg1|FFD0|Q~0_combout\ = !\Divis[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Divis[3]~input_o\,
	combout => \U_caminhoDados|Reg1|FFD0|Q~0_combout\);

-- Location: FF_X65_Y53_N23
\U_caminhoDados|Reg1|FFD0|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \U_caminhoDados|Reg1|FFD0|Q~0_combout\,
	sload => VCC,
	ena => \U_ROM|Mux2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Reg1|FFD0|Q~q\);

-- Location: LCCOMB_X65_Y53_N2
\U_caminhoDados|Mux0|R[3]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Mux0|R[3]~3_combout\ = \U_caminhoDados|Reg1|FFD0|Q~q\ $ (((\U_caminhoDados|Reg1|FFD1|Q~q\ & ((\U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\) # (!\U_caminhoDados|Reg0|FFD1|Q~q\))) # (!\U_caminhoDados|Reg1|FFD1|Q~q\ & 
-- (!\U_caminhoDados|Reg0|FFD1|Q~q\ & \U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100101111010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg1|FFD1|Q~q\,
	datab => \U_caminhoDados|Reg0|FFD1|Q~q\,
	datac => \U_caminhoDados|Reg1|FFD0|Q~q\,
	datad => \U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\,
	combout => \U_caminhoDados|Mux0|R[3]~3_combout\);

-- Location: LCCOMB_X64_Y53_N20
\U_caminhoDados|Mux0|R[3]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Mux0|R[3]~4_combout\ = (\U_ROM|Mux2~2_combout\ & ((\U_caminhoDados|Reg0|FFD0|Q~q\ $ (\U_caminhoDados|Mux0|R[3]~3_combout\)))) # (!\U_ROM|Mux2~2_combout\ & (!\Dividendo[3]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001101110110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|Mux2~2_combout\,
	datab => \Dividendo[3]~input_o\,
	datac => \U_caminhoDados|Reg0|FFD0|Q~q\,
	datad => \U_caminhoDados|Mux0|R[3]~3_combout\,
	combout => \U_caminhoDados|Mux0|R[3]~4_combout\);

-- Location: FF_X64_Y53_N21
\U_caminhoDados|Reg0|FFD0|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Mux0|R[3]~4_combout\,
	ena => \U_ROM|U_FF1|ALT_INV_Q~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Reg0|FFD0|Q~q\);

-- Location: LCCOMB_X65_Y53_N10
\U_ROM|Mux0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_ROM|Mux0~0_combout\ = (\U_caminhoDados|Reg1|FFD1|Q~q\ & ((\U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\) # (!\U_caminhoDados|Reg0|FFD1|Q~q\))) # (!\U_caminhoDados|Reg1|FFD1|Q~q\ & (!\U_caminhoDados|Reg0|FFD1|Q~q\ & 
-- \U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg1|FFD1|Q~q\,
	datab => \U_caminhoDados|Reg0|FFD1|Q~q\,
	datad => \U_caminhoDados|Sub0|adder0|fulladder1|CyOut~combout\,
	combout => \U_ROM|Mux0~0_combout\);

-- Location: LCCOMB_X65_Y53_N24
\U_ROM|Mux0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_ROM|Mux0~1_combout\ = (\U_caminhoDados|Reg0|FFD0|Q~q\ & (\U_caminhoDados|Reg1|FFD0|Q~q\ & \U_ROM|Mux0~0_combout\)) # (!\U_caminhoDados|Reg0|FFD0|Q~q\ & ((\U_caminhoDados|Reg1|FFD0|Q~q\) # (\U_ROM|Mux0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U_caminhoDados|Reg0|FFD0|Q~q\,
	datac => \U_caminhoDados|Reg1|FFD0|Q~q\,
	datad => \U_ROM|Mux0~0_combout\,
	combout => \U_ROM|Mux0~1_combout\);

-- Location: LCCOMB_X65_Y53_N6
\U_ROM|Mux0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_ROM|Mux0~2_combout\ = (\U_ROM|U_FF0|Q~q\ & ((\Start~input_o\) # ((!\U_ROM|U_FF1|Q~q\)))) # (!\U_ROM|U_FF0|Q~q\ & ((\U_ROM|U_FF1|Q~q\ & ((!\U_ROM|Mux0~1_combout\))) # (!\U_ROM|U_FF1|Q~q\ & (\Start~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111010111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Start~input_o\,
	datab => \U_ROM|U_FF0|Q~q\,
	datac => \U_ROM|U_FF1|Q~q\,
	datad => \U_ROM|Mux0~1_combout\,
	combout => \U_ROM|Mux0~2_combout\);

-- Location: FF_X65_Y53_N7
\U_ROM|U_FF1|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_ROM|Mux0~2_combout\,
	clrn => \ALT_INV_RESET~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_ROM|U_FF1|Q~q\);

-- Location: LCCOMB_X66_Y53_N16
\U_ROM|Mux2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_ROM|Mux2~0_combout\ = (\U_ROM|U_FF1|Q~q\ & \U_ROM|U_FF0|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U_ROM|U_FF1|Q~q\,
	datad => \U_ROM|U_FF0|Q~q\,
	combout => \U_ROM|Mux2~0_combout\);

-- Location: LCCOMB_X64_Y53_N24
\U_caminhoDados|Cont0|Mux0|R~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Cont0|Mux0|R~2_combout\ = (\U_caminhoDados|Cont0|reg0|FFD3|Q~q\ & ((\U_ROM|U_FF1|Q~q\) # (!\U_ROM|U_FF0|Q~q\))) # (!\U_caminhoDados|Cont0|reg0|FFD3|Q~q\ & ((!\U_ROM|U_FF1|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U_ROM|U_FF0|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	datad => \U_ROM|U_FF1|Q~q\,
	combout => \U_caminhoDados|Cont0|Mux0|R~2_combout\);

-- Location: FF_X64_Y53_N25
\U_caminhoDados|Cont0|reg0|FFD3|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Cont0|Mux0|R~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\);

-- Location: LCCOMB_X64_Y53_N26
\U_caminhoDados|Cont0|Mux0|R~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Cont0|Mux0|R~3_combout\ = (\U_ROM|U_FF1|Q~q\ & (((\U_caminhoDados|Cont0|reg0|FFD2|Q~q\)))) # (!\U_ROM|U_FF1|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD2|Q~q\ $ (!\U_caminhoDados|Cont0|reg0|FFD3|Q~q\)) # (!\U_ROM|U_FF0|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000110110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF1|Q~q\,
	datab => \U_ROM|U_FF0|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	combout => \U_caminhoDados|Cont0|Mux0|R~3_combout\);

-- Location: FF_X64_Y53_N27
\U_caminhoDados|Cont0|reg0|FFD2|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Cont0|Mux0|R~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\);

-- Location: LCCOMB_X65_Y53_N28
\U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0_combout\ = (!\U_ROM|U_FF1|Q~q\ & (\U_ROM|U_FF0|Q~q\ & (!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\ & !\U_caminhoDados|Cont0|reg0|FFD3|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF1|Q~q\,
	datab => \U_ROM|U_FF0|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	combout => \U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0_combout\);

-- Location: LCCOMB_X65_Y53_N0
\U_caminhoDados|Cont0|Mux0|R~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Cont0|Mux0|R~5_combout\ = (\U_ROM|U_FF1|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ $ (\U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0_combout\)))) # (!\U_ROM|U_FF1|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ $ 
-- (\U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0_combout\)) # (!\U_ROM|U_FF0|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111111110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF1|Q~q\,
	datab => \U_ROM|U_FF0|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datad => \U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0_combout\,
	combout => \U_caminhoDados|Cont0|Mux0|R~5_combout\);

-- Location: FF_X65_Y53_N1
\U_caminhoDados|Cont0|reg0|FFD1|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Cont0|Mux0|R~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\);

-- Location: LCCOMB_X64_Y53_N8
\U_caminhoDados|Cont0|Mux0|R~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|Cont0|Mux0|R~4_combout\ = (\U_ROM|Mux2~1_combout\) # (\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ $ (((!\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & \U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|Mux2~1_combout\,
	datab => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\,
	datad => \U_caminhoDados|Cont0|Adder0|fulladder1|CyOut~0_combout\,
	combout => \U_caminhoDados|Cont0|Mux0|R~4_combout\);

-- Location: FF_X64_Y53_N9
\U_caminhoDados|Cont0|reg0|FFD0|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \U_caminhoDados|Cont0|Mux0|R~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\);

-- Location: LCCOMB_X66_Y53_N10
\U_caminhoDados|DecHex0|HEX0[0]~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[0]~8_combout\ = (\U_caminhoDados|Reg0|FFD3|Q~q\ & (!\U_caminhoDados|Reg0|FFD1|Q~q\ & ((\U_caminhoDados|Reg0|FFD0|Q~q\) # (!\U_caminhoDados|Reg0|FFD2|Q~q\)))) # (!\U_caminhoDados|Reg0|FFD3|Q~q\ & (\U_caminhoDados|Reg0|FFD1|Q~q\ 
-- & (\U_caminhoDados|Reg0|FFD2|Q~q\ $ (!\U_caminhoDados|Reg0|FFD0|Q~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000111000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg0|FFD2|Q~q\,
	datab => \U_caminhoDados|Reg0|FFD3|Q~q\,
	datac => \U_caminhoDados|Reg0|FFD0|Q~q\,
	datad => \U_caminhoDados|Reg0|FFD1|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX0[0]~8_combout\);

-- Location: LCCOMB_X66_Y53_N4
\U_caminhoDados|DecHex0|HEX0[0]~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[0]~14_combout\ = ((\U_caminhoDados|DecHex0|HEX0[0]~8_combout\) # (!\U_ROM|U_FF1|Q~q\)) # (!\U_ROM|U_FF0|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF0|Q~q\,
	datac => \U_ROM|U_FF1|Q~q\,
	datad => \U_caminhoDados|DecHex0|HEX0[0]~8_combout\,
	combout => \U_caminhoDados|DecHex0|HEX0[0]~14_combout\);

-- Location: LCCOMB_X67_Y53_N0
\U_caminhoDados|DecHex0|Ub|dec[2]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\ = (!\U_caminhoDados|Reg0|FFD1|Q~q\ & ((\U_caminhoDados|Reg0|FFD0|Q~q\) # (!\U_caminhoDados|Reg0|FFD2|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U_caminhoDados|Reg0|FFD2|Q~q\,
	datac => \U_caminhoDados|Reg0|FFD0|Q~q\,
	datad => \U_caminhoDados|Reg0|FFD1|Q~q\,
	combout => \U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\);

-- Location: LCCOMB_X67_Y53_N26
\U_caminhoDados|DecHex0|Ub|dec[1]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\ = (\U_caminhoDados|Reg0|FFD2|Q~q\ & (!\U_caminhoDados|Reg0|FFD0|Q~q\ & !\U_caminhoDados|Reg0|FFD1|Q~q\)) # (!\U_caminhoDados|Reg0|FFD2|Q~q\ & (\U_caminhoDados|Reg0|FFD0|Q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U_caminhoDados|Reg0|FFD2|Q~q\,
	datac => \U_caminhoDados|Reg0|FFD0|Q~q\,
	datad => \U_caminhoDados|Reg0|FFD1|Q~q\,
	combout => \U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\);

-- Location: LCCOMB_X67_Y53_N28
\U_caminhoDados|DecHex0|HEX0[1]~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[1]~9_combout\ = ((\U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\ & (\U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\ $ (!\U_caminhoDados|Reg0|FFD3|Q~q\)))) # (!\U_ROM|Mux2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010101011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|Mux2~0_combout\,
	datab => \U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\,
	datac => \U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\,
	datad => \U_caminhoDados|Reg0|FFD3|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX0[1]~9_combout\);

-- Location: LCCOMB_X66_Y53_N28
\U_caminhoDados|DecHex0|HEX0[2]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[2]~10_combout\ = ((\U_caminhoDados|Reg0|FFD3|Q~q\ & (!\U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\ & \U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\))) # (!\U_ROM|Mux2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg0|FFD3|Q~q\,
	datab => \U_ROM|Mux2~0_combout\,
	datac => \U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\,
	datad => \U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\,
	combout => \U_caminhoDados|DecHex0|HEX0[2]~10_combout\);

-- Location: LCCOMB_X66_Y53_N18
\U_caminhoDados|DecHex0|UR0|Ndout[3]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|UR0|Ndout[3]~0_combout\ = (\U_caminhoDados|Reg0|FFD3|Q~q\ & ((\U_caminhoDados|Reg0|FFD1|Q~q\) # (\U_caminhoDados|Reg0|FFD2|Q~q\ $ (\U_caminhoDados|Reg0|FFD0|Q~q\)))) # (!\U_caminhoDados|Reg0|FFD3|Q~q\ & 
-- (\U_caminhoDados|Reg0|FFD1|Q~q\ $ (((\U_caminhoDados|Reg0|FFD2|Q~q\) # (!\U_caminhoDados|Reg0|FFD0|Q~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110001101011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg0|FFD2|Q~q\,
	datab => \U_caminhoDados|Reg0|FFD3|Q~q\,
	datac => \U_caminhoDados|Reg0|FFD0|Q~q\,
	datad => \U_caminhoDados|Reg0|FFD1|Q~q\,
	combout => \U_caminhoDados|DecHex0|UR0|Ndout[3]~0_combout\);

-- Location: LCCOMB_X66_Y53_N30
\U_caminhoDados|DecHex0|HEX0[3]~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[3]~15_combout\ = ((!\U_caminhoDados|DecHex0|UR0|Ndout[3]~0_combout\) # (!\U_ROM|U_FF1|Q~q\)) # (!\U_ROM|U_FF0|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF0|Q~q\,
	datac => \U_ROM|U_FF1|Q~q\,
	datad => \U_caminhoDados|DecHex0|UR0|Ndout[3]~0_combout\,
	combout => \U_caminhoDados|DecHex0|HEX0[3]~15_combout\);

-- Location: LCCOMB_X67_Y53_N10
\U_caminhoDados|DecHex0|HEX0[4]~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[4]~11_combout\ = (((\U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\ & !\U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\)) # (!\U_caminhoDados|Reg0|FFD3|Q~q\)) # (!\U_ROM|Mux2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101110111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|Mux2~0_combout\,
	datab => \U_caminhoDados|DecHex0|Ub|dec[2]~0_combout\,
	datac => \U_caminhoDados|DecHex0|Ub|dec[1]~1_combout\,
	datad => \U_caminhoDados|Reg0|FFD3|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX0[4]~11_combout\);

-- Location: LCCOMB_X66_Y53_N24
\U_caminhoDados|DecHex0|HEX0[5]~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[5]~12_combout\ = (\U_caminhoDados|Reg0|FFD2|Q~q\ & ((\U_caminhoDados|Reg0|FFD0|Q~q\ & (!\U_caminhoDados|Reg0|FFD3|Q~q\ & \U_caminhoDados|Reg0|FFD1|Q~q\)) # (!\U_caminhoDados|Reg0|FFD0|Q~q\ & 
-- ((!\U_caminhoDados|Reg0|FFD1|Q~q\))))) # (!\U_caminhoDados|Reg0|FFD2|Q~q\ & ((\U_caminhoDados|Reg0|FFD3|Q~q\ & (\U_caminhoDados|Reg0|FFD0|Q~q\ & \U_caminhoDados|Reg0|FFD1|Q~q\)) # (!\U_caminhoDados|Reg0|FFD3|Q~q\ & ((\U_caminhoDados|Reg0|FFD0|Q~q\) # 
-- (\U_caminhoDados|Reg0|FFD1|Q~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000100011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg0|FFD2|Q~q\,
	datab => \U_caminhoDados|Reg0|FFD3|Q~q\,
	datac => \U_caminhoDados|Reg0|FFD0|Q~q\,
	datad => \U_caminhoDados|Reg0|FFD1|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX0[5]~12_combout\);

-- Location: LCCOMB_X66_Y53_N0
\U_caminhoDados|DecHex0|HEX0[5]~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[5]~16_combout\ = ((\U_caminhoDados|DecHex0|HEX0[5]~12_combout\) # (!\U_ROM|U_FF1|Q~q\)) # (!\U_ROM|U_FF0|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF0|Q~q\,
	datac => \U_ROM|U_FF1|Q~q\,
	datad => \U_caminhoDados|DecHex0|HEX0[5]~12_combout\,
	combout => \U_caminhoDados|DecHex0|HEX0[5]~16_combout\);

-- Location: LCCOMB_X64_Y53_N22
\U_caminhoDados|DecHex0|HEX0[6]~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[6]~13_combout\ = (\U_caminhoDados|Reg0|FFD1|Q~q\ & (\U_caminhoDados|Reg0|FFD2|Q~q\ $ (((!\U_caminhoDados|Reg0|FFD0|Q~q\))))) # (!\U_caminhoDados|Reg0|FFD1|Q~q\ & (!\U_caminhoDados|Reg0|FFD2|Q~q\ & 
-- (!\U_caminhoDados|Reg0|FFD3|Q~q\ & \U_caminhoDados|Reg0|FFD0|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg0|FFD1|Q~q\,
	datab => \U_caminhoDados|Reg0|FFD2|Q~q\,
	datac => \U_caminhoDados|Reg0|FFD3|Q~q\,
	datad => \U_caminhoDados|Reg0|FFD0|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX0[6]~13_combout\);

-- Location: LCCOMB_X66_Y53_N22
\U_caminhoDados|DecHex0|HEX0[6]~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX0[6]~17_combout\ = ((\U_caminhoDados|DecHex0|HEX0[6]~13_combout\) # (!\U_ROM|U_FF1|Q~q\)) # (!\U_ROM|U_FF0|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF0|Q~q\,
	datac => \U_ROM|U_FF1|Q~q\,
	datad => \U_caminhoDados|DecHex0|HEX0[6]~13_combout\,
	combout => \U_caminhoDados|DecHex0|HEX0[6]~17_combout\);

-- Location: LCCOMB_X64_Y53_N16
\U_caminhoDados|DecHex0|HEX1[0]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX1[0]~0_combout\ = ((!\U_caminhoDados|Reg0|FFD0|Q~q\ & ((!\U_caminhoDados|Reg0|FFD2|Q~q\) # (!\U_caminhoDados|Reg0|FFD1|Q~q\)))) # (!\U_ROM|Mux2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Reg0|FFD1|Q~q\,
	datab => \U_caminhoDados|Reg0|FFD0|Q~q\,
	datac => \U_ROM|Mux2~0_combout\,
	datad => \U_caminhoDados|Reg0|FFD2|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX1[0]~0_combout\);

-- Location: LCCOMB_X65_Y53_N30
\U_caminhoDados|DecHex0|HEX4[0]~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[0]~8_combout\ = (\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & (!\U_caminhoDados|Cont0|reg0|FFD3|Q~q\ & (\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ $ (!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\)))) # (!\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & 
-- (\U_caminhoDados|Cont0|reg0|FFD3|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD0|Q~q\) # (!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001110000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\,
	datab => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX4[0]~8_combout\);

-- Location: LCCOMB_X66_Y53_N20
\U_caminhoDados|DecHex0|HEX4[0]~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[0]~14_combout\ = ((\U_caminhoDados|DecHex0|HEX4[0]~8_combout\) # (!\U_ROM|U_FF1|Q~q\)) # (!\U_ROM|U_FF0|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF0|Q~q\,
	datac => \U_ROM|U_FF1|Q~q\,
	datad => \U_caminhoDados|DecHex0|HEX4[0]~8_combout\,
	combout => \U_caminhoDados|DecHex0|HEX4[0]~14_combout\);

-- Location: LCCOMB_X65_Y53_N22
\U_caminhoDados|DecHex0|Ua|dec[1]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\ = (\U_caminhoDados|Cont0|reg0|FFD2|Q~q\ & (!\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & !\U_caminhoDados|Cont0|reg0|FFD0|Q~q\)) # (!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD0|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	datab => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\,
	combout => \U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\);

-- Location: LCCOMB_X65_Y53_N4
\U_caminhoDados|DecHex0|Ua|dec[2]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\ = (!\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD0|Q~q\) # (!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	datab => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\,
	combout => \U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\);

-- Location: LCCOMB_X66_Y53_N6
\U_caminhoDados|DecHex0|HEX4[1]~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[1]~9_combout\ = ((\U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\ & (\U_caminhoDados|Cont0|reg0|FFD3|Q~q\ $ (!\U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\)))) # (!\U_ROM|Mux2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	datab => \U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\,
	datac => \U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\,
	datad => \U_ROM|Mux2~0_combout\,
	combout => \U_caminhoDados|DecHex0|HEX4[1]~9_combout\);

-- Location: LCCOMB_X66_Y53_N12
\U_caminhoDados|DecHex0|HEX4[2]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[2]~10_combout\ = ((\U_caminhoDados|Cont0|reg0|FFD3|Q~q\ & (\U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\ & !\U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\))) # (!\U_ROM|Mux2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	datab => \U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\,
	datac => \U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\,
	datad => \U_ROM|Mux2~0_combout\,
	combout => \U_caminhoDados|DecHex0|HEX4[2]~10_combout\);

-- Location: LCCOMB_X65_Y53_N16
\U_caminhoDados|DecHex0|UQ0|Ndout[3]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|UQ0|Ndout[3]~0_combout\ = (\U_caminhoDados|Cont0|reg0|FFD3|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD1|Q~q\) # (\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ $ (\U_caminhoDados|Cont0|reg0|FFD2|Q~q\)))) # (!\U_caminhoDados|Cont0|reg0|FFD3|Q~q\ 
-- & (\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ $ (((\U_caminhoDados|Cont0|reg0|FFD2|Q~q\) # (!\U_caminhoDados|Cont0|reg0|FFD0|Q~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111000111001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\,
	datab => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	combout => \U_caminhoDados|DecHex0|UQ0|Ndout[3]~0_combout\);

-- Location: LCCOMB_X66_Y53_N26
\U_caminhoDados|DecHex0|HEX4[3]~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[3]~15_combout\ = ((!\U_caminhoDados|DecHex0|UQ0|Ndout[3]~0_combout\) # (!\U_ROM|U_FF1|Q~q\)) # (!\U_ROM|U_FF0|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF0|Q~q\,
	datab => \U_ROM|U_FF1|Q~q\,
	datac => \U_caminhoDados|DecHex0|UQ0|Ndout[3]~0_combout\,
	combout => \U_caminhoDados|DecHex0|HEX4[3]~15_combout\);

-- Location: LCCOMB_X66_Y53_N14
\U_caminhoDados|DecHex0|HEX4[4]~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[4]~11_combout\ = (((!\U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\ & \U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\)) # (!\U_ROM|Mux2~0_combout\)) # (!\U_caminhoDados|Cont0|reg0|FFD3|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	datab => \U_caminhoDados|DecHex0|Ua|dec[1]~1_combout\,
	datac => \U_caminhoDados|DecHex0|Ua|dec[2]~0_combout\,
	datad => \U_ROM|Mux2~0_combout\,
	combout => \U_caminhoDados|DecHex0|HEX4[4]~11_combout\);

-- Location: LCCOMB_X64_Y53_N14
\U_caminhoDados|DecHex0|HEX4[5]~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[5]~12_combout\ = (\U_caminhoDados|Cont0|reg0|FFD2|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ & (\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & !\U_caminhoDados|Cont0|reg0|FFD3|Q~q\)) # (!\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ & 
-- (!\U_caminhoDados|Cont0|reg0|FFD1|Q~q\)))) # (!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ & ((\U_caminhoDados|Cont0|reg0|FFD1|Q~q\) # (!\U_caminhoDados|Cont0|reg0|FFD3|Q~q\))) # (!\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ & 
-- (\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & !\U_caminhoDados|Cont0|reg0|FFD3|Q~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100001011010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	datab => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX4[5]~12_combout\);

-- Location: LCCOMB_X65_Y53_N26
\U_caminhoDados|DecHex0|HEX4[5]~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[5]~16_combout\ = ((\U_caminhoDados|DecHex0|HEX4[5]~12_combout\) # (!\U_ROM|U_FF0|Q~q\)) # (!\U_ROM|U_FF1|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF1|Q~q\,
	datab => \U_ROM|U_FF0|Q~q\,
	datad => \U_caminhoDados|DecHex0|HEX4[5]~12_combout\,
	combout => \U_caminhoDados|DecHex0|HEX4[5]~16_combout\);

-- Location: LCCOMB_X65_Y53_N14
\U_caminhoDados|DecHex0|HEX4[6]~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[6]~13_combout\ = (\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & (\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ $ ((!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\)))) # (!\U_caminhoDados|Cont0|reg0|FFD1|Q~q\ & (\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ & 
-- (!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\ & !\U_caminhoDados|Cont0|reg0|FFD3|Q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010010000110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\,
	datab => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD3|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX4[6]~13_combout\);

-- Location: LCCOMB_X66_Y53_N8
\U_caminhoDados|DecHex0|HEX4[6]~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX4[6]~17_combout\ = ((\U_caminhoDados|DecHex0|HEX4[6]~13_combout\) # (!\U_ROM|U_FF1|Q~q\)) # (!\U_ROM|U_FF0|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|U_FF0|Q~q\,
	datac => \U_ROM|U_FF1|Q~q\,
	datad => \U_caminhoDados|DecHex0|HEX4[6]~13_combout\,
	combout => \U_caminhoDados|DecHex0|HEX4[6]~17_combout\);

-- Location: LCCOMB_X64_Y53_N12
\U_caminhoDados|DecHex0|HEX5[0]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_caminhoDados|DecHex0|HEX5[0]~0_combout\ = ((!\U_caminhoDados|Cont0|reg0|FFD0|Q~q\ & ((!\U_caminhoDados|Cont0|reg0|FFD2|Q~q\) # (!\U_caminhoDados|Cont0|reg0|FFD1|Q~q\)))) # (!\U_ROM|Mux2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101011101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_ROM|Mux2~0_combout\,
	datab => \U_caminhoDados|Cont0|reg0|FFD1|Q~q\,
	datac => \U_caminhoDados|Cont0|reg0|FFD0|Q~q\,
	datad => \U_caminhoDados|Cont0|reg0|FFD2|Q~q\,
	combout => \U_caminhoDados|DecHex0|HEX5[0]~0_combout\);

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

ww_Rdy <= \Rdy~output_o\;

ww_Quociente(0) <= \Quociente[0]~output_o\;

ww_Quociente(1) <= \Quociente[1]~output_o\;

ww_Quociente(2) <= \Quociente[2]~output_o\;

ww_Quociente(3) <= \Quociente[3]~output_o\;

ww_Resto(0) <= \Resto[0]~output_o\;

ww_Resto(1) <= \Resto[1]~output_o\;

ww_Resto(2) <= \Resto[2]~output_o\;

ww_Resto(3) <= \Resto[3]~output_o\;

ww_HEX0(0) <= \HEX0[0]~output_o\;

ww_HEX0(1) <= \HEX0[1]~output_o\;

ww_HEX0(2) <= \HEX0[2]~output_o\;

ww_HEX0(3) <= \HEX0[3]~output_o\;

ww_HEX0(4) <= \HEX0[4]~output_o\;

ww_HEX0(5) <= \HEX0[5]~output_o\;

ww_HEX0(6) <= \HEX0[6]~output_o\;

ww_HEX0(7) <= \HEX0[7]~output_o\;

ww_HEX1(0) <= \HEX1[0]~output_o\;

ww_HEX1(1) <= \HEX1[1]~output_o\;

ww_HEX1(2) <= \HEX1[2]~output_o\;

ww_HEX1(3) <= \HEX1[3]~output_o\;

ww_HEX1(4) <= \HEX1[4]~output_o\;

ww_HEX1(5) <= \HEX1[5]~output_o\;

ww_HEX1(6) <= \HEX1[6]~output_o\;

ww_HEX1(7) <= \HEX1[7]~output_o\;

ww_HEX4(0) <= \HEX4[0]~output_o\;

ww_HEX4(1) <= \HEX4[1]~output_o\;

ww_HEX4(2) <= \HEX4[2]~output_o\;

ww_HEX4(3) <= \HEX4[3]~output_o\;

ww_HEX4(4) <= \HEX4[4]~output_o\;

ww_HEX4(5) <= \HEX4[5]~output_o\;

ww_HEX4(6) <= \HEX4[6]~output_o\;

ww_HEX4(7) <= \HEX4[7]~output_o\;

ww_HEX5(0) <= \HEX5[0]~output_o\;

ww_HEX5(1) <= \HEX5[1]~output_o\;

ww_HEX5(2) <= \HEX5[2]~output_o\;

ww_HEX5(3) <= \HEX5[3]~output_o\;

ww_HEX5(4) <= \HEX5[4]~output_o\;

ww_HEX5(5) <= \HEX5[5]~output_o\;

ww_HEX5(6) <= \HEX5[6]~output_o\;

ww_HEX5(7) <= \HEX5[7]~output_o\;
END structure;


