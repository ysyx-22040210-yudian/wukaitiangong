 /*                                                                      
 Copyright 2018-2020 Nuclei System Technology, Inc.                
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
  Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */                                                                      
                                                                         
                                                                         
                                                                         
//=====================================================================
// Designer   : Bob Hu
//
// Description:
//  The Lite-BPU module to handle very simple branch predication at IFU
//
// ====================================================================
`include "e203_defines.v"

module e203_ifu_litebpu(

  // Current PC
  input  [`E203_PC_SIZE-1:0] pc,

  // The mini-decoded info 
  input  dec_jal,
  input  dec_jalr,
  input  dec_bxx,
  input  [`E203_XLEN-1:0] dec_bjp_imm,
  input  [`E203_RFIDX_WIDTH-1:0] dec_jalr_rs1idx,

  // The IR index and OITF status to be used for checking dependency
  input  oitf_empty,
  input  ir_empty,
  input  ir_rs1en,
  input  jalr_rs1idx_cam_irrdidx,  //如果为1，则ir上的rd寄存器与取指得到的jalr的rs1寄存器相同，也即会有发生raw相关性
  
  // The add op to next-pc adder
  output bpu_wait,  
  //*****************************new start********************************
//********************new from ex stage*************************
    input   wire                                    stall,
    input   wire                                    flush,
    // Interface with EX Stage
    input   wire                                    exisjump_i,
    input   wire                                    gshare_prsuccessbutnotupdate_i,
    input   wire                                    bpu_prmiss_i,
    input   wire    [`BHR_WIDTH-1:0]                bpu_exfixbhr_i,
    input   wire    [`BHR_WIDTH-1:0]                bpu_exrealbhr_i,
//*******************new from commit stage*************************
    input   wire                                    btb_fixwe_i,
    input   wire    [`BHR_WIDTH-1:0]                bpu_fixbhr_i,
    input   wire    [1:0]                           bpu_fixpht_i,
    input   wire    [`E203_PC_SIZE-1:0]             bpu_fixpc_i,
    input   wire    [`E203_PC_SIZE-1:0]             bpu_fixjumpaddr_i,
    input   wire                                    bpu_fixwe_i,
    input   wire     [2:0]                          btb_fixjumpop_i,

  //****************new send to IFU*************************
  output prdt_taken,  //送到ex阶段，用于判断是否预测正确
  input  [`E203_PC_SIZE-1:0]   bpu_fetchpc_i,      //nxt pc
  input  [`E203_PC_SIZE-1:0]   alu_cmt_pc,
  output                       bpu1hit_o,          //跳转且nxt pc在bpu1上命中低32位
  output [`E203_PC_SIZE-1:0]   bpu1hitaddr_o,      //跳转且nxt pc在bpu1上命中低32位，返回的跳转地址
  output [`BHR_WIDTH-1:0]    bpu_bhr_o,
  output [1:0]                 bpu_pht_o,
//****************************************new end********************************
 // output                       bpu_istaken1_o,     //送到ex阶段，用于判断是否预测正确
  //********************************new start******************************
  input  [`E203_OITF_DEPTH-1:0]   vld_r     , //
  input  [`E203_OITF_DEPTH-1:0]   rdwen_r,
  input  [`E203_RFIDX_WIDTH-1:0] rdidx_r0,
  input  [`E203_RFIDX_WIDTH-1:0] rdidx_r1,
  input  [`E203_RFIDX_WIDTH-1:0] rdidx_r2,
  input  [`E203_RFIDX_WIDTH-1:0] rdidx_r3,
//********************************new end *********************************--
  output [`E203_PC_SIZE-1:0] prdt_pc_add_op1,  
  output [`E203_PC_SIZE-1:0] prdt_pc_add_op2,

  input  dec_i_valid,

  // The RS1 to read regfile
  output bpu2rf_rs1_ena,
  input  ir_valid_clr,
  input  [`E203_XLEN-1:0] rf2bpu_x1,
  input  [`E203_XLEN-1:0] rf2bpu_rs1,

  input  clk,
  input  rst_n
  );

wire [`E203_RFIDX_WIDTH-1:0] rd_entry0 = {`E203_RFIDX_WIDTH{vld_r[0] & rdwen_r[0]}} & rdidx_r0;
wire [`E203_RFIDX_WIDTH-1:0] rd_entry1 = {`E203_RFIDX_WIDTH{vld_r[1] & rdwen_r[1]}} & rdidx_r1;
wire [`E203_RFIDX_WIDTH-1:0] rd_entry2 = {`E203_RFIDX_WIDTH{vld_r[2] & rdwen_r[2]}} & rdidx_r2;
wire [`E203_RFIDX_WIDTH-1:0] rd_entry3 = {`E203_RFIDX_WIDTH{vld_r[3] & rdwen_r[3]}} & rdidx_r3;

wire  bpu1hit_o1, bpu1hit_o2;
wire [31:0] bpu_fetchpc_i_r;
wire taken;
wire [`E203_PC_SIZE-1:0]   bpu1hitaddr_o1;

assign bpu_fetchpc_i_r = alu_cmt_pc >= 32'h80000008 ? bpu_fetchpc_i : 32'h80000008;
ysyx_22050058_bpu bpu(
    .clk              (clk),
    .rst              (!rst_n),
    .stall            (stall), //cache模式或者uncache模式下，或者instbuffer阻塞的时候，阻塞bpu
    .flush            (flush), //在mem或者ex阶段检测到是跳转指令的时候，为1 
    // Interface with EX Stage
    .exisjump_i       (exisjump_i), //在ex阶段判断是否是跳转指令
    .gshare_prsuccessbutnotupdate_i  (gshare_prsuccessbutnotupdate_i),    //预测跳转且执行的时候跳转，且预测的地址也一样，或者预测不跳转，实际也是不跳转指令
    .bpu_prmiss_i     (bpu_prmiss_i),       //等同flush 
    .bpu_exrealbhr_i  (bpu_exrealbhr_i), 
    .bpu_exfixbhr_i   (bpu_exfixbhr_i), //当前的BHR数值存入到icache中，四个周期拿回来
    // Interface with Commit Stage  
    .btb_fixwe_i      (btb_fixwe_i),  //写回阶段的时候，预测的是不跳转，但实际跳转
    .bpu_fixbhr_i     (bpu_fixbhr_i),//在icache最终存储四个周期之前的BHR数值，比bpu_exfixbhr_i慢了两个cycle
    .bpu_fixpht_i     (bpu_fixpht_i),       //在icache最终存储6个周期之前的PHT数值
    .bpu_fixpc_i      (bpu_fixpc_i),        //在icache最终存储6个周期之前的PC数值
    .bpu_fixjumpaddr_i(bpu_fixjumpaddr_i),  //在icache最终存储6个周期之前的跳转地址
    .bpu_fixwe_i      (bpu_fixwe_i),        //
    .btb_fixjumpop_i  (btb_fixjumpop_i),    //btb恢复跳转指令的类型
    // Interface with IF Stage..
    .dec_jal               (dec_jal ),
    .dec_jalr              (dec_jalr),
    .dec_bxx              (dec_bxx),
    .bpu_fetchpc_i    (bpu_fetchpc_i_r),      //nxt pc
    .bpu1hit_o        (bpu1hit_o1),          //跳转且nxt pc在bpu1上命中低32位
    .bpu1hitaddr_o    (bpu1hitaddr_o1),      //跳转且nxt pc在bpu1上命中低32位，返回的跳转地址
    .bpu_bhr_o        (bpu_bhr_o),
    .bpu_pht_o        (bpu_pht_o),
    .bpu_istaken1_o   (taken)
);

  // BPU of E201 utilize very simple static branch prediction logics
  //   * JAL: The target address of JAL is calculated based on current PC value
  //          and offset, and JAL is unconditionally always jump
  //   * JALR with rs1 == x0: The target address of JALR is calculated based on
  //          x0+offset, and JALR is unconditionally always jump
  //   * JALR with rs1 = x1: The x1 register value is directly wired from regfile
  //          when the x1 have no dependency with ongoing instructions by checking
  //          two conditions:
  //            ** (1) The OTIF in EXU must be empty 
  //            ** (2) The instruction in IR have no x1 as destination register
  //          * If there is dependency, then hold up IFU until the dependency is cleared
  //   * JALR with rs1 != x0 or x1: The target address of JALR need to be resolved
  //          at EXU stage, hence have to be forced halted, wait the EXU to be
  //          empty and then read the regfile to grab the value of xN.
  //          This will exert 1 cycle performance lost for JALR instruction
  //   * Bxxx: Conditional branch is always predicted as taken if it is backward
  //          jump, and not-taken if it is forward jump. The target address of JAL
  //          is calculated based on current PC value and offset

  // The JAL and JALR is always jump, bxxx backward is predicted as taken  
  assign bpu1hit_o2   = (dec_jal | dec_jalr | (dec_bxx & dec_bjp_imm[`E203_XLEN-1]));  

  //assign bpu1hit_o = alu_cmt_pc >= 32'h80000008 ? bpu1hit_o1 : bpu1hit_o2;
  assign bpu1hit_o = prdt_taken; //****************************************change
  assign prdt_taken = alu_cmt_pc >= 32'h80000008 ? taken : bpu1hit_o2;//taken : bpu1hit_o2;  ******************change
  // The JALR with rs1 == x1 have dependency or xN have dependency
  // 如果索引号是除了x0和x1以外的寄存器，那么不对其读寄存器数据进行特别的加速
  wire dec_jalr_rs1x0 = (dec_jalr_rs1idx == `E203_RFIDX_WIDTH'd0);
  wire dec_jalr_rs1x1 = (dec_jalr_rs1idx == `E203_RFIDX_WIDTH'd1);
  wire dec_jalr_rs1xn = (~dec_jalr_rs1x0) & (~dec_jalr_rs1x1);
//判定 xn 是否可能与 EXU 中的指令存在 在的 RAW 数据相关性，在两种情况下可能出现 RAW 相关性
// 1: OITF不为空，意昧着可能有长指令正在执行，其结果可能会写回 xn 当然也有可能
// 长指令写固的结果寄存籍不是 xn ，但是此处我们采取简单的保守估计 对于造成
// 的性能损失不在意 有关。ITF 和长指令的相关信息 请参见第 8.3.7
// 2: 在IR寄存器中存在指令, 意昧可能会写回 xn 当然也有可能该指令写回的结果寄
// 存器不是 xn ，但是此处我们采取简单的保守估计 不在意造成的性能损失

  //wire jalr_rs1x1_dep = dec_i_valid & dec_jalr & dec_jalr_rs1x1 & ((~oitf_empty) | (jalr_rs1idx_cam_irrdidx));
  //wire jalr_rs1xn_dep = dec_i_valid & dec_jalr & dec_jalr_rs1xn & ((~oitf_empty) | (~ir_empty));
  //*************************************new itof***********************************
  wire [`E203_OITF_DEPTH-1:0]  jalr_rs1_dep;
  wire jalr_oitfrd_match; //include x1
  assign jalr_rs1_dep[0] = dec_i_valid & dec_jalr & ((rd_entry0 == dec_jalr_rs1idx) | (jalr_rs1idx_cam_irrdidx));
  assign jalr_rs1_dep[1] = dec_i_valid & dec_jalr & ((rd_entry1 == dec_jalr_rs1idx) | (jalr_rs1idx_cam_irrdidx));
  assign jalr_rs1_dep[2] = dec_i_valid & dec_jalr & ((rd_entry2 == dec_jalr_rs1idx) | (jalr_rs1idx_cam_irrdidx));
  assign jalr_rs1_dep[3] = dec_i_valid & dec_jalr & ((rd_entry3 == dec_jalr_rs1idx) | (jalr_rs1idx_cam_irrdidx));

  assign jalr_oitfrd_match = (|jalr_rs1_dep) &  !dec_jalr_rs1x0;
  //************************************new end ****************************************

                      // If only depend to IR stage (OITF is empty), then if IR is under clearing, or
                          // it does not use RS1 index, then we can also treat it as non-dependency
//wire jalr_rs1xn_dep_ir_clr = (jalr_rs1xn_dep & oitf_empty & (~ir_empty)) & (ir_valid_clr | (~ir_rs1en));
  //***************************new start*******************************************/
 wire jalr_rs1xn_dep_ir_clr = (!(jalr_oitfrd_match & !dec_jalr_rs1x1) & (~ir_empty)) & (ir_valid_clr | (~ir_rs1en));
  //*****************************new end *****************************************//
// 需要征用 Regfile 的第 1 个端口从 Regfile 卖取 xn 的值，需要判断第 1 个读端口是否空
// 闲不存在资源冲突
// 如果没有资源冲突和数据冲突时，则将征用第1卖端口的便能置高
  wire rs1xn_rdrf_r;
  //wire rs1xn_rdrf_set = (~rs1xn_rdrf_r) & dec_i_valid & dec_jalr & dec_jalr_rs1xn & ((~jalr_rs1xn_dep) | jalr_rs1xn_dep_ir_clr);
  //**********************************new start******************************************************//
  wire rs1xn_rdrf_set = (~rs1xn_rdrf_r) & dec_i_valid & dec_jalr & dec_jalr_rs1xn & ((~(jalr_oitfrd_match & !dec_jalr_rs1x1)) | jalr_rs1xn_dep_ir_clr);
  //************************************new end***************************************************//
  wire rs1xn_rdrf_clr = rs1xn_rdrf_r;
  wire rs1xn_rdrf_ena = rs1xn_rdrf_set |   rs1xn_rdrf_clr;
  wire rs1xn_rdrf_nxt = rs1xn_rdrf_set | (~rs1xn_rdrf_clr);

  sirv_gnrl_dfflr #(1) rs1xn_rdrf_dfflrs(rs1xn_rdrf_ena, rs1xn_rdrf_nxt, rs1xn_rdrf_r, clk, rst_n);
//生成征用第 1个读端口的便能信号，该信号将加载和 IR 寄存器位于同一级的 rsl 索引( index ）寄存器
// 从而 卖取 Regfile
  assign bpu2rf_rs1_ena = rs1xn_rdrf_set;
// 如果存在着 xn RAW 相关性，贝lj bpu wait 拉高，不仅如此，在征用第 1卖端口的周期也会
// bpu wait 拉高 此信号将阻止 IFU 生成下一个町，直到相关性解除并且从 Regfile 中已经
// xn 的值
// 因此就性能 言，由于需要征用 Regfile 的第 个读端口渎职 xn 的值 即使没有数据相关性，
// 也需要最少等待 个周期
  //assign bpu_wait = jalr_rs1x1_dep | jalr_rs1xn_dep | rs1xn_rdrf_set;
  //**********************************new start******************************************************//
  wire jalr_hit = dec_jalr & bpu1hit_o1;
  assign bpu_wait = jalr_hit ? 1'b0 : (jalr_oitfrd_match | rs1xn_rdrf_set);//jalr_oitfrd_match | rs1xn_rdrf_set;
  wire [`E203_PC_SIZE-1:0] prdt_pc_add = prdt_pc_add_op1 + prdt_pc_add_op2;
  assign bpu1hitaddr_o = dec_jalr ? (jalr_hit ? bpu1hitaddr_o1 : prdt_pc_add) : ((dec_bxx | dec_jal) ? prdt_pc_add :  `E203_PC_SIZE'h80000000);
  //************************************new end***************************************************//

  assign prdt_pc_add_op1 = (dec_bxx | dec_jal) ? pc[`E203_PC_SIZE-1:0]
                         : (dec_jalr & dec_jalr_rs1x0) ? `E203_PC_SIZE'b0
                         : (dec_jalr & dec_jalr_rs1x1) ? rf2bpu_x1[`E203_PC_SIZE-1:0]
                         : rf2bpu_rs1[`E203_PC_SIZE-1:0];  

  assign prdt_pc_add_op2 = dec_bjp_imm[`E203_PC_SIZE-1:0];  

endmodule
