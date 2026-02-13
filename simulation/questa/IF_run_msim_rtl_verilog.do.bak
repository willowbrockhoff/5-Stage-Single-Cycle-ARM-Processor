transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/top.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/SignExtend.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/RegFile.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/Program_Counter.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/MUX_4.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/MUX_32.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/Instruction_Decode.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/datapath.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/DataMemory.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/Controller.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/Condition_Code_Register.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/code_checker.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/ALU.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/Adder.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/Instruction_Fetch.sv}
vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/imem.sv}

vlog -sv -work work +incdir+C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored {C:/Users/rwbrockhoff/Downloads/443/Final/ARM_Single_Cycle-1_restored/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
