`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/10 12:41:26
// Design Name: 
// Module Name: la32r_regfile
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


module la32r_regfile #(
    parameter ADDR_WIDTH = 5,
    parameter DATA_WIDTH = 32
    )(
    input clk,
    input [ADDR_WIDTH - 1 : 0] ra0, ra1,    // read address
    output [DATA_WIDTH - 1 : 0] rd0, rd1,   // read data
    input [ADDR_WIDTH - 1 : 0] wa,          // write address
    input [DATA_WIDTH - 1 : 0] wd,          // write data
    input we                                // write enable
    );
    reg [DATA_WIDTH - 1 : 0] rf[0 : (1 << ADDR_WIDTH) - 1];     //regs

    // read operation : read first
    assign rd0 = (ra0 == 5'h0) ? 32'h0 : rf[ra0];
    assign rd1 = (ra1 == 5'h0) ? 32'h0 : rf[ra1];

    // write operation :
    always @(posedge clk) begin
        if(we) rf[wa] <= wd;
    end
endmodule
