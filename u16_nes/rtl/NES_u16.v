// Copyright (c) 2012-2013 Ludvig Strigeus
// This program is GPL Licensed. See COPYING for the full license.
//
// Modified for ReVerSE-U16 By MVV (build 20160723)

module NES_u16(	
	// clock input
	input		CLOCK_50, // 50 MHz
	input		KEY_RESET,
	// HDMI
	output [7:0]	TMDS,
	// USB HOST	
	input		USB_TX,
	input		USB_SI,
	output		USB_NCS,
	// SPI FLASH
	output		SPI_DI,
	input		SPI_DO,
	output		SPI_SCK,
	output		SPI_CSn,
	// SDRAM
	inout  [15:0]	SDRAM_DQ,	// SDRAM Data bus 16 Bits
	output [12:0]	SDRAM_A,	// SDRAM Address bus 13 Bits
	output		SDRAM_DQML,	// SDRAM Low-byte Data Mask
	output		SDRAM_DQMH,	// SDRAM High-byte Data Mask
	output		SDRAM_nWE,	// SDRAM Write Enable
	output		SDRAM_nCAS,	// SDRAM Column Address Strobe
	output		SDRAM_nRAS,	// SDRAM Row Address Strobe
	output [1:0]	SDRAM_BA,	// SDRAM Bank Address
	output		SDRAM_CLK,	// SDRAM Clock
	// audio
	output		AUDIO_L,
	output		AUDIO_R
);
 
	// VGA
	wire [7:0]	vga_red;
	wire [7:0]	vga_green;
	wire [7:0]	vga_blue;
	wire		vga_hs;
	wire		vga_vs;
	wire [9:0]	vga_hc;
	wire [9:0]	vga_vc;
	wire		vga_blank;
	// OSD
	wire [7:0]	osd_red;
	wire [7:0]	osd_green;
	wire [7:0]	osd_blue;
	wire [7:0]	tmds;
	// virtual buttons and switches
	wire [1:0]	buttons;
	wire [2:0]	switches;
	wire [15:0]	joypad_keys;
	wire [7:0]	key0;
	wire [7:0]	key1;
	wire [7:0]	key2;
	wire [7:0]	key3;
	wire [7:0]	key4;
	wire [7:0]	key5;
	wire [7:0]	key6;
	// spi
	wire		spi1_clk;
	wire		spi1_do;
	wire		spi1_di;
	wire		spi2_cs_n;
	wire		spi3_cs_n;
	wire		spi4_cs_n;

	wire		reset_nes = (init_reset || buttons[0] || !KEY_RESET || downloading);
	wire		run_nes = (nes_ce == 3) && !reset_nes;
	reg		init_reset;

	wire		clock_locked;
	wire		clk_sdram;
	wire		clk_dvi;
	wire		clk_vga;
	wire		clk_nes;
	wire		clk_bus;
	
	// Loader
	wire [7:0] 	loader_input;
	wire		loader_clk;
	reg [7:0]	loader_btn, loader_btn_2;
	wire [21:0]	loader_addr;
	wire [7:0]	loader_write_data;
	wire		loader_reset = !downloading; //loader_conf[0];
	wire		loader_write;
	wire [31:0]	mapper_flags;
	wire		loader_done;
	reg		loader_write_mem;
	reg [7:0]	loader_write_data_mem;
	reg [21:0]	loader_addr_mem;
	reg		loader_write_triggered;
	wire		downloading;

	wire [8:0]	cycle;
	wire [8:0]	scanline;
	wire [15:0]	sample;
	wire [5:0]	color;
	wire		joypad_strobe;
	wire [1:0]	joypad_clock;
	wire [21:0] 	memory_addr;
	wire		memory_read_cpu, memory_read_ppu;
	wire		memory_write;
	wire [7:0]	memory_din_cpu, memory_din_ppu;
	wire [7:0]	memory_dout;
	wire		joypad_bits, joypad_bits2;
	reg [1:0]	last_joypad_clock;
	reg [1:0]	nes_ce;
	wire		audio;


	clk U1(
		.inclk0		(CLOCK_50),	//640x480:      720x480:
		.c0		(clk_sdram),	// 84.000000MHz  84.375000MHz
		.c1		(clk_nes),	// 21.000000MHz  21.093750MHz
		.c2		(clk_bus),	// 42.000000MHz  42.187500MHz
		.c3		(clk_vga),	// 25.200000MHz  27.000000MHz
		.c4		(clk_dvi),	//126.000000MHz 135.000000MHz
		.locked		(clock_locked));

	vga U2(
		.I_CLK		(clk_nes),
		.I_CLK_VGA	(clk_vga),
		.I_COLOR	(color),
		.I_HCNT		(cycle),
		.I_VCNT		(scanline),
		.O_HS		(vga_hs),
		.O_VS		(vga_vs),
		.O_RED		(vga_red),
		.O_GREEN	(vga_green),
		.O_BLUE		(vga_blue),
		.O_HCNT		(vga_hc),
		.O_VCNT		(vga_vc),
		.O_BLANK	(vga_blank));
		
	osd U3(
		.I_RESET	(!KEY_RESET),
		.I_CLK_VGA	(clk_vga),
		.I_CLK_CPU	(clk_nes),
		.I_CLK_BUS	(clk_bus),
		.I_KEY0		(key0),
		.I_KEY1		(key1),
		.I_KEY2		(key2),
		.I_KEY3		(key3),
		.I_KEY4		(key4),
		.I_KEY5		(key5),
		.I_KEY6		(key6),
		.I_SPI_MISO	(SPI_DO),
		.I_SPI1_MISO	(spi1_do),
		.I_RED		(vga_red),
		.I_GREEN	(vga_green),
		.I_BLUE		(vga_blue),
		.I_HCNT		(vga_hc),
		.I_VCNT		(vga_vc),
		.I_DOWNLOAD_OK	(loader_done),
		.O_RED		(osd_red),
		.O_GREEN	(osd_green),
		.O_BLUE		(osd_blue),
		.O_BUTTONS	(buttons),
		.O_SWITCHES	(switches),
		.O_JOYPAD_KEYS	(joypad_keys),
		.O_SPI_CLK	(SPI_SCK),
		.O_SPI_MOSI	(SPI_DI),
		.O_SPI_CS_N	(SPI_CSn),	// SPI FLASH
		.O_SPI1_CS_N	(),		// SD Card
		.O_DOWNLOAD_DO	(loader_input),
		.O_DOWNLOAD_WR	(loader_clk),
		.O_DOWNLOAD_ON	(downloading));

	hdmidirect U4(
		.pixclk		(clk_vga),
		.pixclk72	(clk_dvi),
		.red		(osd_red),
		.green		(osd_green),
		.blue		(osd_blue),
		.hSync		(vga_hs),
		.vSync		(vga_vs),
		.CounterX	(vga_hc),
		.CounterY	(vga_vc),
		.DrawArea	(vga_blank),
		.SampleL	({sample[15:8],4'b0000}),
		.SampleR	({sample[15:8],4'b0000}),
		.tmds		(TMDS));

	hid U5(
		.I_CLK		(CLOCK_50),
		.I_RESET	(!KEY_RESET),
		.I_RX		(USB_TX),
		.I_NEWFRAME	(USB_SI),
		.I_JOYPAD_KEYS	(joypad_keys),
		.I_JOYPAD_CLK1	(joypad_clock[0]),
		.I_JOYPAD_CLK2	(joypad_clock[1]),
		.I_JOYPAD_LATCH	(joypad_strobe),
		.O_JOYPAD_DATA1	(joypad_bits),
		.O_JOYPAD_DATA2	(joypad_bits2),
		.O_KEY0		(key0),
		.O_KEY1		(key1),
		.O_KEY2		(key2),
		.O_KEY3		(key3),
		.O_KEY4		(key4),
		.O_KEY5		(key5),
		.O_KEY6		(key6));

	GameLoader U6(
		.clk		(clk_nes),
		.reset		(loader_reset),
		.indata		(loader_input),
		.indata_clk	(loader_clk),
		.mem_addr	(loader_addr),
		.mem_data	(loader_write_data),
		.mem_write	(loader_write),
		.mapper_flags	(mapper_flags),
		.done		(loader_done));
		
	NES U7(
		.clk		(clk_nes),
		.reset		(reset_nes),
		.ce		(run_nes),
		.mapper_flags	(mapper_flags),
		.sample		(sample),
		.color		(color),
		.joypad_strobe	(joypad_strobe),
		.joypad_clock	(joypad_clock),
		.joypad_data	({joypad_bits2, joypad_bits}),
		.audio_channels	(5'b11111),	// enable all channels
		.memory_addr	(memory_addr),
		.memory_read_cpu(memory_read_cpu),
		.memory_din_cpu	(memory_din_cpu),
		.memory_read_ppu(memory_read_ppu),
		.memory_din_ppu	(memory_din_ppu),
		.memory_write	(memory_write),
		.memory_dout	(memory_dout),
		.cycle		(cycle),
		.scanline	(scanline));

	sdram U8(
		// interface to the MT48LC16M16 chip
		.sd_data	(SDRAM_DQ),
		.sd_addr	(SDRAM_A),
		.sd_dqm		({SDRAM_DQMH, SDRAM_DQML}),
		.sd_cs		(/*SDRAM_nCS*/),
		.sd_ba		(SDRAM_BA),
		.sd_we		(SDRAM_nWE),
		.sd_ras		(SDRAM_nRAS),
		.sd_cas		(SDRAM_nCAS),
		// system interface
		.clk		(clk_sdram),
		.clkref		(nes_ce[1]),
		.init		(!clock_locked),
		// cpu/chipset interface
		.addr		(downloading ? {3'b000, loader_addr_mem} : {3'b000, memory_addr}),
		.we		(memory_write || loader_write_mem),
		.din		(downloading ? loader_write_data_mem : memory_dout),
		.oeA		(memory_read_cpu),
		.doutA		(memory_din_cpu),
		.oeB		(memory_read_ppu),
		.doutB		(memory_din_ppu));
	
	sigma_delta_dac U9(
		.DACout		(audio),
		.DACin		(sample[15:8]),
		.CLK		(clk_sdram),
		.RESET		(reset_nes));

	// hold machine in reset until first download starts
	always @(posedge CLOCK_50) begin
	if(!clock_locked)
		init_reset <= 1'b1;
	else if(downloading)
		init_reset <= 1'b0;
	end

	// NES is clocked at every 4th cycle.
	always @(posedge clk_nes)
		nes_ce <= nes_ce + 2'b1;

	// loader_write -> clock when data available
	always @(posedge clk_nes) begin
		if(loader_write) begin
			loader_write_triggered	<= 1'b1;
			loader_addr_mem		<= loader_addr;
			loader_write_data_mem	<= loader_write_data;
		end
	
		if(nes_ce == 3) begin
			loader_write_mem <= loader_write_triggered;
			if(loader_write_triggered)
				loader_write_triggered <= 1'b0;
		end
	end

	
	// assignments	
	assign USB_NCS = 1'b0;
	assign SDRAM_CLK = clk_sdram;
	assign AUDIO_R = audio;
	assign AUDIO_L = audio;
	
endmodule
