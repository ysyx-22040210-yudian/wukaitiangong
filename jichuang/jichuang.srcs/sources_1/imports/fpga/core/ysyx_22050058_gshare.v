
/*
 * @Author: WenJiaBao-2022E8020282071
 * @Date: 2022-11-13 00:22:15
 * @LastEditTime: 2022-12-01 11:47:45
 * @Description: 
 * 
 * Copyright (c) 2022 by WenJiaBao wenjiabao0919@163.com, All Rights Reserved. 
 */
`include "ysyx_22050058_define.v"
module ysyx_22050058_gshare(
    input   wire                        clk,
    input   wire                        rst,
    input   wire                        stall,
    input   wire                        flush,
    // Interface with IF Stage
     // The mini-decoded info 
    input  dec_jal,
    input  dec_jalr,
    input  dec_bxx,
    input   wire   [2:0]                                    gshare_btbop_i,
    input   wire   [`ysyx_22050058_InstAdderBus]            gshare_pc1_i,
    //input   wire   [`ysyx_22050058_InstAdderBus]            gshare_pc2_i,  
    input   wire                                            gshare_btbhit_i,   
    output  wire   [`ysyx_22050058_BHR_BUS]                 gshare_bhr_o,  
    output  wire   [1:0]                                    gshare_pht_o,       
    output  wire                                            gshare_istaken1_o, 
    //output  wire                                            gshare_istaken2_o,  
    // Interface with EX Stage
    input   wire                                            exisjump_i,
    input   wire   [`ysyx_22050058_BHR_BUS]                 bpu_exfixbhr_i,
    input   wire   [`ysyx_22050058_BHR_BUS]                 bpu_exrealbhr_i,
    input   wire                                            gshare_prmiss_i,   
    input   wire                                            gshare_prsuccessbutnotupdate_i,
    // Interface with Commit Stage
    input   wire                                            gshare_wepht_i,   
    input   wire   [1:0]                                    gshare_fixpht_i,     
    input   wire    [`ysyx_22050058_InstAdderBus]           gshare_fixpc_i,    
    input   wire    [`ysyx_22050058_BHR_BUS]                bpu_fixbhr_i
);
reg [`ysyx_22050058_BHR_BUS] bhr;
wire [1:0] pht_count1;
wire dec_dongtai = dec_bxx |dec_jalr | dec_jal;
//wire [1:0] pht_count2;
always @(posedge clk ) begin
    if(rst)begin
        bhr <= `ysyx_22050058_ZeroWord;
    end else if(gshare_prmiss_i == `ysyx_22050058_True)begin
        //bhr <= bpu_exfixbhr_i;
        bhr <= {bpu_exfixbhr_i[`ysyx_22050058_BHRLEN-2:0],exisjump_i};
    // end else if((!flush)&&(!stall )&&gshare_prsuccessbutnotupdate_i == `ysyx_22050058_True)begin
    //     bhr <= {bpu_exrealbhr_i[`ysyx_22050058_BHRLEN-2:0],exisjump_i};
    end else if((!flush)&&(!stall )&& dec_dongtai == `ysyx_22050058_True)begin
        bhr <= {bhr[`ysyx_22050058_BHRLEN-2:0], (gshare_istaken1_o)||(dec_jalr | dec_jal)};
    
    end
end

assign gshare_bhr_o = bhr;
assign gshare_pht_o = pht_count1 ;
assign gshare_istaken1_o = ((pht_count1 > 2'b01) ? 1'b1 : 1'b0)  | dec_jalr | dec_jal;
//assign gshare_istaken2_o = ((pht_count2 > 2'b01) ? 1'b1 : 1'b0) | (|gshare_btbop_i && gshare_btbhit_i);
`define UnseHASH 1
`ifdef UnseHASH
wire [2*`ysyx_22050058_BHRLEN :0] hashgshare_pc1_i = gshare_pc1_i;
//wire [2*`ysyx_22050058_BHRLEN :0] hashgshare_pc2_i = gshare_pc2_i;
wire [2*`ysyx_22050058_BHRLEN :0] hashgshare_fixpc_i = gshare_fixpc_i;
`else
wire [2*`ysyx_22050058_BHRLEN :0] hashgshare_pc1_i = (gshare_pc1_i[2*`ysyx_22050058_BHRLEN -1:`ysyx_22050058_BHRLEN] ^ gshare_pc1_i[`ysyx_22050058_BHRLEN-1:0]);
//wire [2*`ysyx_22050058_BHRLEN :0] hashgshare_pc2_i = (gshare_pc2_i[2*`ysyx_22050058_BHRLEN -1:`ysyx_22050058_BHRLEN] ^ gshare_pc2_i[`ysyx_22050058_BHRLEN-1:0]);
wire [2*`ysyx_22050058_BHRLEN :0] hashgshare_fixpc_i = (gshare_fixpc_i[2*`ysyx_22050058_BHRLEN -1:`ysyx_22050058_BHRLEN] ^ gshare_fixpc_i[`ysyx_22050058_BHRLEN-1:0]);
`endif 
wire [`ysyx_22050058_BHR_BUS] phtbhr = gshare_prmiss_i ? {bpu_exfixbhr_i[`ysyx_22050058_BHRLEN-2:0],exisjump_i} : 
                                        ((!flush)&&(!stall )&&gshare_btbhit_i == `ysyx_22050058_True) ? 
                                        {bhr[`ysyx_22050058_BHRLEN-2:0], (gshare_istaken1_o)||(dec_jalr | dec_jal)} :
                                        bhr;
ysyx_22050058_pht ysyx_22050058_pht_u0( 
    .clk(clk),
    .rst(rst),
    .raddr1(hashgshare_pc1_i[2+:`ysyx_22050058_BHRLEN]^phtbhr),
    //.raddr2(hashgshare_pc1_i[2+:`ysyx_22050058_BHRLEN]^phtbhr),
    .rdata1(pht_count1),
    //.rdata2(pht_count2),
    .we(gshare_wepht_i),
    .waddr(hashgshare_fixpc_i[2+:`ysyx_22050058_BHRLEN]^bpu_fixbhr_i),
    .wdata(gshare_fixpht_i)
);


endmodule
