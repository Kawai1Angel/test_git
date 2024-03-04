`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/10 12:41:07
// Design Name: 
// Module Name: la32r_alu
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


module la32r_alu(
    input [1:0] alu_op,

    input [31:0] alu_src1,
    input [31:0] alu_src2,
    output [31:0] alu_out
    );

    // alu operation valid
    wire op_add;
    wire op_lui;

    // alu_op_add
    wire [31:0] adder_src1;
    wire [31:0] adder_src2;
    wire adder_cin;
    wire add_cout;
    wire [31:0] add_result;
    
    // alu_op_lui
    wire [31:0] lui_result;

    //alu_op_add
    assign adder_src1 = alu_src1;
    assign adder_src2 = alu_src2;
    assign adder_cin = 1'b0;
    assign {add_cout, add_result} = adder_src1 + adder_src2 + adder_cin;

    // alu_op_lui
    assign lui_result = alu_src1;

    // alu_result
    assign {op_lui, op_add} = alu_op;
    assign alu_out = ({32{op_add}} & add_result) | ({32{op_lui}} & lui_result);

endmodule
