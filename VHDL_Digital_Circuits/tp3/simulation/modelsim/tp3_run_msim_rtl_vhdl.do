transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/mpmig/Desktop/tp3/divisor.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/tp3/ROM.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/lab5/reg4bits.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/lab5/mux2_1.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/lab5/FFD.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/lab5/countup.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/tp3/int7seg.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/tp3/bin2dec_int.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/tp3/decoderHex.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/tp3/CaminhoDados.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/lab4/sumsub.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/lab4/fulladder.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/lab4/adder.vhd}
