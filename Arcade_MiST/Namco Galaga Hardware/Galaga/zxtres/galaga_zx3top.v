//set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVTTL} [get_ports mist_miso]
//set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVTTL} [get_ports mist_mosi]
//set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVTTL} [get_ports mist_sck]
//set_property -dict {PACKAGE_PIN W9 IOSTANDARD LVTTL} [get_ports mist_confdata0]

module galaga_zx3top(
  // External clock
  input wire clk50mhz,

  // VGA
  output wire [7:0] vga_r,
  output wire [7:0] vga_g,
  output wire [7:0] vga_b,
  output wire vga_hs,
  output wire vga_vs,

  // MiST/Middleboard
  inout wire mist_miso,  //SPI_DO,
  input wire mist_mosi,  //SPI_DI,
  input wire mist_sck,   //SPI_SCK,
  input wire mist_confdata0, //CONF_DATA0, // SPI_SS for user_io
  input wire mist_ss2,   //SPI_SS2,        // data_io
  input wire mist_ss3,   //SPI_SS3,        // OSD
  input wire mist_ss4,   //SPI_SS4,        // Direct upload
  
  // SDRAM
  output wire sdram_clk,
  output wire sdram_cke,
  output wire sdram_dqmh_n,
  output wire sdram_dqml_n,
  output wire sdram_cas_n,
  output wire sdram_ras_n,
  output wire sdram_we_n,
  output wire sdram_cs_n,
  output wire[1:0] sdram_ba,
  output wire[12:0] sdram_addr,
  inout wire[15:0] sdram_dq,

  // Delta sigma audio
  output wire     audio_out_left,
  output wire     audio_out_right,
  //I2S audio
  output wire     i2s_bclk,
  output wire     i2s_lrclk,
  output wire     i2s_dout,

  output wire testled,

  // SD card. Only used in direct upload mode
  input  wire     sd_clk,     //sd_clk is being driven by middleboard
  input  wire     sd_miso,
	
  // Forward JAMMA DB9 data (aka pin refection)
  output wire     joy_clk,
  output wire     joy_load_n,
  input  wire     joy_data,
  output wire     joy_select,
  input  wire     xjoy_clk,
  input  wire     xjoy_load_n,
  output wire     xjoy_data
);

// SD card  (driven by middleboard)
wire   spi_do_int;
//assign spi_do_int = mist_ss4 ? 1'bZ : sd_miso;
//assign mist_miso = spi_do_int;
//assign mist_miso = ( mist_confdata0 | mist_ss4 ) ? 1'bZ :
//                   ( spi_do_int == 1'bZ ) ? sd_miso : spi_do_int;
assign mist_miso = ( mist_confdata0 ) ? 1'bZ : spi_do_int;

// JAMMA interface
assign joy_clk    = xjoy_clk;
assign joy_load_n   = xjoy_load_n;
assign xjoy_data  = joy_data;
assign joy_select = 1'b1;

galaga_mist (
   .CLOCK_27(),
   .CLOCK_50(clk50mhz),
   .SPI_DO(spi_do_int),
   .SPI_DI(mist_mosi),
   .CONF_DATA0(mist_confdata0),
   .SPI_SS2(mist_ss2),
   .SPI_SS3(mist_ss3),
`ifndef NO_DIRECT_UPLOAD
	.SPI_SS4(mist_ss4),
   .SPI_SCK(mist_ss4 ? mist_sck : sd_clk),
`else
   .SPI_SCK(mist_sck),
`endif
   .VGA_HS(vga_hs),
   .VGA_VS(vga_vs),
`ifdef VGA_8BIT
   .VGA_R(vga_r),
   .VGA_G(vga_g),
   .VGA_B(vga_b),
`else
   .VGA_R(vga_r[7:2]),
   .VGA_G(vga_g[7:2]),
   .VGA_B(vga_b[7:2]),
`endif
   .LED(testled),
   .SDRAM_A(sdram_addr),
   .SDRAM_DQ(sdram_dq), 
   .SDRAM_DQML(sdram_dqml_n), 
   .SDRAM_DQMH(sdram_dqmh_n), 
   .SDRAM_nWE(sdram_we_n), 
   .SDRAM_nCAS(sdram_cas_n), 
   .SDRAM_nRAS(sdram_ras_n), 
   .SDRAM_nCS(sdram_cs_n),
   .SDRAM_BA(sdram_ba), 
   .SDRAM_CLK(sdram_clk), 
   .SDRAM_CKE(sdram_cke), 
   .AUDIO_L(audio_out_left),
   .AUDIO_R(audio_out_right),
   .I2S_BCK(i2s_bclk),
   .I2S_LRCK(i2s_lrclk),
   .I2S_DATA(i2s_dout),
   .UART_RX( ),
   .UART_TX( )

);

`ifndef VGA_8BIT
   assign vga_r[1:0] = vga_r[7:6];
   assign vga_g[1:0] = vga_g[7:6];
   assign vga_b[1:0] = vga_b[7:6];
`endif
endmodule


