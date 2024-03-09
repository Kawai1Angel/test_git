`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/05 14:32:11
// Design Name: 
// Module Name: SoC_CPU_tb
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


module SoC_CPU_tb();

logic clk, rstn, rxd, txd;

SoC_top  SoC_top_inst (
    .clk(clk),
    .rstn(rstn),
    .rxd(rxd),
    .txd(txd)
  );

initial begin
    clk = 0;
    rstn = 0;
end

always #1 clk = ~clk;

initial begin
    #2 rstn = 1;
end

endmodule
