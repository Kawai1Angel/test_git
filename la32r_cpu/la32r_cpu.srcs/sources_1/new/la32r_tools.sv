`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/09 19:39:51
// Design Name: 
// Module Name: 
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

module decoder_4 (
    input [3:0] orig_code,

    output [15:0] output_code
    );
    genvar i;
    generate for(i = 0; i < 16; i = i + 1) begin : gen_for_dec_4_16
            assign output_code[i] = (orig_code == i);
        end
    endgenerate

endmodule

module decoder_6 (
    input [5:0] orig_code,

    output [63:0] output_code
    );
    genvar i;
    generate for(i = 0; i < 64; i = i + 1) begin : gen_for_dec_6_64
            assign output_code[i] = (orig_code == i);
        end
    endgenerate

endmodule

module decoder_7 (
    input [6:0] orig_code,

    output [127:0] output_code
    );
    genvar i;
    generate for(i = 0; i < 128; i = i + 1) begin : gen_for_dec_7_128
            assign output_code[i] = (orig_code == i);
        end
    endgenerate

endmodule