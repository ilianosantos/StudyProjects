transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/sumsub.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/fulladder.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/flags.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/au.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/adder.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/xnorr.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/orr.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/mux4_1.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/mux2_1.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/lsr.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/logic_module.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/asr.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/alu_flags.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/alu.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/mux4_4_1.vhd}

