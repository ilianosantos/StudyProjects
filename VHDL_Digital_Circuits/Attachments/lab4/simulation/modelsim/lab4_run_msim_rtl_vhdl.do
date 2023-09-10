transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/fulladder.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/adder.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/sumsub.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/flags.vhd}
vcom -93 -work work {C:/Users/mpmig/Desktop/ISEL/LSD/lab4/au.vhd}

