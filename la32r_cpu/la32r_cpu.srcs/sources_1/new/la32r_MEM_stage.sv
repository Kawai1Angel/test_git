`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/09 19:39:15
// Design Name: 
// Module Name: la32r_MEM_stage
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

`include "la32r_define.h"

module la32r_MEM_stage(
    // ex_to_mem_bus
    input [`ex_to_mem_bus_length - 1 : 0] ex_to_mem_bus,
    // mem_to_wb_bus
    output [`mem_to_wb_bus_length - 1 : 0] mem_to_wb_bus,
    // data_sram
    input [31:0] data_sram_rdata
    );

    // ex_to_mem_bus_signals
    wire mem_res_from_mem;
    wire mem_rf_we;
    wire [4:0] mem_dest_reg;
    wire [31:0] mem_alu_result;
    wire [31:0] mem_pc;

    // mem_to_wb_bus_signals
    wire [31:0] mem_final_result;

    //ex_to_mem_bus
    assign {
            mem_res_from_mem,   // 70:70
            mem_rf_we,          // 69:69
            mem_dest_reg,       // 68:64
            mem_alu_result,     // 63:32
            mem_pc              // 31:0
        } = ex_to_mem_bus;

    // mem_to_wb_bus
    assign mem_final_result = mem_res_from_mem ? data_sram_rdata : mem_alu_result;
    assign mem_to_wb_bus = {
                            mem_rf_we,          // 69:69
                            mem_dest_reg,       // 68:64
                            mem_final_result,   // 63:32
                            mem_pc              // 31:0
                        };
endmodule
