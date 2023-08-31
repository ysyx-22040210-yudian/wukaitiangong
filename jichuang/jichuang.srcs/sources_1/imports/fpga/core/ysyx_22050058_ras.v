/*
 * @Author: WenJiaBao-2022E8020282071
 * @Date: 2022-12-16 15:10:18
 * @LastEditTime: 2022-12-16 15:10:20
 * @Description: 
 * 
 * Copyright (c) 2022 by WenJiaBao wenjiabao0919@163.com, All Rights Reserved. 
 */
`include "ysyx_22050058_define.v"
module ysyx_22050058_ras ( 
    input   wire                        clk,
    input   wire                        rst,
    input   wire                        stall,
    input   wire                        flush,
    input   wire    [2:0]               ras_jumpop_i,
    input   wire                        ras_btbhit_i,
    input   wire    [31:0]              ras_btbhitaddr,
    output  reg     [31:0]              ras_target_o
);


reg [31:0]  ras_entry [15:0];
reg [3:0]   ras_headptr;
wire[3:0]   ras_ptr = ras_headptr - 4'd1;
always @(posedge clk ) begin
    if (rst) begin
        ras_headptr <= `ysyx_22050058_ZeroWord;
    end else if ((!flush)&&(!stall) && ras_btbhit_i && (ras_jumpop_i == `ysyx_22050058_BTB_CALLOP || ras_jumpop_i == `ysyx_22050058_BTB_CALLANDRETOP))begin
        ras_headptr <= ras_headptr + 4'd1;
    end else if ((!flush)&&(!stall) && ras_btbhit_i && (ras_jumpop_i == `ysyx_22050058_BTB_RETOP|| ras_jumpop_i == `ysyx_22050058_BTB_CALLANDRETOP))begin
        ras_headptr <=  ras_headptr - 4'd1;
    end else begin
        ras_headptr <=  ras_headptr;
    end
end
always @(posedge clk ) begin
    if (rst) begin
        ras_target_o <= `ysyx_22050058_ZeroWord;
    end else begin
        ras_target_o <= ras_entry[ras_ptr];
    end
end
always @(posedge clk ) begin
    if (rst) begin
        ras_entry[0] <= `ysyx_22050058_ZeroWord;
        ras_entry[1] <= `ysyx_22050058_ZeroWord;
        ras_entry[2] <= `ysyx_22050058_ZeroWord;
        ras_entry[3] <= `ysyx_22050058_ZeroWord;
        ras_entry[4] <= `ysyx_22050058_ZeroWord;
        ras_entry[5] <= `ysyx_22050058_ZeroWord;
        ras_entry[6] <= `ysyx_22050058_ZeroWord;
        ras_entry[7] <= `ysyx_22050058_ZeroWord;
        ras_entry[8] <= `ysyx_22050058_ZeroWord;
        ras_entry[9] <= `ysyx_22050058_ZeroWord;
        ras_entry[10] <= `ysyx_22050058_ZeroWord;
        ras_entry[11] <= `ysyx_22050058_ZeroWord;
        ras_entry[12] <= `ysyx_22050058_ZeroWord;
        ras_entry[13] <= `ysyx_22050058_ZeroWord;
        ras_entry[14] <= `ysyx_22050058_ZeroWord;
        ras_entry[15] <= `ysyx_22050058_ZeroWord;
    end else if ((!flush)&&(!stall) && ras_btbhit_i && (ras_jumpop_i == `ysyx_22050058_BTB_CALLOP || ras_jumpop_i == `ysyx_22050058_BTB_CALLANDRETOP)) begin
        ras_entry[ras_headptr]   <= ras_btbhitaddr;
    end
end
endmodule
