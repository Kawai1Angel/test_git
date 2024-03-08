`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/09 19:38:01
// Design Name: 
// Module Name: la32r_ID_stage
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

module la32r_ID_stage(
    input clk,
    input rstn,

    // id_allowin
    output id_allowin,
    // ex_allowin
    input ex_allowin,

    // if_id_bus
    input if_to_id_valid,
    input [`if_to_id_bus_length - 1 : 0]  if_to_id_bus,
    // id_ex_bus
    output id_to_ex_valid,
    output [`id_to_ex_bus_length - 1 : 0] id_to_ex_bus,
    // br_bus
    output [`br_bus_length - 1 : 0] br_bus,
    // wb_id_bus
    input [`wb_to_id_bus_length - 1 : 0]  wb_to_id_bus
    );

    //id_stage_signals
    reg [`if_to_id_bus_length - 1 : 0] if_to_id_bus_r;
    reg id_valid;
    wire id_ready_go;

    // if_to_id_bus_signals
    wire [31:0] id_inst;
    wire [31:0] id_pc;

    // id_to_ex_bus_signals
    wire [1:0] id_alu_op;
    wire id_alu_src1_is_pc;
    wire id_alu_src1_is_zero;
    wire id_alu_src2_is_imm;
    wire id_alu_src2_is_four;
    wire id_mem_we;
    wire id_res_from_mem;
    wire id_rf_we;
    wire [31:0] id_rj_value;
    wire [31:0] id_rkd_value;
    wire [31:0] id_imm;
    wire [4:0] id_dest_reg;

    // br_bus_signals
    wire br_jump_en;
    wire [31:0] br_jump_dest;

    // wb_to_id_bus_signals
    wire wb_rf_we;
    wire [4:0] wb_rf_waddr;
    wire [31:0] wb_rf_wdata;

    // inst_decode_signals
    wire [5:0] opcode;
    wire [3:0] func1;
    wire [6:0] func2;
    wire [4:0] rk;
    wire [4:0] rj;
    wire [4:0] rd;
    wire [11:0] si12;
    wire [19:0] si20;

    wire [63:0] opcode_d;
    wire [15:0] func1_d;
    wire [127:0] func2_d;

    // inst_valid_signals
    wire inst_addw;
    wire inst_addiw;
    wire inst_lu12iw;
    wire inst_stw;
    wire inst_ldw;
    wire inst_bne;

    // regfile_signals
    wire rf_res_from_rd;
    wire [4:0] rf_raddr0;
    wire [4:0] rf_raddr1;
    wire [4:0] rf_waddr;
    wire [31:0] rf_rdata0;
    wire [31:0] rf_rdata1;
    wire [31:0] rf_wdata;
    wire rf_we;

    // inst_decode
    decoder_6 decoder_opcode (
        .orig_code(opcode),
        .output_code(opcode_d)
    );

    decoder_4 decoder_func1 (
        .orig_code(func1),
        .output_code(func1_d)  
    );

    decoder_7 decoder_func2 (
        .orig_code(func2),
        .output_code(func2_d)
    );

    assign opcode = id_inst[31:26];
    assign func1 = id_inst[25:22];
    assign func2 = id_inst[21:15];
    assign rk = id_inst[14:10];
    assign rj = id_inst[9:5];
    assign rd = id_inst[4:0];
    assign si12 = id_inst[21:10];
    assign si20 = id_inst[24:5];
    
    // inst_valid
    assign inst_addw = opcode_d[6'h00] & func1_d[4'h0] & func2_d[7'h20];
    assign inst_addiw = opcode_d[6'h00] & func1_d[4'ha];
    assign inst_lu12iw = opcode_d[6'h05];
    assign inst_stw = opcode_d[6'h0a] & func1_d[4'h6];
    assign inst_ldw = opcode_d[6'h0a] & func1_d[4'h2];
    assign inst_bne = opcode_d[6'h17];

    // if_to_id_bus
    assign {
            id_inst,    // 63:32
            id_pc       // 31:0
        } = if_to_id_bus_r;

    // id_to_ex_bus
    assign id_alu_op[0] = inst_addw | inst_addiw;
    assign id_alu_op[1] = inst_lu12iw;
    assign id_alu_src1_is_pc = 0;
    assign id_alu_src1_is_zero = inst_lu12iw;
    assign id_alu_src2_is_four = 0;
    assign id_alu_src2_is_imm = inst_addiw | inst_lu12iw;
    assign id_mem_we = inst_stw;
    assign id_res_from_mem = inst_ldw;
    assign id_rf_we = inst_addw | inst_addiw | inst_lu12iw | inst_ldw;
    assign id_dest_reg = rd;
    assign id_rj_value = rf_rdata0;
    assign id_rkd_value = rf_rdata1;
    assign id_imm = ({{20{si12[11]}}, si12} & inst_addiw) |
                ({si20, 12'h0} & inst_lu12iw);
    assign id_to_ex_bus = {
                            id_alu_op,              // 141:140
                            id_alu_src1_is_pc,      // 139:139
                            id_alu_src1_is_zero,    // 138:138
                            id_alu_src2_is_four,    // 137:137
                            id_alu_src2_is_imm,     // 136:136
                            id_mem_we,              // 135:135
                            id_res_from_mem,        // 134:134
                            id_rf_we,               // 133:133
                            id_dest_reg,            // 132:128
                            id_imm,                 // 127:96
                            id_rj_value,            // 95:64
                            id_rkd_value,            // 63:32
                            id_pc                   // 31:0
                        };

    // br_bus
    assign br_jump_en = inst_bne && ~(id_rj_value == id_rkd_value) && id_valid;
    assign br_jump_dest = {{4{id_inst[9]}}, id_inst[9:0], id_inst[25:10], 2'h0};
    assign br_bus = {
                    br_jump_en,     // 32:32
                    br_jump_dest    // 31:0
                };

    // wb_to_id_bus
    assign {
            wb_rf_we,       // 37:37
            wb_rf_waddr,    // 36:32
            wb_rf_wdata     // 31:0
        } = wb_to_id_bus;

    // regfile
    la32r_regfile #(
        .ADDR_WIDTH(5),
        .DATA_WIDTH(32)
        ) la32r_regfile_inst (
        .clk(clk),
        .ra0(rf_raddr0),
        .ra1(rf_raddr1),
        .rd0(rf_rdata0),
        .rd1(rf_rdata1),
        .wa(rf_waddr),
        .wd(rf_wdata),
        .we(rf_we)
        );

    assign rf_res_from_rd = inst_stw | inst_bne;
    assign rf_raddr0 = rj;
    assign rf_raddr1 = rf_res_from_rd ? rd : rk;
    assign rf_waddr = wb_rf_waddr;
    assign rf_wdata = wb_rf_wdata;
    assign rf_we = wb_rf_we;

    // id_stage
    assign id_ready_go = 1'b1;
    assign id_allowin = !id_valid || id_ready_go && ex_allowin;
    assign id_to_ex_valid = id_valid && id_ready_go;

    always @(posedge clk) begin
        if(!rstn) 
            id_valid <= 1'b0;
        else if(id_allowin)
            id_valid <= if_to_id_valid;
    end

    always @(posedge clk) begin
        if(if_to_id_valid && id_allowin) 
            if_to_id_bus_r <= if_to_id_bus;
    end
    
endmodule
