`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/09 19:35:59
// Design Name: 
// Module Name: la32r_top
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

module la32r_top(
    // clock and resetn
    input clk,
    input rstn,
    // inst_sram
    output        inst_sram_en,
    output [3:0]  inst_sram_wen,
    output [31:0] inst_sram_addr,
    output [31:0] inst_sram_wdata,
    input  [31:0] inst_sram_rdata,
    // data_sram
    output        data_sram_en,
    output [3:0]  data_sram_wen,
    output [31:0] data_sram_addr,
    output [31:0] data_sram_wdata,
    input  [31:0] data_sram_rdata,
    // debug
    output [31:0] debug_wb_pc,
    output        debug_wb_rf_wen,
    output [4:0]  debug_wb_rf_wnum,
    output [31:0] debug_wb_rf_wdata
);

    // bus_signals
    wire [`if_to_id_bus_length - 1 : 0] if_to_id_bus;
    wire [`id_to_ex_bus_length - 1 : 0] id_to_ex_bus;
    wire [`ex_to_mem_bus_length - 1 : 0] ex_to_mem_bus;
    wire [`mem_to_wb_bus_length - 1 : 0] mem_to_wb_bus;
    wire [`wb_to_id_bus_length - 1 : 0] wb_to_id_bus;
    wire [`br_bus_length - 1 : 0] br_bus;

    // valid_signals
    wire if_to_id_valid;
    wire id_to_ex_valid;
    wire ex_to_mem_valid;
    wire mem_to_wb_valid;
    
    // allowin_signals
    wire id_allowin;
    wire ex_allowin;
    wire mem_allowin;
    wire wb_allowin;

    la32r_IF_stage  la32r_IF_stage_inst (
        .clk(clk),
        .rstn(rstn),
        .br_bus(br_bus),
        .id_allowin(id_allowin),
        .if_to_id_valid(if_to_id_valid),
        .if_to_id_bus(if_to_id_bus),
        .inst_sram_en(inst_sram_en),
        .inst_sram_wen(inst_sram_wen),
        .inst_sram_addr(inst_sram_addr),
        .inst_sram_wdata(inst_sram_wdata),
        .inst_sram_rdata(inst_sram_rdata)
    );

    la32r_ID_stage  la32r_ID_stage_inst (
        .clk(clk),
        .rstn(rstn),
        .id_allowin(id_allowin),
        .ex_allowin(ex_allowin),
        .if_to_id_valid(if_to_id_valid),
        .if_to_id_bus(if_to_id_bus),
        .id_to_ex_valid(id_to_ex_valid),
        .id_to_ex_bus(id_to_ex_bus),
        .br_bus(br_bus),
        .wb_to_id_bus(wb_to_id_bus)
    );

    la32r_EX_stage  la32r_EX_stage_inst (
        .clk(clk),
        .rstn(rstn),
        .ex_allowin(ex_allowin),
        .mem_allowin(mem_allowin),
        .id_to_ex_valid(id_to_ex_valid),
        .id_to_ex_bus(id_to_ex_bus),
        .ex_to_mem_valid(ex_to_mem_valid),
        .ex_to_mem_bus(ex_to_mem_bus),
        .data_sram_en(data_sram_en),
        .data_sram_wen(data_sram_wen),
        .data_sram_addr(data_sram_addr),
        .data_sram_wdata(data_sram_wdata)
    );

    la32r_MEM_stage  la32r_MEM_stage_inst (
        .clk(clk),
        .rstn(rstn),
        .mem_allowin(mem_allowin),
        .wb_allowin(wb_allowin),
        .ex_to_mem_valid(ex_to_mem_valid),
        .ex_to_mem_bus(ex_to_mem_bus),
        .mem_to_wb_valid(mem_to_wb_valid),
        .mem_to_wb_bus(mem_to_wb_bus),
        .data_sram_rdata(data_sram_rdata)
    );

    la32r_WB_stage  la32r_WB_stage_inst (
        .clk(clk),
        .rstn(rstn),
        .wb_allowin(wb_allowin),
        .mem_to_wb_valid(mem_to_wb_valid),
        .mem_to_wb_bus(mem_to_wb_bus),
        .wb_to_id_bus(wb_to_id_bus),
        .debug_wb_pc(debug_wb_pc),
        .debug_wb_rf_wen(debug_wb_rf_wen),
        .debug_wb_rf_wnum(debug_wb_rf_wnum),
        .debug_wb_rf_wdata(debug_wb_rf_wdata)
    );
endmodule
