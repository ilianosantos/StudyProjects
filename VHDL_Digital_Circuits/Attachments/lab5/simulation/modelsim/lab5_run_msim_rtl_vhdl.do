transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab4/fulladder.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/tp2/mux2_1.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab4/adder.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab5/int7seg.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab5/FFD.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab5/decoderHex.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab5/clkDIV.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab5/reg4bits.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab5/countup.vhd}
vcom -93 -work work {C:/Users/mpmig/ISEL/LSD/lab5/lab5.vhd}

