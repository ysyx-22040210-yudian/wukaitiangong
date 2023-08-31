/*
 * @Author: WenJiaBao-2022E8020282071
 * @Date: 2022-11-13 00:22:15
 * @LastEditTime: 2022-12-01 11:47:45
 * @Description: 
 * 
 * Copyright (c) 2022 by WenJiaBao wenjiabao0919@163.com, All Rights Reserved. 
 */
 `include "ysyx_22050058_define.v"
module ysyx_22050058_pht #(
	parameter GSH_PHT_NUM = 2**`ysyx_22050058_BHRLEN
			   )(
    input       wire                        clk,
    input       wire                        rst,
    input       wire  [`ysyx_22050058_BHR_BUS]          raddr1,
    //input       wire  [`ysyx_22050058_BHR_BUS]          raddr2,
    output      reg  [1:0]                      rdata1,
    //output      reg  [1:0]                      rdata2,
    input       wire           we,
    input       wire  [`ysyx_22050058_BHR_BUS]                      waddr,
    input       wire  [1:0]                      wdata
);

reg [1:0] pht [GSH_PHT_NUM -1 : 0] ;
integer i;

always @(posedge clk ) begin
    if (rst) begin
        for (i = 0; i < GSH_PHT_NUM; i = i + 1) begin
            pht[i] <= 2'b00;
        end
        rdata1 <= 2'b0;
        //rdata2 <= 2'b0;
    end else begin
        if (we == `ysyx_22050058_True) begin
                pht[waddr] <=  wdata;
        end 
        rdata1 <= pht[raddr1];
       // rdata2 <= pht[raddr2];
    end
end

endmodule
