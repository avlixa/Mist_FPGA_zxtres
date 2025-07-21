module pll (
  input wire areset,
  input wire inclk0,
	output wire c0, // 72 mhz
	output wire c1, // 18 mhz
	output wire c2,  // 36 mhz
	//output wire c3, // 6 mhz
	output wire locked);

	relojes relojes_inst(
		.CLK_IN1(inclk0),
		.CLK_OUT1(c0),
		.CLK_OUT2(c1),
		.CLK_OUT3(c2),
		//.CLK_OUT4(c3),
		.reset(areset),
		.locked(locked)
	);

endmodule

// file: clk_wiz_0.v
//
// (c) Copyright 2008 - 2013 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
`timescale 1ps/1ps

module relojes

 (// Clock in ports
  // Clock out ports
  input wire        CLK_IN1,
  // Clock out ports
  output wire       CLK_OUT1,
  output wire       CLK_OUT2,
  output wire       CLK_OUT3,
  //output wire       CLK_OUT4,
  // Status and control signals
  input wire        reset,
  output wire       locked
 );
  // Input buffering
  //------------------------------------
wire clk_in1_clk_wiz_0;
wire clk_in2_clk_wiz_0;
  IBUF clkin1_ibufg
   (.O (clk_in1_clk_wiz_0),
    .I (CLK_IN1));

  // Clocking PRIMITIVE
  //------------------------------------

  // Instantiation of the MMCM PRIMITIVE
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused

  wire        clk_out1_clk_wiz_0;
  wire        clk_out2_clk_wiz_0;
  wire        clk_out3_clk_wiz_0;
  reg         clk_out4_clk_wiz_0;
  wire        clk_out5_clk_wiz_0;
  wire        clk_out6_clk_wiz_0;
  wire        clk_out7_clk_wiz_0;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_clk_wiz_0;
  wire        clkfboutb_unused;
  wire clkout0b_unused;
  wire clkout1b_unused;
  wire clkout2b_unused;
  wire clkout3_unused;
  wire clkout3b_unused;
  wire clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;

  MMCME2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"), // Jitter programming (OPTIMIZED, HIGH, LOW)
    .CLKOUT4_CASCADE      ("FALSE"),     // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
    .COMPENSATION         ("ZHOLD"),     // ZHOLD, BUF_IN, EXTERNAL, INTERNAL
    .STARTUP_WAIT         ("FALSE"),     // Delays DONE until MMCM is locked (FALSE, TRUE)
    .DIVCLK_DIVIDE        (2),           // Master division value (1-106)
    .CLKFBOUT_MULT_F      (36.000),      // Multiply value for all CLKOUT (2.000-64.000).
    .CLKFBOUT_PHASE       (0.000),       // Phase offset in degrees of CLKFB (-360.000-360.000).
    .CLKFBOUT_USE_FINE_PS ("FALSE"),     
    .CLKOUT0_DIVIDE_F     (12.500),      // Divide amount for CLKOUT0 (1.000-128.000). multiplo 0.125
    .CLKOUT0_PHASE        (0.000),       // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for CLKOUT outputs (-360.000-360.000).
    .CLKOUT0_DUTY_CYCLE   (0.500),       // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for CLKOUT outputs (0.01-0.99).
    .CLKOUT0_USE_FINE_PS  ("FALSE"),     // USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
    .CLKOUT1_DIVIDE       (50),          // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for CLKOUT (1-128)
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKOUT1_USE_FINE_PS  ("FALSE"),
    .CLKOUT2_DIVIDE       (25),
    .CLKOUT2_PHASE        (0.000),
    .CLKOUT2_DUTY_CYCLE   (0.500),
    .CLKOUT2_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (20.000))      // CLKIN_PERIOD: Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
  mmcm_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_clk_wiz_0),
    .CLKFBOUTB           (),
    .CLKOUT0             (clk_out1_clk_wiz_0),
    .CLKOUT0B            (),
    .CLKOUT1             (clk_out2_clk_wiz_0),
    .CLKOUT1B            (),
    .CLKOUT2             (clk_out3_clk_wiz_0),
    .CLKOUT2B            (),
    .CLKOUT3             (),
    .CLKOUT3B            (),
    .CLKOUT4             (),
    .CLKOUT5             (),
    .CLKOUT6             (),
     // Input clock control
    .CLKFBIN             (clkfbout_clk_wiz_0),
    .CLKIN1              (clk_in1_clk_wiz_0),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (psdone_unused),
    // Other control and status signals
    .LOCKED              (locked_int),
    .CLKINSTOPPED        (clkinstopped_unused),
    .CLKFBSTOPPED        (clkfbstopped_unused),
    .PWRDWN              (1'b0),
    .RST                 (reset));

  assign locked = locked_int;
// Clock Monitor clock assigning
//--------------------------------------
 // Output buffering
  //-----------------------------------

  BUFG bclk_out1 (
    .O(CLK_OUT1),            //72Mhz
    .I(clk_out1_clk_wiz_0)
    );

  BUFG bclkout2 (
   .O(CLK_OUT2),            //18Mhz
   .I(clk_out2_clk_wiz_0)
   );

  BUFG bclkout3 (
   .O(CLK_OUT3),           //36Mhz
   .I(clk_out3_clk_wiz_0)
   );

//  BUFG bclkout4 (
//   .O(CLK_OUT4),           //6Mhz
//   .I(clk_out4_clk_wiz_0)
//   );

//    // Contador para la división del reloj 24Mhz a 6Mhz
//    reg [1:0] contador = 2'b00;
    
//    always @(posedge CLK_OUT2 or posedge reset) begin
//        if (reset) begin
//            // Reset asíncrono
//            contador <= 2'b00;
//            clk_out4_clk_wiz_0 <= 1'b0;
//        end else begin
//            // Incrementar contador
//            contador <= contador + 1;
//            clk_out4_clk_wiz_0 <= contador[1];
//        end
//    end


endmodule
