vlib ControlUnitLib
vcom -work ControlUnitLib "ControlUnit/ControlUnit.vhdl"

vlib GeneralArithmeticLib
vcom -work GeneralArithmeticLib "GeneralArithmetic/ParallelAdder/Fac.vhdl"
vcom -work GeneralArithmeticLib "GeneralArithmetic/ParallelAdder/ParallelAdder.vhdl"
vcom -work GeneralArithmeticLib "GeneralArithmetic/Count/Count.vhdl"

vlib GeneralRegistersLib
vcom -work GeneralRegistersLib "GeneralRegisters/RegA/RegA.vhdl"
vcom -work GeneralRegistersLib "GeneralRegisters/RegM/RegM.vhdl"
vcom -work GeneralRegistersLib "GeneralRegisters/RegQ/RegQ.vhdl"
vcom -work GeneralRegistersLib "GeneralRegisters/RegQ_neg/RegQ_neg.vhdl"
vcom -work GeneralRegistersLib "GeneralRegisters/Mux2to1/Mux2to1.vhdl"

-- Compile the root module
vlib work
vcom -work work "BoothR4.vhdl"
vcom -work work "BoothR4-tb.vhdl"

-- Run module
vsim work.test
add wave sim:/test/*

