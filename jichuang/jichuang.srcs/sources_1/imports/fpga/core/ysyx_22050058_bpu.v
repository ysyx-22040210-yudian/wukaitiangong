/*
 * @Author: WenJiaBao-2022E8020282071
 * @Date: 2022-09-27 00:11:49
 * @LastEditTime: 2022-11-30 15:18:10
 * @Description: 
 * 
 * Copyright (c) 2022 by WenJiaBao wenjiabao0919@163.com, All Rights Reserved. 
 */
`include "ysyx_22050058_define.v"
module ysyx_22050058_bpu(
    input   wire                                    clk,
    input   wire                                    rst,
    input   wire                                    stall,
    input   wire                                    flush,
    // Interface with EX Stage
    input   wire                                    exisjump_i,
    input   wire                                    gshare_prsuccessbutnotupdate_i,
    input   wire                                    bpu_prmiss_i,
    input   wire    [`ysyx_22050058_BHR_BUS]        bpu_exfixbhr_i,
    input   wire    [`ysyx_22050058_BHR_BUS]        bpu_exrealbhr_i,
    // Interface with Commit Stage  
    input   wire                                    btb_fixwe_i,
    input   wire    [`ysyx_22050058_BHR_BUS]                           bpu_fixbhr_i,
    input   wire    [1:0]                           bpu_fixpht_i,
    input   wire    [`ysyx_22050058_InstAdderBus]   bpu_fixpc_i,
    input   wire    [`ysyx_22050058_InstAdderBus]   bpu_fixjumpaddr_i,
    input   wire                                    bpu_fixwe_i,
    input   wire     [2:0]                          btb_fixjumpop_i,
    // Interface with IF Stage
      // The mini-decoded info 
    input  dec_jal,
    input  dec_jalr,
    input  dec_bxx,
    input   wire    [`ysyx_22050058_InstAdderBus]   bpu_fetchpc_i,//pc_nxt
    output  wire                                    bpu1hit_o,
    //output  wire                                    bpu2hit_o,
    output  wire    [`ysyx_22050058_InstAdderBus]   bpu1hitaddr_o,
    //output  wire    [`ysyx_22050058_InstAdderBus]   bpu2hitaddr_o,
    output  wire    [`ysyx_22050058_BHR_BUS]                           bpu_bhr_o,
    output  wire    [1:0]                           bpu_pht_o,
    output  wire                                    bpu_istaken1_o
    //output  wire                                    bpu_istaken2_o
);
reg  [`ysyx_22050058_InstAdderBus] pcdelay;
wire gshare_istaken1_w;
//wire gshare_istaken2_w;
wire btb_hit1_w;
//wire btb_hit2_w;
wire [`ysyx_22050058_InstAdderBus] bpu1hitaddr_w;
//wire [`ysyx_22050058_InstAdderBus] bpu2hitaddr_w;
wire [`ysyx_22050058_InstAdderBus] bpurastarget_w;
wire [2:0] btb_op_w;
always @(posedge clk ) begin
    if(rst)begin
        pcdelay <= `ysyx_22050058_ZeroWord;
    end else begin
        pcdelay <= bpu_fetchpc_i;
    end
end 
//wire [`ysyx_22050058_InstAdderBus]bpu_fetchpcplus4 = bpu_fetchpc_i +'h4;
ysyx_22050058_gshare ysyx_22050058_gshare_u0(
    .clk                (clk),
    .rst                (rst),
    .stall              (stall),
    .flush              (flush),
    // Interface with IF Stage
    .dec_jal               (dec_jal ),
    .dec_jalr              (dec_jalr),
    .dec_bxx              (dec_bxx),
    .gshare_pc1_i       (bpu_fetchpc_i),
    //.gshare_pc2_i       (bpu_fetchpcplus4),
    .gshare_btbhit_i    (btb_hit1_w),
    .gshare_bhr_o       (bpu_bhr_o),
    .gshare_pht_o       (bpu_pht_o),
    .gshare_istaken1_o  (gshare_istaken1_w),
    //.gshare_istaken2_o  (gshare_istaken2_w),
    .gshare_btbop_i     (btb_op_w),
    // Interface with EX Stage
    .exisjump_i         (exisjump_i),
    .bpu_exfixbhr_i     (bpu_exfixbhr_i),
    .gshare_prmiss_i    (bpu_prmiss_i),
    .gshare_prsuccessbutnotupdate_i (gshare_prsuccessbutnotupdate_i),
    .bpu_exrealbhr_i    (bpu_exrealbhr_i),
    // Interface with Commit Stage
    .gshare_wepht_i     (bpu_fixwe_i),
    .gshare_fixpht_i    (bpu_fixpht_i),    
    .bpu_fixbhr_i       (bpu_fixbhr_i),   
    .gshare_fixpc_i     (bpu_fixpc_i)    
);

ysyx_22050058_btb ysyx_22050058_btb_u0(
    .clk                (clk),
    .rst                (rst),
    .stall              (stall),
    // Interface with IF Stage
    .btb_pcdelay_i      (pcdelay),
    .btb_pc1_i          (bpu_fetchpc_i),
    //.btb_pc2_i          (bpu_fetchpcplus4),
    .btb_hit1_o         (btb_hit1_w),
    //.btb_hit2_o         (btb_hit2_w),
    .btb_hitaddr1_o     (bpu1hitaddr_w),
    //.btb_hitaddr2_o     (bpu2hitaddr_w),
    // Interface with Commit Stage   
    .btb_op_o            (btb_op_w),  //current addr's op output
    .btb_fixjumpaddr_i  (bpu_fixjumpaddr_i),
    .btb_fixjumpop_i    (btb_fixjumpop_i),
    .btb_fixwe_i        (btb_fixwe_i),
    .btb_fixpc_i        (bpu_fixpc_i)    
);
wire [31:0]pcdelayplus4 = pcdelay + 'h4;
//wire [31:0]pcdelayplus8 = pcdelay + 'h8;
ysyx_22050058_ras ysyx_22050058_ras_u0(
    .clk(clk),
    .rst(rst),
    .stall       (stall),
    .flush              (flush),
    .ras_jumpop_i(btb_op_w),
    .ras_btbhit_i(bpu1hit_o),
    .ras_btbhitaddr(pcdelayplus4),
    .ras_target_o(bpurastarget_w)
);
assign bpu_istaken1_o = gshare_istaken1_w;
//assign bpu_istaken2_o = gshare_istaken2_w;
assign bpu1hit_o      = gshare_istaken1_w && btb_hit1_w ;
//assign bpu2hit_o      = gshare_istaken2_w && btb_hit2_w ;


// assign bpu_istaken1_o = btb_hit1_w;
// assign bpu_istaken2_o = btb_hit2_w;
// assign bpu1hit_o      = btb_hit1_w ;
// assign bpu2hit_o      = btb_hit2_w ;
// assign bpu1hitaddr_o  = bpu1hitaddr_w ;
// assign bpu2hitaddr_o  = bpu2hitaddr_w;
// wire [63:0] pcdelayplus4 = pcdelay+'h4;
// always @(*) begin
//     if((!gshare_istaken1_w)&&(bpu1hitaddr_w!=pcdelayplus4)&&btb_hit1_w)begin
//         $display("this pc is %x btbpc is %x",pcdelay,bpu1hitaddr_w);
//     end
// end

// assign bpu1hitaddr_o  = gshare_istaken1_w ?  ((btb_op_w==`ysyx_22050058_BTB_RETOP && btb_hit1_w) ? bpurastarget_w : bpu1hitaddr_w) : pcdelay + 'h4;
// assign bpu2hitaddr_o  = gshare_istaken2_w ?  ((btb_op_w==`ysyx_22050058_BTB_RETOP && btb_hit2_w) ? bpurastarget_w : bpu2hitaddr_w) : pcdelay + 'h8;

assign bpu1hitaddr_o  = gshare_istaken1_w ?  (((btb_op_w==`ysyx_22050058_BTB_RETOP || btb_op_w==`ysyx_22050058_BTB_CALLANDRETOP) && btb_hit1_w) 
                                                                    ? bpurastarget_w : bpu1hitaddr_w) : bpu1hitaddr_w;
//assign bpu2hitaddr_o  = gshare_istaken2_w ?  (((btb_op_w==`ysyx_22050058_BTB_RETOP || btb_op_w==`ysyx_22050058_BTB_CALLANDRETOP) && btb_hit2_w) 
//                                                                    ? bpurastarget_w : bpu2hitaddr_w) : bpu2hitaddr_w;

endmodule
