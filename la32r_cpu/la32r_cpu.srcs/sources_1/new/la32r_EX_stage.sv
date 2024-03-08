`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/09 19:39:01
// Design Name: 
// Module Name: la32r_EX_stage
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

module la32r_EX_stage(
    input clk,
    input rstn,

    // ex_allowin
    output ex_allowin,
    // mem_allowin
    input mem_allowin,

    // id_to_ex_bus
    input id_to_ex_valid,
    input [`id_to_ex_bus_length - 1 : 0] id_to_ex_bus,
    // ex_to_mem_bus
    output ex_to_mem_valid,
    output [`ex_to_mem_bus_length - 1 : 0] ex_to_mem_bus,
    // data_sram
    output        data_sram_en,
    output [3:0]  data_sram_wen,
    output [31:0] data_sram_addr,
    output [31:0] data_sram_wdata
    );

    // ex_stage_signals
    reg [`id_to_ex_bus_length - 1 : 0] id_to_ex_bus_r;
    reg ex_valid;
    wire ex_ready_go;

    // id_to_ex_bus_signals
    wire [1:0] ex_alu_op;
    wire ex_alu_src1_is_pc;
    wire ex_alu_src1_is_zero;
    wire ex_alu_src2_is_four;
    wire ex_alu_src2_is_imm;
    wire ex_mem_we;
    wire ex_res_from_mem;
    wire ex_rf_we;
    wire [4:0] ex_dest_reg;
    wire [31:0] ex_imm;
    wire [31:0] ex_rj_value;
    wire [31:0] ex_rkd_value;
    wire [31:0] ex_pc;

    // ex_to_mem_bus_signals
    wire [31:0] ex_alu_result;

    // alu_signals
    wire [31:0] alu_src1;
    wire [31:0] alu_src2;

    // id_to_ex_bus
    assign {
            ex_alu_op,              // 141:140
            ex_alu_src1_is_pc,      // 139:139
            ex_alu_src1_is_zero,    // 138:138
            ex_alu_src2_is_four,    // 137:137
            ex_alu_src2_is_imm,     // 136:136
            ex_mem_we,              // 135:135
            ex_res_from_mem,        // 134:134
            ex_rf_we,               // 133:133
            ex_dest_reg,            // 132:128
            ex_imm,                 // 127:96
            ex_rj_value,            // 95:64
            ex_rkd_value,            // 63:32
            ex_pc                   // 31:0
    } = id_to_ex_bus_r;

    // ex_to_mem_bus
    assign ex_to_mem_bus = {
                            ex_res_from_mem,    // 70:70
                            ex_rf_we,           // 69:69
                            ex_dest_reg,        // 68:64
                            ex_alu_result,      // 63:32
                            ex_pc               // 31:0
                        };

    // alu
    la32r_alu  la32r_alu_inst (
        .alu_op(ex_alu_op),
        .alu_src1(alu_src1),
        .alu_src2(alu_src2),
        .alu_out(ex_alu_result)
        );
    assign alu_src1 = ex_alu_src1_is_pc ? ex_pc : 
                        ex_alu_src1_is_zero ? 32'h0 :
                        ex_rj_value;
    assign alu_src2 = ex_alu_src2_is_imm ? ex_imm :
                        ex_alu_src2_is_four ? 32'h4 :
                        ex_rkd_value;

    // data_sram
    assign data_sram_en = 1'b1;
    assign data_sram_wen = ex_mem_we && ex_valid ? 4'hf : 4'h0;
    assign data_sram_addr = ex_alu_result;
    assign data_sram_wdata = ex_rkd_value;

    // ex_stage
    assign ex_ready_go = 1'b1;
    assign ex_allowin = !ex_valid || ex_ready_go && mem_allowin;
    assign ex_to_mem_valid = ex_valid && ex_ready_go;

    always @(posedge clk) begin
        if(!rstn)
            ex_valid <= 1'b0;
        else if(ex_allowin) 
            ex_valid <= id_to_ex_valid; 
    end

    always @(posedge clk) begin
        if(ex_allowin && id_to_ex_valid)
            id_to_ex_bus_r <= id_to_ex_bus;
    end

endmodule
