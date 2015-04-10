# Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, the Altera Quartus II License Agreement,
# the Altera MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Altera and sold by Altera or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.

# Quartus II: Generate Tcl File for Project
# File: nes.tcl
# Generated on: Sat Dec 13 22:50:16 2014

# Load Quartus II Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "nes"]} {
		puts "Project nes is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists nes]} {
		project_open -revision nes nes
	} else {
		project_new -revision nes nes
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone IV E"
	set_global_assignment -name DEVICE EP4CE22E22C7
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 14.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "21:25:36  NOVEMBER 28, 2014"
	set_global_assignment -name LAST_QUARTUS_VERSION 14.0
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name DEVICE_FILTER_PACKAGE TQFP
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 144
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 7
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
	set_global_assignment -name EDA_SIMULATION_TOOL "<None>"
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT NONE -section_id eda_simulation
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name ENABLE_CONFIGURATION_PINS OFF
	set_global_assignment -name ENABLE_BOOT_SEL_PIN OFF
	set_global_assignment -name USE_CONFIGURATION_DEVICE OFF
	set_global_assignment -name CRC_ERROR_OPEN_DRAIN OFF
	set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
	set_global_assignment -name RESERVE_DATA0_AFTER_CONFIGURATION "USE AS REGULAR IO"
	set_global_assignment -name RESERVE_DATA1_AFTER_CONFIGURATION "USE AS REGULAR IO"
	set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"
	set_global_assignment -name RESERVE_DCLK_AFTER_CONFIGURATION "USE AS REGULAR IO"
	set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -rise
	set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -fall
	set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -rise
	set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -fall
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "2.5 V"
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name ENABLE_SIGNALTAP OFF
	set_global_assignment -name USE_SIGNALTAP_FILE output_files/stp1.stp
	set_global_assignment -name SYNCHRONIZER_IDENTIFICATION AUTO
	set_global_assignment -name TIMEQUEST_DO_CCPP_REMOVAL ON
	set_global_assignment -name TIMEQUEST_DO_REPORT_TIMING ON
	set_global_assignment -name SYNTH_TIMING_DRIVEN_SYNTHESIS ON
	set_global_assignment -name OPTIMIZE_POWER_DURING_SYNTHESIS "NORMAL COMPILATION"
	set_global_assignment -name VHDL_FILE rtl/uart/uart.vhd
	set_global_assignment -name SDC_FILE output_files/nes.sdc
	set_global_assignment -name VHDL_FILE rtl/cpu/nz80cpu.vhd
	set_global_assignment -name VHDL_FILE rtl/hdmi/serializer.vhd
	set_global_assignment -name QIP_FILE rtl/hdmi/serializer.qip
	set_global_assignment -name VHDL_FILE rtl/hdmi/hdmi.vhd
	set_global_assignment -name VHDL_FILE rtl/hdmi/encoder.vhd
	set_global_assignment -name VHDL_FILE rtl/keyboard/receiver.vhd
	set_global_assignment -name VHDL_FILE rtl/keyboard/keyboard.vhd
	set_global_assignment -name VHDL_FILE rtl/spi/spi.vhd
	set_global_assignment -name VERILOG_FILE rtl/user_io.v
	set_global_assignment -name VERILOG_FILE rtl/sigma_delta_dac.v
	set_global_assignment -name VERILOG_FILE rtl/sdram.v
	set_global_assignment -name VERILOG_FILE rtl/osd.v
	set_global_assignment -name VERILOG_FILE rtl/NES_u16.v
	set_global_assignment -name VHDL_FILE rtl/ldr.vhd
	set_global_assignment -name VERILOG_FILE rtl/data_io.v
	set_global_assignment -name VERILOG_FILE rtl/clk.v
	set_global_assignment -name QIP_FILE rtl/clk.qip
	set_global_assignment -name VERILOG_FILE src/vga.v
	set_global_assignment -name VERILOG_FILE src/ppu.v
	set_global_assignment -name VERILOG_FILE src/nes.v
	set_global_assignment -name VERILOG_FILE src/mmu.v
	set_global_assignment -name VERILOG_FILE src/MicroCode.v
	set_global_assignment -name VERILOG_FILE src/hq2x.v
	set_global_assignment -name VERILOG_FILE src/dsp.v
	set_global_assignment -name VERILOG_FILE src/cpu.v
	set_global_assignment -name VERILOG_FILE src/compat.v
	set_global_assignment -name VERILOG_FILE src/apu.v
	set_global_assignment -name QIP_FILE rtl/memory/ram.qip
	set_global_assignment -name CDF_FILE output_files/Chain1.cdf
	set_global_assignment -name CDF_FILE Chain1.cdf
	set_location_assignment PIN_71 -to AUDIO_L
	set_location_assignment PIN_72 -to AUDIO_R
	set_location_assignment PIN_25 -to CLOCK_50
	set_location_assignment PIN_113 -to HDMI_CLK
	set_location_assignment PIN_133 -to HDMI_D0
	set_location_assignment PIN_144 -to HDMI_D1
	set_location_assignment PIN_143 -to HDMI_D1N
	set_location_assignment PIN_10 -to HDMI_D2
	set_location_assignment PIN_68 -to SDRAM_A[12]
	set_location_assignment PIN_69 -to SDRAM_A[11]
	set_location_assignment PIN_99 -to SDRAM_A[10]
	set_location_assignment PIN_67 -to SDRAM_A[9]
	set_location_assignment PIN_85 -to SDRAM_A[8]
	set_location_assignment PIN_83 -to SDRAM_A[7]
	set_location_assignment PIN_80 -to SDRAM_A[6]
	set_location_assignment PIN_77 -to SDRAM_A[5]
	set_location_assignment PIN_76 -to SDRAM_A[4]
	set_location_assignment PIN_105 -to SDRAM_A[3]
	set_location_assignment PIN_87 -to SDRAM_A[2]
	set_location_assignment PIN_86 -to SDRAM_A[1]
	set_location_assignment PIN_98 -to SDRAM_A[0]
	set_location_assignment PIN_100 -to SDRAM_BA[1]
	set_location_assignment PIN_101 -to SDRAM_BA[0]
	set_location_assignment PIN_43 -to SDRAM_CLK
	set_location_assignment PIN_58 -to SDRAM_DQ[15]
	set_location_assignment PIN_42 -to SDRAM_DQ[14]
	set_location_assignment PIN_59 -to SDRAM_DQ[13]
	set_location_assignment PIN_44 -to SDRAM_DQ[12]
	set_location_assignment PIN_46 -to SDRAM_DQ[11]
	set_location_assignment PIN_60 -to SDRAM_DQ[10]
	set_location_assignment PIN_64 -to SDRAM_DQ[9]
	set_location_assignment PIN_65 -to SDRAM_DQ[8]
	set_location_assignment PIN_120 -to SDRAM_DQ[7]
	set_location_assignment PIN_121 -to SDRAM_DQ[6]
	set_location_assignment PIN_125 -to SDRAM_DQ[5]
	set_location_assignment PIN_135 -to SDRAM_DQ[4]
	set_location_assignment PIN_136 -to SDRAM_DQ[3]
	set_location_assignment PIN_137 -to SDRAM_DQ[2]
	set_location_assignment PIN_141 -to SDRAM_DQ[1]
	set_location_assignment PIN_142 -to SDRAM_DQ[0]
	set_location_assignment PIN_66 -to SDRAM_DQMH
	set_location_assignment PIN_119 -to SDRAM_DQML
	set_location_assignment PIN_106 -to SDRAM_nCAS
	set_location_assignment PIN_103 -to SDRAM_nRAS
	set_location_assignment PIN_104 -to SDRAM_nWE
	set_location_assignment PIN_53 -to USB_TX
	set_instance_assignment -name IO_STANDARD LVDS_E_3R -to HDMI_D0
	set_location_assignment PIN_132 -to "HDMI_D0(n)"
	set_instance_assignment -name IO_STANDARD LVDS_E_3R -to HDMI_D2
	set_location_assignment PIN_11 -to "HDMI_D2(n)"
	set_instance_assignment -name IO_STANDARD LVDS_E_3R -to HDMI_CLK
	set_location_assignment PIN_112 -to "HDMI_CLK(n)"
	set_location_assignment PIN_110 -to SD_CLK
	set_location_assignment PIN_114 -to SD_CS_N
	set_location_assignment PIN_126 -to SD_MISO
	set_location_assignment PIN_111 -to SD_MOSI
	set_location_assignment PIN_32 -to KEY_RESET
	set_location_assignment PIN_8 -to SPI_CSn
	set_location_assignment PIN_6 -to SPI_DI
	set_location_assignment PIN_13 -to SPI_DO
	set_location_assignment PIN_12 -to SPI_SCK
	set_instance_assignment -name IO_MAXIMUM_TOGGLE_RATE "0 MHz" -to SPI_SCK
	set_location_assignment PIN_39 -to UART_TXD
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}