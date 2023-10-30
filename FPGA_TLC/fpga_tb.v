`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:36:16 08/21/2023
// Design Name:   fsm
// Module Name:   C:/Users/LENOVO/fpga_1/fpga_tb.v
// Project Name:  fpga_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fpga_tb;

	// Inputs
	reg TS;
	reg TL;
	reg C;
	reg reset;
	reg clk;

	// Outputs
	wire MR;
	wire MY;
	wire MG;
	wire SR;
	wire SY;
	wire SG;

	// Instantiate the Unit Under Test (UUT)
	fsm uut (
		.MR(MR), 
		.MY(MY), 
		.MG(MG), 
		.SR(SR), 
		.SY(SY), 
		.SG(SG), 
		.TS(TS), 
		.TL(TL), 
		.C(C), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		TS = 0;
		TL = 0;
		C = 0;
		reset = 1;
		clk = 0;
		#100; TS=0; TL=1; C=1; reset =0;
		#100; TS=0; TL=0; C=0; reset=1;
		#100; TS=1;TL=1;C=0; reset=0;
		#100;
		end
		always
		begin
		#100
		clk=~clk;
		end
      
endmodule