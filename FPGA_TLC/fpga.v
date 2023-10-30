`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:11 08/21/2023 
// Design Name: 
// Module Name:    fpga 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fpga(
output MR,output MY,output MG,output SR,output SY,output SG,input reset,input C,input clk);
timer part1(TS,TL,ST,clk);
fsm part2(MR,MY,MG,SR,SY,SG,TS,TL,C,reset,clk);
endmodule


module timer( output TS,output TL,input ST,input clk);
integer value;
assign TS=(value>=4);
assign TL=(value>=14);
always@(posedge ST or posedge clk)
begin
if(ST==1) begin
value=0;
end
else begin
value=value+1;
end
end
endmodule



module fsm(output MR,output MY,output MG,output SR, output SY,output SG,output reg ST,
input TS, input TL, input C,input reset,input clk);
reg [6:1] state;
parameter MainRoadGreen=6'b001100;
parameter MainRoadYellow=6'b010100;
parameter SideRoadGreen=6'b100001;
parameter SideRoadYellow=6'b100010;
assign MR=state[6];
assign MY=state[5];
assign MG=state[4];
assign SR=state[3];
assign SY=state[2];
assign SG=state[1];

initial begin state=MainRoadGreen;ST=0;end
always @(posedge clk)
begin 
if (reset)
begin 
state=MainRoadGreen; ST=1; end
else
begin
ST=0;
case(state)
MainRoadGreen:
if (TL&C)
begin state=MainRoadYellow; ST=1;
end
MainRoadYellow:
if (TS) begin
state=SideRoadGreen; ST=1; end
SideRoadGreen:
if (TL|!C) begin
state=SideRoadYellow; ST=1; end
SideRoadYellow:
if (TS) begin
state=MainRoadGreen; ST=1; end
endcase
end
end
endmodule
