`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/09 19:39:32
// Design Name: 
// Module Name: la32r_WB_stage
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

module la32r_WB_stage(
    input clk,
    input rstn,
    
    // wb_allowin
    output wb_allowin,
    // mem_to_wb_bus
    input mem_to_wb_valid,
    input [`mem_to_wb_bus_length - 1 : 0] mem_to_wb_bus,
    // wb_to_id_bus
    output [`wb_to_id_bus_length - 1 : 0] wb_to_id_bus,
    //trace debug interface
    output [31:0] debug_wb_pc     ,
    output debug_wb_rf_wen ,
    output [ 4:0] debug_wb_rf_wnum,
    output [31:0] debug_wb_rf_wdata
    );

    // wb_stage_signals
    reg [`mem_to_wb_bus_length - 1 : 0] mem_to_wb_bus_r;
    reg wb_valid;
    wire wb_ready_go;

    // mem_to_wb_bus_signals
    wire wb_rf_we;
    wire [4:0] wb_dest_reg;
    wire [31:0] wb_final_result;
    wire [31:0] wb_pc;

    // wb_to_id_bus_signals
    wire [4:0] wb_rf_waddr;
    wire [31:0] wb_rf_wdata;

    // mem_to_wb_bus
    assign {
            wb_rf_we,           // 69:69
            wb_dest_reg,        // 68:64
            wb_final_result,    // 63:32
            wb_pc               // 31:0
    } = mem_to_wb_bus_r;

    // wb_to_id_bus
    assign wb_rf_waddr = wb_dest_reg;
    assign wb_rf_wdata = wb_final_result;
    assign wb_to_id_bus = {
                            wb_rf_we,       // 37:37
                            wb_rf_waddr,    // 36:32
                            wb_rf_wdata     // 31:0
                        };

    // debug
    assign debug_wb_pc = wb_pc;
    assign debug_wb_rf_wen = wb_rf_we;
    assign debug_wb_rf_wnum = wb_rf_waddr;
    assign debug_wb_rf_wdata = wb_rf_wdata;

    // wb_stage 
    assign wb_ready_go = 1'b1;
    assign wb_allowin = !wb_valid || wb_ready_go;

    always @(posedge clk) begin
        if(!rstn)
            wb_valid <= 1'b0;
        else if(wb_allowin)
            wb_valid <= mem_to_wb_valid;
         
    end 

    always @(posedge clk) begin
        if(wb_allowin && mem_to_wb_valid)
            mem_to_wb_bus_r <= mem_to_wb_bus;
    end

endmodule
