`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/09 19:38:49
// Design Name: 
// Module Name: la32r_IF_stage
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

module la32r_IF_stage(
    input clk,
    input rstn,

    // id_allowin
    input id_allowin,
    // br_if bus
    input [`br_bus_length - 1 : 0]  br_bus,
    // if_id bus
    output if_to_id_valid,
    output [`if_to_id_bus_length - 1 : 0] if_to_id_bus,
    // inst_sram
    output  inst_sram_en,
    output  inst_sram_wen,
    output [31:0] inst_sram_addr,
    output [31:0] inst_sram_wdata,
    input [31:0] inst_sram_rdata
    );

    // if_stage
    reg if_valid;
    wire if_ready_go;
    wire if_allowin;
    wire to_if_valid;

    //br_bus_signals
    wire br_jump_en;
    wire [31:0] br_jump_target;

    // if_to_id_bus_signals
    wire [31:0] if_inst;
    reg [31:0] if_pc;

    // pc_calc_signals
    wire [31:0] seq_pc;
    wire [31:0] next_pc;

    // br_bus
    assign {
            br_jump_en,     // 32:32
            br_jump_target  // 31:0
        } = br_bus;

    // if_to_id_bus
    assign if_inst = inst_sram_rdata;
    assign if_to_id_bus = {
                            if_inst,     // 63:32 
                            if_pc       // 31:0
                        };

    // pc_calc
    assign seq_pc = if_pc + 32'h4;
    assign next_pc = br_jump_en ? br_jump_target : seq_pc;

    // inst_sram
    assign inst_sram_en = 1'b1;
    assign inst_sram_wen = 1'b0;
    assign inst_sram_addr = next_pc;
    assign inst_sram_wdata = 32'h0;

    // if_stage
    assign to_if_valid = rstn;

    assign if_ready_go = 1'b1;
    assign if_allowin = !if_valid || if_ready_go && id_allowin;
    assign if_to_id_valid = if_valid && if_ready_go;

    always @(posedge clk) begin
        if(!rstn) 
            if_valid <= 1'b0;
        else if (if_allowin) 
            if_valid <= to_if_valid;
    end

    always @(posedge clk) begin
        if(!rstn) 
            if_pc <= 32'h1BFFFFFC;
        else if (to_if_valid && if_allowin)
            if_pc <= next_pc; 
    end

endmodule
