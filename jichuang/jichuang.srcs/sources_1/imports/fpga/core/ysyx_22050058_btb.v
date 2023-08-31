/*
 * @Author: WenJiaBao-2022E8020282071
 * @Date: 2022-11-13 00:22:15
 * @LastEditTime: 2022-12-01 11:47:45
 * @Description: 
 * 
 * Copyright (c) 2022 by WenJiaBao wenjiabao0919@163.com, All Rights Reserved. 
 */
 `include "ysyx_22050058_define.v"
 `define Testbtbsize 9:2
module ysyx_22050058_btb#(
	parameter GSH_BTB_NUM = 256)
(
    input    wire                                    clk,
    input    wire                                    rst,
    input    wire                                    stall,   
    // Interface with IF Stage
    input    wire     [`ysyx_22050058_InstAdderBus]  btb_pcdelay_i,
    input    wire     [`ysyx_22050058_InstAdderBus]  btb_pc1_i,
   // input    wire     [`ysyx_22050058_InstAdderBus]  btb_pc2_i,
    output   wire                                    btb_hit1_o,
  //  output   wire                                    btb_hit2_o,
    output   wire     [`ysyx_22050058_InstAdderBus]  btb_hitaddr1_o,
   // output   wire     [`ysyx_22050058_InstAdderBus]  btb_hitaddr2_o,
    output   reg      [2:0]                          btb_op_o,
    // Interface with Commit Stage   
    input    wire     [`ysyx_22050058_InstAdderBus]  btb_fixjumpaddr_i,
    input    wire                                    btb_fixwe_i,
    input    wire     [2:0]                          btb_fixjumpop_i,
    input    wire     [`ysyx_22050058_InstAdderBus]  btb_fixpc_i    
);

reg [31:0] btb [GSH_BTB_NUM -1 : 0] ;
reg [31:0] tag [GSH_BTB_NUM -1 : 0] ;
reg [2:0] btb_op[GSH_BTB_NUM -1 : 0] ;
reg [GSH_BTB_NUM -1 : 0]btb_valid_r  ;

reg [31:0] btb_data; 
reg [31:0] btb_tag;

//wire [31:0] btb_pcdelayplus4 = btb_pcdelay_i +'h4;
assign btb_hit1_o =  (btb_pcdelay_i == btb_tag) && btb_valid_r[btb_pcdelay_i[`Testbtbsize]] ? 1'b1 : 1'b0 ;
//assign btb_hit2_o =  (btb_pcdelayplus4 == btb_tag) && btb_valid_r[btb_pcdelayplus4[`Testbtbsize]] ? 1'b1 : 1'b0 ;
assign btb_hitaddr1_o   = btb_hit1_o ? btb_data : `ysyx_22050058_ZeroWord;
//assign btb_hitaddr2_o   = btb_hit2_o ? btb_data : `ysyx_22050058_ZeroWord;

    always @(posedge clk ) begin
        if (rst) begin
            btb_valid_r <= `ysyx_22050058_ZeroWord;
        end else if (btb_fixwe_i) begin
            btb_valid_r[btb_fixpc_i[`Testbtbsize]] <= 1'b1;
        end
    end

integer i;

    always @(posedge clk ) begin
        if (rst) begin
            for (i = 0; i < GSH_BTB_NUM; i = i + 1) begin
                btb[i] <= 32'b0;
                btb_op[i] <= 3'b0;
            end
            btb_data <= 32'b0;
            btb_op_o<= 3'b0;
        end else begin
             if (btb_fixwe_i == `ysyx_22050058_True) begin
                btb[btb_fixpc_i[`Testbtbsize]] <=  btb_fixjumpaddr_i;
                btb_op[btb_fixpc_i[`Testbtbsize]] <=  btb_fixjumpop_i;
            end 
            btb_data <= (btb_fixwe_i && (btb_pc1_i[`Testbtbsize]==btb_fixpc_i[`Testbtbsize] )) ? btb_fixjumpaddr_i  :btb[btb_pc1_i[`Testbtbsize]];   // output btb data
            btb_op_o   <= (btb_fixwe_i && (btb_pc1_i[`Testbtbsize]==btb_fixpc_i[`Testbtbsize] )) ? btb_fixjumpop_i  :btb_op[btb_pc1_i[`Testbtbsize]]; //output btb op
        end
    end

integer j;
    always @(posedge clk ) begin
        if (rst) begin
            for (j = 0; j < GSH_BTB_NUM; j = j + 1) begin
                tag[j] <= 32'b0;
            end
            btb_tag <= 32'b0;
        end else begin
            if (btb_fixwe_i == `ysyx_22050058_True) begin
                tag[btb_fixpc_i[`Testbtbsize]] <=  btb_fixpc_i;
            end 
            btb_tag <= (btb_fixwe_i && (btb_pc1_i[`Testbtbsize]==btb_fixpc_i[`Testbtbsize] )) ? btb_fixpc_i  : tag[btb_pc1_i[`Testbtbsize]];
        end
    end
endmodule
