//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2025
// Design Name: 
// Module Name: clock_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`default_nettype none
`timescale 1ns / 1ps


module clock_tb( );
    parameter CLK_PERIOD = 20;

    reg reset, clk_50m;

    // clocks
    wire clk_0, clk_1, clk_2, clk_3;
    wire locked;

    pll clock_inst (
       .inclk0(clk_50m),
       .areset(reset),
       .c0(clk_0), //48Mhz - 20.833ns
       .c1(clk_1), //24Mhz - 41.667ns
       .c2(clk_2), //18Mhz - 55.520ns
       .c3(clk_3), //6Mhz  - 166.667ns
       .locked(locked)
    );

    always #(CLK_PERIOD / 2) clk_50m = ~clk_50m;

    initial begin
        clk_50m = 1;
        reset = 1;
        #100
        reset = 0;

        #20000
        $finish;
    end


endmodule
