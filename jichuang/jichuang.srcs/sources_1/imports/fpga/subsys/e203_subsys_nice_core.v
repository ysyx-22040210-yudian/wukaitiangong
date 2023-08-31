/*
e203_subsys_nice_core模块为协处理模块，由E203的cpu模块驱动完成数据交互。
NICE模块的信号主要由CPU内部的三个模块处理，分为别：
(1)e203_ifu:取指令单元（取指令以及生成PC）
(2)e203_exu:执行单元(完成执行、存储操作，并提交写回）
(3)e203_lsu:存储器访问单元
nice_req_inst则主要涉及(1)(2)两个部分。
部分(1)：在e203_ifu模块中由e203_ifu_ifetch向e203_ifu_ift2icb发送PC地址来获得指令。随后e203_ifu_ift2icb通过ifu_rsp_instr信号回传指令。

随后e203_ifu_ifetch通过ifu_o_ir回传指令到e203_core.v中的e203_ifu模块。并同时传递给e203_exu模块的i_ir。e203_exu将其传递给e203_exu_alu的i_instr，并最终传递给e203_exu_nice模块，由该模块输出nice_req_inst信号指令给e203_subsys_nice_core协处理器。
*/
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
//
// Designer   : LZB
//
// Description:
//  The Module to realize a simple NICE core
//
// ====================================================================

`include "e203_defines.v"

`ifdef E203_HAS_NICE//{
module e203_subsys_nice_core (
    // System	
    input                         nice_clk             ,
    input                         nice_rst_n	          ,
    output                        nice_active	      ,
    output                        nice_mem_holdup	  ,
//    output                        nice_rsp_err_irq	  ,
    // Control cmd_req
    input                         nice_req_valid       , // 内核告诉nice有扩展指令进来（一切的开始），并且只持续一个时钟周期
    output                        nice_req_ready       , //在执行指令的时候会拉低，在其他时候会拉高，在刚得到扩展指令的时候与nice_req_valid同时为1，握手完成
    input  [`E203_XLEN-1:0]       nice_req_inst        , //扩展指令，nice_req_valid为1的时候那个脉冲时才有效
    input  [`E203_XLEN-1:0]       nice_req_rs1         , //扩展指令的rs1，与扩展指令nice_req_inst同周期
    input  [`E203_XLEN-1:0]       nice_req_rs2         , //扩展指令的rs2,与扩展指令nice_req_inst同周期
    // Control cmd_rsp	
    output                        nice_rsp_valid       , //执行完扩展指令后拉高，持续一个时钟周期
    input                         nice_rsp_ready       , //在执行指令的时候内核会把改信号拉高，其他时候拉低。在执行最后一个周期的时候与nice_rsp_valid同时为1，握手完成
    output [`E203_XLEN-1:0]       nice_rsp_rdat        , //在指令执行的时候，实时向内核返回当前计算数据，nice_rsp_valid为1的时候那个脉冲时才有效，也即会写回到内核的寄存器中 (这里仅仅只是写回寄存器中的实时指令输出结果的数据)//
    output                        nice_rsp_err    	  ,
    // Memory lsu_req	
    output                        nice_icb_cmd_valid   , //当前是idle状态，且当前派遣的指令是nice，并且是仿存的nice指令的时候。或者当前正在执行nice的仿存有关指令的时候，拉高，改信号为1的时候，仿存的地址才是有效的
    input                         nice_icb_cmd_ready   , //在nice指令执行期间恒为1
    output [`E203_ADDR_SIZE-1:0]  nice_icb_cmd_addr    , //nice指令的地址，在状态为IDLE的时候，并且当前是访存的nice指令的时候，会把nice指令的rs1对应寄存器中的值作为仿存地址，如果当前状态是正在执行nice指令的时候，仿存的地址由对应的指令控制，这里的是连续仿存连续的四个地址的数据  
    output                        nice_icb_cmd_read    , //只在写回存储器的时候拉低，其他任何时候都是拉高
    output [`E203_XLEN-1:0]       nice_icb_cmd_wdata   , //当前写回存储器的nice指令的时候，往存储器中写入的数据，这里的数据是连续写入的3个数据，其他情况都是0
//    output [`E203_XLEN_MW-1:0]     nice_icb_cmd_wmask   ,  // 
    output [1:0]                  nice_icb_cmd_size    , //恒为32位宽
    // Memory lsu_rsp	
    input                         nice_icb_rsp_valid   , //在lsu允许nice指令访存的时候，拉高，在为高电平期间可以对存储器读写数据
    output                        nice_icb_rsp_ready   , //恒为1
    input  [`E203_XLEN-1:0]       nice_icb_rsp_rdata   , //在lsu允许nice指令访存的时候，会把存储器中的数据读出来，在nice_icb_rsp_valid为1的时候，改数据才是有效的
    input                         nice_icb_rsp_err	

);

   reg  sm4_enable_in, encdec_enable_in, encdec_sel_in, valid_in, enable_key_exp_in, user_key_valid_in;
   wire  key_exp_ready_out, ready_out;
   reg  [127:0] data_in, user_key_in;
   wire [127:0] result_out;

   sm4_top sm4_acc(
      .clk		             ( nice_clk          ), 
      .reset_n	             ( nice_rst_n        ),   
      .sm4_enable_in        ( sm4_enable_in     ),
      .encdec_enable_in     ( encdec_enable_in  ),
      .encdec_sel_in        ( encdec_sel_in     ),
      .valid_in             ( valid_in          ),
      .data_in              ( data_in           ),
      .enable_key_exp_in    ( enable_key_exp_in ),
      .user_key_valid_in    ( user_key_valid_in ),
      .user_key_in          ( user_key_in       ),
      .key_exp_ready_out    ( key_exp_ready_out ),
      .ready_out            ( ready_out         ),
      .result_out           ( result_out        )
   );

   localparam DATA_WIDTH       = 2;
   localparam KEY_WIDTH        = 2;
   localparam KEY_NUM          = 4;
   localparam DATA_NUM         = 4;
   localparam KEY_EXP_BUF_SIZE = 32;
   localparam CHAR_WIDTH       = 8;
   /*localparam ROWBUF_DP = 4;
   localparam DATA_WIDTH = 2;
   localparam ROW_IDX_W = 2;
   localparam COL_IDX_W = 4;
   localparam PIPE_NUM = 3;*/


// here we only use custom3: 
// CUSTOM0 = 7'h0b, R type
// CUSTOM1 = 7'h2b, R tpye
// CUSTOM2 = 7'h5b, R type
// CUSTOM3 = 7'h7b, R type

// RISC-V format  
//	.insn r  0x33,  0,  0, a0, a1, a2       0:  00c58533[ 	]+add [ 	]+a0,a1,a2
//	.insn i  0x13,  0, a0, a1, 13           4:  00d58513[ 	]+addi[ 	]+a0,a1,13
//	.insn i  0x67,  0, a0, 10(a1)           8:  00a58567[ 	]+jalr[ 	]+a0,10 (a1)
//	.insn s   0x3,  0, a0, 4(a1)            c:  00458503[ 	]+lb  [ 	]+a0,4(a1)
//	.insn sb 0x63,  0, a0, a1, target       10: feb508e3[ 	]+beq [ 	]+a0,a1,0 target
//	.insn sb 0x23,  0, a0, 4(a1)            14: 00a58223[ 	]+sb  [ 	]+a0,4(a1)
//	.insn u  0x37, a0, 0xfff                18: 00fff537[ 	]+lui [ 	]+a0,0xfff
//	.insn uj 0x6f, a0, target               1c: fe5ff56f[ 	]+jal [ 	]+a0,0 target
//	.insn ci 0x1, 0x0, a0, 4                20: 0511    [ 	]+addi[ 	]+a0,a0,4
//	.insn cr 0x2, 0x8, a0, a1               22: 852e    [ 	]+mv  [ 	]+a0,a1
//	.insn ciw 0x0, 0x0, a1, 1               24: 002c    [ 	]+addi[ 	]+a1,sp,8
//	.insn cb 0x1, 0x6, a1, target           26: dde9    [ 	]+beqz[ 	]+a1,0 target
//	.insn cj 0x1, 0x5, target               28: bfe1    [ 	]+j   [ 	]+0 targe

   
   // decode
   
   wire [6:0] opcode      = {7{nice_req_valid}} & nice_req_inst[6:0]; //opcode是前7位
   wire [2:0] rv32_func3  = {3{nice_req_valid}} & nice_req_inst[14:12];//rv32_func3为{14->12}
   wire [6:0] rv32_func7  = {7{nice_req_valid}} & nice_req_inst[31:25];//rv32_func7为{31->25}

//   wire opcode_custom0 = (opcode == 7'b0001011); 
//   wire opcode_custom1 = (opcode == 7'b0101011); 
//   wire opcode_custom2 = (opcode == 7'b1011011); 
   wire opcode_custom3 = (opcode == 7'b1111011); //NICE使用了custom3型的RISC-V指令

   wire rv32_func3_000 = (rv32_func3 == 3'b000); //func3相关
   wire rv32_func3_001 = (rv32_func3 == 3'b001); 
   wire rv32_func3_010 = (rv32_func3 == 3'b010); 
   wire rv32_func3_011 = (rv32_func3 == 3'b011); 
   wire rv32_func3_100 = (rv32_func3 == 3'b100); 
   wire rv32_func3_101 = (rv32_func3 == 3'b101); 
   wire rv32_func3_110 = (rv32_func3 == 3'b110); 
   wire rv32_func3_111 = (rv32_func3 == 3'b111); 

   wire rv32_func7_0000000 = (rv32_func7 == 7'b0000000); //func7相关
   wire rv32_func7_0000001 = (rv32_func7 == 7'b0000001); 
   wire rv32_func7_0000010 = (rv32_func7 == 7'b0000010); 
   wire rv32_func7_0000011 = (rv32_func7 == 7'b0000011); 
   wire rv32_func7_0000100 = (rv32_func7 == 7'b0000100); 
   wire rv32_func7_0000101 = (rv32_func7 == 7'b0000101); 
   wire rv32_func7_0000110 = (rv32_func7 == 7'b0000110); 
   wire rv32_func7_0000111 = (rv32_func7 == 7'b0000111); 

   
   // custom3:
   // Supported format: only R type here
   // Supported instr:
   //  1. custom3 load_key: load key(in memory) to key_buf
   //     load_key (a1)
   //     .insn r opcode, func3, func7, rd, rs1, rs2    
   //  2. custom3 load_data: load data(in memory) to data_buf
   //     load_data (a2)
   //     .insn r opcode, func3, func7, rd, rs1, rs2    
   //  3. custom3 encrypt: encrypt data(@a2), Key extension and encryption
   //     encrypt rd, a2, x0
   //     .insn r opcode, func3, func7, rd, rs1, rs2    
   //  4. custom3 decrypt: decrypt data(@a2), Key extension and decryption
   //     decrypt rd, a2, x0
   //     .insn r opcode, func3, func7, rd, rs1, rs2
   //  5. custom3 sm4_res: store data(in data_buf) to memory
   //     sm4_res (a3)
   //     .insn r opcode, func3, func7, rd, rs1, rs2
   
   //定义三条自定义指令在custom3情况下与func3、func7的关系
   wire custom3_load_key     = opcode_custom3 & rv32_func3_010 & rv32_func7_0000001; //load_key读取rs1
   wire custom3_load_data    = opcode_custom3 & rv32_func3_010 & rv32_func7_0000010; //load_data读取rs1 
   wire custom3_encrypt      = opcode_custom3 & rv32_func3_110 & rv32_func7_0000110; //encrypt加密data数据，并进行key扩展
   wire custom3_decrypt      = opcode_custom3 & rv32_func3_110 & rv32_func7_0000111; //decrypt解密data数据，并进行key扩展
   wire custom3_sm4_res      = opcode_custom3 & rv32_func3_010 & rv32_func7_0000100; //sm4_res将data数据写回内存
   
   //  multi-cyc op 
   //定义两个信号，分别代表协处理器指令和需要访问memory
   wire custom_multi_cyc_op = custom3_load_key | custom3_load_data | custom3_encrypt | custom3_decrypt | custom3_sm4_res;
   // need access memory
   wire custom_mem_op = custom3_load_key | custom3_load_data | custom3_sm4_res;
 
   
   // NICE FSM ，NICE内部对指令的调度使用状态机，有四个状态，空闲和三个指令状态
   
   parameter NICE_FSM_WIDTH = 3; //初始化状态
   parameter IDLE     = 3'd0; 
   parameter LKEY     = 3'd1; 
   parameter LDATA    = 3'd2; 
   parameter ENCRYPT  = 3'd3; 
   parameter DECRYPT  = 3'd4;
   parameter SM4_RES  = 3'd5;

   //现态和次态
   wire [NICE_FSM_WIDTH-1:0] state_r;          //状态指针
   wire [NICE_FSM_WIDTH-1:0] nxt_state;        //下一状态
   wire [NICE_FSM_WIDTH-1:0] state_idle_nxt;   //下一状态为初始化IDLE
   wire [NICE_FSM_WIDTH-1:0] state_lkey_nxt;   //下一状态为load_key
   wire [NICE_FSM_WIDTH-1:0] state_ldata_nxt;  //下一状态为load_data
   wire [NICE_FSM_WIDTH-1:0] state_encrypt_nxt; //下一状态为encrypt
   wire [NICE_FSM_WIDTH-1:0] state_decrypt_nxt; //下一状态为decrypt
   wire [NICE_FSM_WIDTH-1:0] state_sm4_res_nxt; //下一状态为sm4_res
//------------------------------------------****************************************---------------------------------
   wire nice_req_hsked;    //与cpu握手信号，cpu发送指令 assign nice_req_hsked = nice_req_valid & nice_req_ready;//命令请求握手
   wire nice_rsp_hsked;    //与cpu握手信号，向cpu发送结果 assign nice_rsp_hsked = nice_rsp_valid & nice_rsp_ready; //命令响应握手
   wire nice_icb_rsp_hsked;//与memory握手信号   assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;//储存响应握手
   wire illgel_instr = ~(custom_multi_cyc_op);//为1，没有输入指令；illgel_instr为0代表是协处理器指令，为1代表不是
     
   //定义状态离开使能信号，四个状态的和真实状态的，共5个
   wire state_idle_exit_ena;  //退出初始化状态使能
   wire state_lkey_exit_ena;  //退出lkey状态使能 
   wire state_ldata_exit_ena;  //退出ldata状态使能  
   wire state_encrypt_exit_ena;//退出encrypt状态使能
   wire state_decrypt_exit_ena;//退出decrypt状态使能
   wire state_sm4_res_exit_ena;//退出sm4_res状态使能
   wire state_ena;            //状态使能

   //定义现在是什么状态的四个信号
   wire state_is_idle     = (state_r == IDLE);  //state是idle时，当前状态是初始化
   wire state_is_lkey     = (state_r == LKEY);  //state是lkey时，当前状态是lkey状态 
   wire state_is_ldata    = (state_r == LDATA);  //state是ldata时，当前状态是ldata状态
   wire state_is_encrypt  = (state_r == ENCRYPT);//state是encrypt时，当前状态是encrypt状态
   wire state_is_decrypt  = (state_r == DECRYPT);//state是decrypt时，当前状态是decrypt状态
   wire state_is_sm4_res  = (state_r == SM4_RES);//state是sm4_res时，当前状态是sm4_res状态
   
   //状态转换
   //当前状态是初始化状态，且cpu请求握手成功，且当前没有指令在操作，则退出初始化状态，开始进入加速器指令状态 
   //给状态离开使能信号赋值，当现态为IDLE，并且（nice_req_hsked)，并且当前为5指令之一，state_idle_exit_ena为高
   assign state_idle_exit_ena = state_is_idle & nice_req_hsked & ~illgel_instr; 
   //判断初始化状态的下一个状态，输入指令是lbuf，进入LBUF状态。。。否则保持初始化。三个指令状态的次态，都为IDLE
   assign state_idle_nxt =  custom3_load_key    ? LKEY   : 
                            custom3_load_data   ? LDATA  :
                            custom3_encrypt     ? ENCRYPT:
                            custom3_decrypt     ? DECRYPT:
                            custom3_sm4_res     ? SM4_RES:
			    IDLE;

   wire lkey_icb_rsp_hsked_last;//lkey操作结束信号 
   //当前状态是lkey，lkey操作完成，则退出lkey状态使能为1
   assign state_lkey_exit_ena = state_is_lkey & lkey_icb_rsp_hsked_last; //传输完最后一个数据的时候，退出lkey状态
   //现态为lkey，并且(lkey_icb_rsp_hsked_last)，state_lkey_exit_ena为高
   assign state_lkey_nxt = IDLE;//lkey下一状态是idle，以下类似
   wire   ldata_icb_rsp_hsked_last; 
   assign state_ldata_exit_ena = state_is_ldata & ldata_icb_rsp_hsked_last; //传输完最后一个数据的时候，退出ldata状态
   assign state_ldata_nxt = IDLE;
   wire   encrypt_done; //encrypt操作结束信号
   assign state_encrypt_exit_ena = state_is_encrypt & encrypt_done; //加密结束，退出encrypt状态
   assign state_encrypt_nxt = IDLE;
   wire   decrypt_done; //decrypt操作结束信号
   assign state_decrypt_exit_ena = state_is_decrypt & decrypt_done; //解密结束，退出decrypt状态
   assign state_decrypt_nxt = IDLE;
   wire   res_icb_rsp_hsked_last; //sm4_res操作结束信号
   assign state_sm4_res_exit_ena = state_is_sm4_res & res_icb_rsp_hsked_last; //传输完最后一个数据的时候，退出sm4_res状态
   assign state_sm4_res_nxt = IDLE;

   //次态赋值，当退出相应操作结束时状态使能为1时，下一个状态切换至IDLE初始化
   assign nxt_state =   ({NICE_FSM_WIDTH{state_idle_exit_ena   }} & state_idle_nxt   )
                      | ({NICE_FSM_WIDTH{state_lkey_exit_ena   }} & state_lkey_nxt   ) 
                      | ({NICE_FSM_WIDTH{state_ldata_exit_ena  }} & state_ldata_nxt  ) 
                      | ({NICE_FSM_WIDTH{state_encrypt_exit_ena}} & state_encrypt_nxt)
                      | ({NICE_FSM_WIDTH{state_decrypt_exit_ena}} & state_decrypt_nxt)
                      | ({NICE_FSM_WIDTH{state_sm4_res_exit_ena}} & state_sm4_res_nxt) 
                      ;
   //状态转换使能，为四个使能的或。当退出相应操作使能为1时，将状态使能置为1
   assign state_ena =   state_idle_exit_ena   | state_lkey_exit_ena 
                      | state_ldata_exit_ena  | state_encrypt_exit_ena
                      | state_decrypt_exit_ena| state_sm4_res_exit_ena;

   //时序状态机，调用sirv_gnrl_dfflr，D触发器，实现状态机
   //该模块是一个buffer，当状态切换至使能为1时，输入下一个状态，打一拍后从state_r输出
   sirv_gnrl_dfflr #(NICE_FSM_WIDTH)   state_dfflr (state_ena, nxt_state, state_r, nice_clk, nice_rst_n);

   
   // instr EXU
   // LOAD KEY
   wire [KEY_WIDTH-1:0]  key_size = 2'd3;  // key的字节数目
   wire [DATA_WIDTH-1:0] data_size= 2'd3;        // key的计数器
   //wire [COL_IDX_W-1:0]  rownum;

   wire  nice_rsp_valid_enc; //加密结束信号
   wire  nice_rsp_valid_dec; //解密结束信号
   //只有这个指令的结束信号输出的时候，处理器那边才能完成指令完成的握手，进而才能接收下一条指令。这个信号很重要
   assign nice_rsp_valid_enc = state_is_encrypt & encrypt_done; //加密结束，输出加密结束信号
   assign nice_rsp_valid_dec = state_is_decrypt & decrypt_done; //解密结束，输出解密结束信号
   // 1. custom3_lkey
   ///这里是一个lkey的计数器
   wire [KEY_WIDTH-1:0] lkey_cnt_r;      //现在计数值,16个
   wire [KEY_WIDTH-1:0] lkey_cnt_nxt;    //下一个计数值
   wire lkey_cnt_clr;                    //计数清零，使能
   wire lkey_cnt_incr;                   //计数增加，使能
   wire lkey_cnt_ena;                    //计数，D触发器，使能
   wire lkey_cnt_last;                   //计数到最后值
   wire lkey_icb_rsp_hsked;              //状态机为lkey，并且储存响应握手成功
   wire nice_rsp_valid_lkey;             //状态机为lkey，计数到最后值，E203发出储存响应信号
   wire nice_icb_cmd_valid_lkey;         //状态机为lkey，计数值小于最后值

   //信号赋值
   //已知assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;并且nice_icb_rsp_ready is 1'b1 always，所以nice_icb_rsp_hsked = nice_icb_rsp_valid
   assign lkey_icb_rsp_hsked = state_is_lkey & nice_icb_rsp_hsked; //当前状态为lkey，储存响应握手
   assign lkey_icb_rsp_hsked_last = lkey_icb_rsp_hsked & lkey_cnt_last; //，当前状态为lkey，储存响应握手，计数为最后值
   assign lkey_cnt_last = (lkey_cnt_r == key_size); //即计数到最后值，也就是lkey_cnt_r为5'd15
   //已知assign nice_req_hsked = nice_req_valid & nice_req_ready;所以lbuf_cnt_clr含义为当前指令为lkey，命令请求握手
   assign lkey_cnt_clr = custom3_load_key & nice_req_hsked;
   assign lkey_cnt_incr= lkey_icb_rsp_hsked & ~lkey_cnt_last;//当前状态为lkey，储存响应握手，计数值不是最后值
   assign lkey_cnt_ena = lkey_cnt_clr | lkey_cnt_incr;//当前指令为lkey，命令请求握手；或者当前状态lkey，储存指令握手，计数值不是最后值
   //当前指令lkey，命令请求握手，lkey_cnt_nxt归零；当前状态lkey，储存响应握手，计数值不是最后值，lkey_cnt_nxt为lkey_cnt_r+1
   assign lkey_cnt_nxt =   ({KEY_WIDTH{lkey_cnt_clr }} & {KEY_WIDTH{1'b0}})
                         | ({KEY_WIDTH{lkey_cnt_incr}} & (lkey_cnt_r + 1'b1))
                         ;
   //D触发器构成时序计数器，时钟：nice_clk ; 复位信号：nice_rst_n ; 使能信号：lkey_cnt_ena ;，输入数据lkey_cnt_nxt ； 输出数据：lkey_cnt_r
   sirv_gnrl_dfflr #(KEY_WIDTH)   lkey_cnt_dfflr (lkey_cnt_ena, lkey_cnt_nxt, lkey_cnt_r, nice_clk, nice_rst_n);

   // nice_rsp_valid wait for nice_icb_rsp_valid in LBUF
   assign nice_rsp_valid_lkey = state_is_lkey & lkey_cnt_last & nice_icb_rsp_valid;//当前状态为lkey，计数值为最后值，E203发出储存响应信号

   // nice_icb_cmd_valid sets when lkey_cnt_r is not full in LOAD_KEY_BUF
   assign nice_icb_cmd_valid_lkey = (state_is_lkey & (lkey_cnt_r < key_size));//当前状态为lkey，且现计数值小于最后值

   // LOAD DATA
   // 2. custom3_ldata
   ///这里是一个ldata的计数器
   wire [DATA_WIDTH-1:0] ldata_cnt_r;      //现在计数值,16个
   wire [DATA_WIDTH-1:0] ldata_cnt_nxt;    //下一个计数值
   wire ldata_cnt_clr;                    //计数清零，使能
   wire ldata_cnt_incr;                   //计数增加，使能
   wire ldata_cnt_ena;                    //计数，D触发器，使能
   wire ldata_cnt_last;                   //计数到最后值
   wire ldata_icb_rsp_hsked;              //状态机为ldata，并且储存响应握手成功
   wire nice_rsp_valid_ldata;             //状态机为ldata，计数到最后值，E203发出储存响应信号
   wire nice_icb_cmd_valid_ldata;         //状态机为ldata，计数值小于最后值

   //信号赋值
   //已知assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;并且nice_icb_rsp_ready is 1'b1 always，所以nice_icb_rsp_hsked = nice_icb_rsp_valid
   assign ldata_icb_rsp_hsked = state_is_ldata & nice_icb_rsp_hsked; //当前状态为ldata，储存响应握手
   assign ldata_icb_rsp_hsked_last = ldata_icb_rsp_hsked & ldata_cnt_last; //，当前状态为ldata，储存响应握手，计数为最后值
   assign ldata_cnt_last = (ldata_cnt_r == data_size); //即计数到最后值，也就是ldata_cnt_r为5'd15
   //已知assign nice_req_hsked = nice_req_valid & nice_req_ready;所以lbuf_cnt_clr含义为当前指令为ldata，命令请求握手
   assign ldata_cnt_clr = custom3_load_data & nice_req_hsked;
   assign ldata_cnt_incr= ldata_icb_rsp_hsked & ~ldata_cnt_last;//当前状态为ldata，储存响应握手，计数值不是最后值
   assign ldata_cnt_ena = ldata_cnt_clr | ldata_cnt_incr;//当前指令为ldata，命令请求握手；或者当前状态ldata，储存指令握手，计数值不是最后值
   //当前指令ldata，命令请求握手，ldata_cnt_nxt归零；当前状态ldata，储存响应握手，计数值不是最后值，ldata_cnt_nxt为ldata_cnt_r+1
   assign ldata_cnt_nxt =   ({DATA_WIDTH{ldata_cnt_clr }} & {DATA_WIDTH{1'b0}})
                         | ({DATA_WIDTH{ldata_cnt_incr}} & (ldata_cnt_r + 1'b1))
                         ;
   //D触发器构成时序计数器，时钟：nice_clk ; 复位信号：nice_rst_n ; 使能信号：ldata_cnt_ena ;，输入数据ldata_cnt_nxt ； 输出数据：ldata_cnt_r
   sirv_gnrl_dfflr #(DATA_WIDTH)   ldata_cnt_dfflr (ldata_cnt_ena, ldata_cnt_nxt, ldata_cnt_r, nice_clk, nice_rst_n);

   // nice_rsp_valid wait for nice_icb_rsp_valid in LBUF
   assign nice_rsp_valid_ldata = state_is_ldata & ldata_cnt_last & nice_icb_rsp_valid;//当前状态为ldata，计数值为最后值，E203发出储存响应信号

   // nice_icb_cmd_valid sets when ldata_cnt_r is not full in LOAD_DATA_BUF
   assign nice_icb_cmd_valid_ldata = (state_is_ldata & (ldata_cnt_r < data_size));//当前状态为ldata，且现计数值小于最后值

   // 3. custom3_sm4_res
   //cmd信号是给存储器传输地址和wdata的，rsp信号是从存储器读写取数据的，所以cmd信号要比rsp信号提前一拍，但是最终一起结束
   wire [DATA_WIDTH-1:0] res_cnt_r;   //当前计数值
   wire [DATA_WIDTH-1:0] res_cnt_nxt; //下个计数值
   wire res_cnt_clr;
   wire res_cnt_incr;                   //res_cnt增加，使能
   wire res_cnt_ena;                    //D触发器，使能
   wire res_cnt_last;                   //当前计数值为最后值
   wire res_icb_cmd_hsked;              //当前状态为res，或(状态为IDLE且指令为res)，储存握手成功
   wire res_icb_rsp_hsked;              //当前状态为res，储存响应握手成功
   wire nice_rsp_valid_res;             //状态机为res，计数到最后值，E203发出储存响应信号
   wire nice_icb_cmd_valid_res;         //状态为res，res_cmd_cnt_r小于等于最后值，res_cnt不是最后值
   wire nice_icb_cmd_hsked;              //储存请求握手成功

   // -------------------------------------------------------
   // -- 对存储器写操作反馈信号的计数
   // -------------------------------------------------------
   //assign nice_icb_cmd_hsked = nice_icb_cmd_valid & nice_icb_cmd_ready;   //储存请求握手
   assign res_icb_cmd_hsked = (state_is_sm4_res | (state_is_idle & custom3_sm4_res)) & nice_icb_cmd_hsked;//当前状态为res，或（idle状态指令为res)，储存请求握手成功
   //  assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;//储存响应握手
   assign res_icb_rsp_hsked = state_is_sm4_res & nice_icb_rsp_hsked;//当前状态res，储存响应握手
   assign res_icb_rsp_hsked_last = res_icb_rsp_hsked & res_cnt_last;//当前状态res，储存响应握手，计数值为最后值
   assign res_cnt_last = (res_cnt_r == data_size);//计数值为最后值
   //assign res_cnt_clr = custom3_res & nice_req_hsked;
   assign res_cnt_clr = res_icb_rsp_hsked_last;//就是res_icb_rsp_hsked_last，当前状态res，储存响应握手，计数值为最后值
   assign res_cnt_incr = res_icb_rsp_hsked & ~res_cnt_last;//当前状态res，储存响应握手，计数值不是最后值
   assign res_cnt_ena = res_cnt_clr | res_cnt_incr; //当前状态res，储存响应握手、
   //当前状态res，储存响应握手，（计数值为最后值则为2'b00；否则为现在计数值+1）
   assign res_cnt_nxt =   ({DATA_WIDTH{res_cnt_clr }} & {DATA_WIDTH{1'b0}})
                         | ({DATA_WIDTH{res_cnt_incr}} & (res_cnt_r + 1'b1))
                         ;
   //D触发器构成时序计数器
   sirv_gnrl_dfflr #(DATA_WIDTH)   res_cnt_dfflr (res_cnt_ena, res_cnt_nxt, res_cnt_r, nice_clk, nice_rst_n);

   // nice_rsp_valid wait for nice_icb_rsp_valid in SBUF
   //当前状态res，计数值为最后值，E203发出储存响应信号
   assign nice_rsp_valid_res = state_is_sm4_res & res_cnt_last & nice_icb_rsp_valid;
   
   //res_cmd计数器
   // -------------------------------------------------------
   // -- 对存储器写操作命令信号的计数
   // -------------------------------------------------------
   wire [DATA_WIDTH-1:0] res_cmd_cnt_r;  //res_cmd现计数值
   wire [DATA_WIDTH-1:0] res_cmd_cnt_nxt;//res_cmd下个计数值 
   wire res_cmd_cnt_clr;                   //当前状态res，储存响应握手，res计数值为最后值
   wire res_cmd_cnt_incr;                  //当前状态为res，或（idle状态指令为res)，储存请求握手成功，subf_cmd计数值不是最后值
   wire res_cmd_cnt_ena;                   //（当前状态res，储存响应握手，res计数值为最后值）或（当前状态为res，或（idle状态指令为res)，储存请求握手成功，subf_cmd计数值不是最后值）
   wire res_cmd_cnt_last;                  //res_cmd计数值为最后值

   assign res_cmd_cnt_last = (res_cmd_cnt_r == data_size); //res_cmd计数值为最后值
   assign res_cmd_cnt_clr  = res_icb_rsp_hsked_last;     //当前状态res，储存响应握手，res计数值为最后值
   assign res_cmd_cnt_incr = res_icb_cmd_hsked & ~res_cmd_cnt_last;//当前状态为res，或（idle状态指令为res)，储存请求握手成功，subf_cmd计数值不是最后值
   assign res_cmd_cnt_ena = res_cmd_cnt_clr | res_cmd_cnt_incr;//（当前状态res，储存响应握手，res计数值为最后值）或（当前状态为res，或（idle状态指令为res)，储存请求握手成功，subf_cmd计数值不是最后值）
   //当前状态res，储存响应握手，res计数为最后值，为2'b00；当前状态为res，或（idle状态指令为res)，储存请求握手成功，res_cmd计数值不是最后值，为res_cmd_cnt_r+1
   assign res_cmd_cnt_nxt =   ({DATA_WIDTH{res_cmd_cnt_clr }} & {DATA_WIDTH{1'b0}})
                             | ({DATA_WIDTH{res_cmd_cnt_incr}} & (res_cmd_cnt_r + 1'b1) );
   
   //D触发器构成时序计数器                          ;
   sirv_gnrl_dfflr #(DATA_WIDTH)   res_cmd_cnt_dfflr (res_cmd_cnt_ena, res_cmd_cnt_nxt, res_cmd_cnt_r, nice_clk, nice_rst_n);

   // nice_icb_cmd_valid sets when res_cmd_cnt_r is not full in SBUF
   //当前状态res，res_cmd小于等于最后值，res不等于最后值
   assign nice_icb_cmd_valid_res = (state_is_sm4_res & (res_cmd_cnt_r <= data_size) & (res_cnt_r != data_size));
//-------------------------------------------------------*****************************************-----------------------

   // 3. custom3_rowsum
   // rowbuf counter 
   wire [DATA_WIDTH-1:0] rowbuf_cnt_r; 
   wire [DATA_WIDTH-1:0] rowbuf_cnt_nxt; 
   wire rowbuf_cnt_clr;
   wire rowbuf_cnt_incr;
   wire rowbuf_cnt_ena;
   wire rowbuf_cnt_last;
   wire rowbuf_icb_rsp_hsked;
   wire rowbuf_rsp_hsked;
   wire nice_rsp_valid_rowsum;

   //信号赋值
//   assign rowbuf_rsp_hsked = nice_rsp_valid_rowsum & nice_rsp_ready;
//   assign rowbuf_icb_rsp_hsked = state_is_rowsum & nice_icb_rsp_hsked;
//   assign rowbuf_cnt_last = (rowbuf_cnt_r == clonum);
//   assign rowbuf_cnt_clr = rowbuf_icb_rsp_hsked & rowbuf_cnt_last;
//   assign rowbuf_cnt_incr = rowbuf_icb_rsp_hsked & ~rowbuf_cnt_last;
//   assign rowbuf_cnt_ena = rowbuf_cnt_clr | rowbuf_cnt_incr;
//   assign rowbuf_cnt_nxt =   ({DATA_WIDTH{rowbuf_cnt_clr }} & {DATA_WIDTH{1'b0}})
//                           | ({DATA_WIDTH{rowbuf_cnt_incr}} & (rowbuf_cnt_r + 1'b1))
//                           ;
   //assign nice_icb_cmd_valid_rowbuf =   (state_is_idle & custom3_rowsum)
   //                                  | (state_is_rowsum & (rowbuf_cnt_r <= clonum) & (clonum != 0))
   //                                  ;

   //D触发器构成时序计数器
//   sirv_gnrl_dfflr #(DATA_WIDTH)   rowbuf_cnt_dfflr (rowbuf_cnt_ena, rowbuf_cnt_nxt, rowbuf_cnt_r, nice_clk, nice_rst_n);
  
   //rowsum的recieve data buffer
   // recieve data buffer, to make sure rowsum ops come from registers 
   wire rcv_data_buf_ena;
   wire rcv_data_buf_set;
   wire rcv_data_buf_clr;
   wire rcv_data_buf_valid;
   wire [`E203_XLEN-1:0] rcv_data_buf; 
   wire [DATA_WIDTH-1:0] rcv_data_buf_idx; 
   wire [DATA_WIDTH-1:0] rcv_data_buf_idx_nxt; 

   //信号赋值
//   assign rcv_data_buf_set = rowbuf_icb_rsp_hsked;
//   assign rcv_data_buf_clr = rowbuf_rsp_hsked;
//   assign rcv_data_buf_ena = rcv_data_buf_clr | rcv_data_buf_set;
//   assign rcv_data_buf_idx_nxt =   ({DATA_WIDTH{rcv_data_buf_clr}} & {DATA_WIDTH{1'b0}})
//                                 | ({DATA_WIDTH{rcv_data_buf_set}} & rowbuf_cnt_r      );
//
//   //D触发器构成时序计数器，第一个是使能信号的一个时钟延迟，第二个是输入数据的缓冲，第三个是对rowbuf写入的序号
//   sirv_gnrl_dfflr #(1)       rcv_data_buf_valid_dfflr (1'b1, rcv_data_buf_ena, rcv_data_buf_valid, nice_clk, nice_rst_n);
//   sirv_gnrl_dfflr #(`E203_XLEN)   rcv_data_buf_dfflr (rcv_data_buf_ena, nice_icb_rsp_rdata, rcv_data_buf, nice_clk, nice_rst_n);
//   sirv_gnrl_dfflr #(DATA_WIDTH)   rowbuf_cnt_d_dfflr (rcv_data_buf_ena, rcv_data_buf_idx_nxt, rcv_data_buf_idx, nice_clk, nice_rst_n);
//
   // rowsum的累加器模块
   // rowsum accumulator 
   wire [`E203_XLEN-1:0] rowsum_acc_r;
   wire [`E203_XLEN-1:0] rowsum_acc_nxt;
   wire [`E203_XLEN-1:0] rowsum_acc_adder;
   wire rowsum_acc_ena;
   wire rowsum_acc_set;
   wire rowsum_acc_flg;
   wire nice_icb_cmd_valid_rowsum;
   wire [`E203_XLEN-1:0] rowsum_res;

   //rowsum的累加，信号赋值
   //rowsum_acc_flg，rcv_data_buf_idx非零，且上个周期的状态为rowsum时（储存响应握手或E203发出nice_rsp_ready信号）
//   assign rowsum_acc_set = rcv_data_buf_valid & (rcv_data_buf_idx == {DATA_WIDTH{1'b0}});//32'b0
//   assign rowsum_acc_flg = rcv_data_buf_valid & (rcv_data_buf_idx != {DATA_WIDTH{1'b0}});
//   assign rowsum_acc_adder = rcv_data_buf + rowsum_acc_r;/**************最重要的加法运算；assign <寄存器类型变量> = <赋值表达式>；****/
//   assign rowsum_acc_ena = rowsum_acc_set | rowsum_acc_flg;
//   assign rowsum_acc_nxt =   ({`E203_XLEN{rowsum_acc_set}} & rcv_data_buf)
//                           | ({`E203_XLEN{rowsum_acc_flg}} & rowsum_acc_adder)
//                           ;
//   //D触发器构成时序，累加的时序操作
//   sirv_gnrl_dfflr #(`E203_XLEN)   rowsum_acc_dfflr (rowsum_acc_ena, rowsum_acc_nxt, rowsum_acc_r, nice_clk, nice_rst_n);
//
//   assign rowsum_done = state_is_rowsum & nice_rsp_hsked;
//   assign rowsum_res  = rowsum_acc_r;  //rowsum finishes when the last acc data is added to rowsum_acc_r  
//
//   // nice_icb_cmd_valid sets when rcv_data_buf_idx is not full in LBUF 
//   assign nice_rsp_valid_rowsum = state_is_rowsum & (rcv_data_buf_idx == clonum) & ~rowsum_acc_flg;
//
//   // nice_icb_cmd_valid sets when rcv_data_buf_idx is not full in LBUF
//   assign nice_icb_cmd_valid_rowsum = state_is_rowsum & (rcv_data_buf_idx < clonum) & ~rowsum_acc_flg;
//--------------------------------------------------------------*****************************************------------------------------------------

   // keybuf，keybuf是数据缓存，lkey会写入
   // rowbuf access list:
   //  1. lkey will write to keybuf, write data comes from memory, data length is defined by key_size
   //  2. ldata will read from databuf, and store it to memory, data length is defined by data_size
   //  2. sbuf will read from rowbuf, and store it to memory, data length is defined by clonum 
   //  3. rowsum will accumulate data, and store to rowbuf, data length is defined by clonum 
   wire [`E203_XLEN-1:0] keybuf_r    [KEY_NUM-1:0]; //4个32位的数据
   wire [`E203_XLEN-1:0] keybuf_wdat [KEY_NUM-1:0];//4个32位的数据
   wire [KEY_NUM-1:0]    keybuf_we;                  //4位宽的数据
   wire [KEY_WIDTH-1:0]  keybuf_idx_mux;             //keybuf的序号选择
   wire [`E203_XLEN-1:0] keybuf_wdat_mux;            //keybuf的写入数据选择
   wire keybuf_wr_mux;                               //keybuf的写入信号选择
   //wire [DATA_WIDTH-1:0] sbuf_idx; 
   
   // lkey write to keybuf
   wire [DATA_WIDTH-1:0] lkey_idx = lkey_cnt_r;            //lkey写入的序号，写入序号选择，为lkey_cnt_r，即lkey计数的时序输出，当前的计数值，从0到2
   wire lkey_wr = lkey_icb_rsp_hsked;                      //lkey写入的使能，写入使能，为lkey_icb_rsp_hsked，即当前状态为lkey，储存响应握手
   wire [`E203_XLEN-1:0] lkey_wdata = nice_icb_rsp_rdata;  //lkey写入的数据，写入数据，外部输入的从memory读取的数据

   // rowsum write to rowbuf(column accumulated data)
 /*  wire [DATA_WIDTH-1:0] rowsum_idx = rcv_data_buf_idx;  //rowsum写入的序号，写入序号选择，为rcv_data_buf_idx，当前的计数值，从0到2
   wire rowsum_wr = rcv_data_buf_valid;                    //rowsum写入的使能，写入使能，为rcv_data_buf-valid，是rcv_data_buf_ena缓冲一个时钟
   wire [`E203_XLEN-1:0] rowsum_wdata = rowbuf_r[rowsum_idx] + rcv_data_buf; //	rowsum写入的数据，写入数据，为rowbuf_r当前数据与rcv_data_buf的加和*/

   // rowbuf write mux
   //写入数据选择
   assign keybuf_wdat_mux =   ({`E203_XLEN{lkey_wr  }} & lkey_wdata  );
                           /* | ({`E203_XLEN{rowsum_wr}} & rowsum_wdata)
                            ;*/
   //写入使能选择，lkey_wr
   assign keybuf_wr_mux   =  lkey_wr;// | rowsum_wr;
   //写入序号选择，若lkey_wr为高，则为lkey_idx
   assign keybuf_idx_mux  =   ({DATA_WIDTH{lkey_wr  }} & lkey_idx  );
                           /* | ({DATA_WIDTH{rowsum_wr}} & rowsum_idx)
                            ;  */
   
   //D触发器构成时序///
   //实例化16个输入的8位的D触发器
   // keybuf inst
   genvar i;
   generate 
     for (i=0; i<KEY_NUM; i=i+1) begin:gen_keybuf
       //keybuf_we为使能信号，为keybuf_wr_mux与一个表达式的与，i的低2位与rowbuf_idx_mux相等才可以
       assign keybuf_we[i] =   (keybuf_wr_mux & (keybuf_idx_mux == i[DATA_WIDTH-1:0]))
                             ;
       //keybuf_wdat为输入数据，使能时为keybuf_wdat_mux
       assign keybuf_wdat[i] =   ({`E203_XLEN{keybuf_we[i]}} & keybuf_wdat_mux   )
                               ;
  
       sirv_gnrl_dfflr #(`E203_XLEN) keybuf_dfflr (keybuf_we[i], keybuf_wdat[i], keybuf_r[i], nice_clk, nice_rst_n);
     end
   endgenerate

//ldata write to databuf
   wire [`E203_XLEN-1:0] databuf_r    [DATA_NUM-1:0]; //4个32位的数据
   wire [`E203_XLEN-1:0] databuf_wdat [DATA_NUM-1:0];//4个32位的数据
   wire [DATA_NUM-1:0]    databuf_we;                  //4位宽的数据
   wire [DATA_WIDTH-1:0]  databuf_idx_mux;             //databuf的序号选择
   wire [`E203_XLEN-1:0] databuf_wdat_mux;            //databuf的写入数据选择
   wire databuf_wr_mux;                               //databuf的写入信号选择
   //wire [DATA_WIDTH-1:0] sbuf_idx; 
   
   // ldata write to databuf
   wire [DATA_WIDTH-1:0] ldata_idx = ldata_cnt_r;            //ldata写入的序号，写入序号选择，为ldata_cnt_r，即ldata计数的时序输出，当前的计数值，从0到2
   wire ldata_wr = ldata_icb_rsp_hsked;                      //ldata写入的使能，写入使能，为ldata_icb_rsp_hsked，即当前状态为ldata，储存响应握手
   wire [`E203_XLEN-1:0] ldata_wdata = nice_icb_rsp_rdata;  //ldata写入的数据，写入数据，外部输入的从memory读取的数据

   // rowsum write to rowbuf(column accumulated data)
 /*  wire [DATA_WIDTH-1:0] rowsum_idx = rcv_data_buf_idx;  //rowsum写入的序号，写入序号选择，为rcv_data_buf_idx，当前的计数值，从0到2
   wire rowsum_wr = rcv_data_buf_valid;                    //rowsum写入的使能，写入使能，为rcv_data_buf-valid，是rcv_data_buf_ena缓冲一个时钟
   wire [`E203_XLEN-1:0] rowsum_wdata = rowbuf_r[rowsum_idx] + rcv_data_buf; //	rowsum写入的数据，写入数据，为rowbuf_r当前数据与rcv_data_buf的加和*/

   // rowbuf write mux
   //写入数据选择
   assign databuf_wdat_mux =   ({`E203_XLEN{ldata_wr  }} & ldata_wdata  );
                           /* | ({`E203_XLEN{rowsum_wr}} & rowsum_wdata)
                            ;*/
   //写入使能选择，ldata_wr
   assign databuf_wr_mux   =  ldata_wr;// | rowsum_wr;
   //写入序号选择，若ldata_wr为高，则为ldata_idx
   assign databuf_idx_mux  =   ({DATA_WIDTH{ldata_wr  }} & ldata_idx  );
                           /* | ({DATA_WIDTH{rowsum_wr}} & rowsum_idx)
                            ;  */
   
   //D触发器构成时序///
   //实例化16个输入的8位的D触发器
   // databuf inst
   genvar j;
   generate 
     for (j=0; j<DATA_NUM; j=j+1) begin:gen_databuf
       //databuf_we为使能信号，为databuf_wr_mux与一个表达式的与，i的低2位与rowbuf_idx_mux相等才可以
       assign databuf_we[j] =   (databuf_wr_mux & (databuf_idx_mux == j[DATA_WIDTH-1:0]))
                             ;
       //databuf_wdat为输入数据，使能时为databuf_wdat_mux
       assign databuf_wdat[j] =   ({`E203_XLEN{databuf_we[j]}} & databuf_wdat_mux   )
                               ;
  
       sirv_gnrl_dfflr #(`E203_XLEN) databuf_dfflr (databuf_we[j], databuf_wdat[j], databuf_r[j], nice_clk, nice_rst_n);
     end
   endgenerate

   // mem aacess addr management，memory的地址
   wire [`E203_XLEN-1:0] maddr_acc_r; 
   assign nice_icb_cmd_hsked = nice_icb_cmd_valid & nice_icb_cmd_ready;   //储存请求握手
   // custom3_lkey，lkey，访问memory的使能
   //（当前状态为idle，命令为lkey，并且储存请求握手）或（当前状态lkey，储存请求握手）
   //wire [`E203_XLEN-1:0] lbuf_maddr    = state_is_idle ? nice_req_rs1 : maddr_acc_r ; 
   wire lkey_maddr_ena    =   (state_is_idle & custom3_load_key & nice_icb_cmd_hsked)
                            | (state_is_lkey & nice_icb_cmd_hsked)
                            ;

   wire ldata_maddr_ena   =   (state_is_idle & custom3_load_data & nice_icb_cmd_hsked)
                            | (state_is_ldata & nice_icb_cmd_hsked)
                            ;                       

   // custom3_sbuf ，sbuf，访问memory的使能
   //（当前状态为idle，命令为sbuf，并且储存请求握手）或（当前状态sbuf，储存请求握手）
   //wire [`E203_XLEN-1:0] sbuf_maddr    = state_is_idle ? nice_req_rs1 : maddr_acc_r ; 
   wire  res_maddr_ena    =   (state_is_idle & custom3_sm4_res & nice_icb_cmd_hsked)
                            | (state_is_sm4_res & nice_icb_cmd_hsked)
                            ;
/*
   // custom3_rowsum，	rowsum，访问memory的使能
   //（当前状态为idle，命令为rowsum，并且储存请求握手）或（当前状态rowsum，储存请求握手）
   //wire [`E203_XLEN-1:0] rowsum_maddr  = state_is_idle ? nice_req_rs1 : maddr_acc_r ; 
   wire rowsum_maddr_ena  =   (state_is_idle & custom3_rowsum & nice_icb_cmd_hsked)
                            | (state_is_rowsum & nice_icb_cmd_hsked)
                            ;
*/
   // maddr acc 
   //wire  maddr_incr = lbuf_maddr_ena | sbuf_maddr_ena | rowsum_maddr_ena | rbuf_maddr_ena;
   //（当前状态为idle，命令有效，并且储存请求握手）或（当前状态非idle，储存请求握手）
   wire  maddr_ena = lkey_maddr_ena | ldata_maddr_ena | res_maddr_ena;// | sbuf_maddr_ena | rowsum_maddr_ena;//访问memory的使能
   //当前状态为idle，命令为有效，并且储存请求握手
   wire  maddr_ena_idle = maddr_ena & state_is_idle;//访问memory的使能，且当前状态为idle
  
  //当前状态为idle，命令为有效，并且储存请求握手，为寄存器1值，否则为maddr_acc_r.且每次读写的内存地址逐次加4
//maddr_acc_r即为rs1寄存器地址每次加4，这是因为32/8=4，对于32位数据，在memory中需要占据4个字节。
   wire [`E203_XLEN-1:0] maddr_acc_op1 = maddr_ena_idle ? nice_req_rs1 : maddr_acc_r; // not reused
   //32/8 = 4，所以每次要加4
   wire [`E203_XLEN-1:0] maddr_acc_op2 = maddr_ena_idle ? `E203_XLEN'h4 : `E203_XLEN'h4; 
   //下一个地址，为当前地址+4
   wire [`E203_XLEN-1:0] maddr_acc_next = maddr_acc_op1 + maddr_acc_op2;//操作数1，操作数2
   wire  maddr_acc_ena = maddr_ena;  //	访问memory的使能，为（当前状态为idle，命令有效，并且储存请求握手）或（当前状态非idle，储存请求握手）
   
   //D触发器，使能信号：maddr_acc_ena，输入数据：maddr_acc_next，输出：maddr_acc_r
   sirv_gnrl_dfflr #(`E203_XLEN)   maddr_acc_dfflr (maddr_acc_ena, maddr_acc_next, maddr_acc_r, nice_clk, nice_rst_n);

   
   // Control cmd_req
   
   assign nice_req_hsked = nice_req_valid & nice_req_ready;//命令请求握手
   //nice发出的命令请求握手信号，当前状态是idle，且指令有效，则为nice_icb_cmd_ready，否则为1'b1
   assign nice_req_ready = state_is_idle & (custom_mem_op ? nice_icb_cmd_ready : 1'b1);

   
   // Control cmd_rsp
   
   assign nice_rsp_hsked = nice_rsp_valid & nice_rsp_ready; //命令响应握手
   assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;//储存响应握手
   //（当前状态lbuf，lbuf计数值为最后值，E203发出储存响应信号）或（当前状态sbuf，sbuf计数值为最后值，E203发出储存响应信号）或（当前状态rowsum，rcv_data_buf_idx计数值为最后值，rowsum_acc_flg为低）或（rcv_data_buf_idx非零，且上个周期的状态为rowsum时（储存响应握手或E203发出nice_rsp_ready信号））
   assign nice_rsp_valid = nice_rsp_valid_lkey | nice_rsp_valid_ldata | nice_rsp_valid_res | nice_rsp_valid_enc | nice_rsp_valid_dec;
   //| nice_rsp_valid_sdata | nice_rsp_valid_rowsum;//命令响应有效
   assign nice_rsp_rdat  = `E203_XLEN'd0; //{`E203_XLEN{state_is_rowsum}} & rowsum_res;//当前状态为rowsum时为rowsum_res

   // memory access bus error
   //assign nice_rsp_err_irq  =   (nice_icb_rsp_hsked & nice_icb_rsp_err)
   //                          | (nice_req_hsked & illgel_instr)
   //                          ; 
   assign nice_rsp_err   =   (nice_icb_rsp_hsked & nice_icb_rsp_err);//储存响应握手且在访问memory时出错

   
   // Memory lsu，memory相关
   
   // memory access list:
   //  1. In IDLE, custom_mem_op will access memory(lbuf/sbuf/rowsum)
   //  2. In LBUF, it will read from memory as long as lbuf_cnt_r is not full
   //  3. In SBUF, it will write to memory as long as sbuf_cnt_r is not full
   //  3. In ROWSUM, it will read from memory as long as rowsum_cnt_r is not full
   //assign nice_icb_rsp_ready = state_is_ldst_rsp & nice_rsp_ready; 
   // rsp always ready
   reg   [`E203_XLEN-1:0] resbuf_r    [DATA_NUM-1:0];
   assign nice_icb_rsp_ready = 1'b1; //始终为1'b1
   wire [DATA_WIDTH-1:0] sbuf_idx = data_size - res_cmd_cnt_r; 

reg enc_r, dec_r;
reg [10:0] cnt_r, cnt_r1;
reg dec_do;
reg enc_do;
   always @(posedge nice_clk) begin
      case (state_r)
         ENCRYPT : begin 
            sm4_enable_in     <= 1'b1;  
            enable_key_exp_in <= 1'b1;
            encdec_enable_in  <= 1'b1;
            encdec_sel_in     <= 1'b0;
            data_in           <= {databuf_r[0],databuf_r[1],databuf_r[2],databuf_r[3]};
            valid_in          <= 1'b1;
         end
         DECRYPT : begin
            sm4_enable_in     <= 1'b1;  
            enable_key_exp_in <= 1'b1;
            encdec_enable_in  <= 1'b1;
            encdec_sel_in     <= 1'b1;
            data_in           <= {databuf_r[0],databuf_r[1],databuf_r[2],databuf_r[3]};
            valid_in          <= 1'b1;
         end
         default : begin
            sm4_enable_in     <= 1'b0;  
            enable_key_exp_in <= 1'b0;
            encdec_enable_in  <= 1'b0;
            encdec_sel_in     <= 1'b0;
            valid_in          <= 1'b0;
            data_in           <= `E203_XLEN'd0;
         end
      endcase
   end

   always @(posedge nice_clk or negedge nice_rst_n) begin
      if (!nice_rst_n) begin
         user_key_valid_in <= 1'b0;
         user_key_in       <= `E203_XLEN'd0;
      end else begin
         if (sm4_enable_in) begin
            user_key_valid_in <= 1'b1;
            user_key_in       <= {keybuf_r[0],keybuf_r[1],keybuf_r[2],keybuf_r[3]};
         end else begin
            user_key_valid_in <= 1'b0;
            user_key_in       <= `E203_XLEN'd0;
         end
      end
   end
/*
   always @(posedge nice_clk or negedge nice_rst_n) begin
      if (!nice_rst_n) begin
         cnt_r <= 0;
         dec_do <= 1'b0;
      end else begin
         if (state_r == DECRYPT) begin
            cnt_r <= cnt_r + 1;
            if (cnt_r == 11'd32) begin
               cnt_r <= 0;
               dec_do <= 1'b1;
            end else begin
               dec_do <= 1'b0;
            end
         end
      end
   end

   always @(posedge nice_clk or negedge nice_rst_n) begin
      if (!nice_rst_n) begin
         cnt_r1 <= 0;
         enc_do <= 1'b0;
      end else begin
         if (state_r == ENCRYPT) begin
            cnt_r1 <= cnt_r1 + 1;
            if (cnt_r1 == 11'd32) begin
               cnt_r1 <= 0;
               enc_do <= 1'b1;
            end else begin
               enc_do <= 1'b0;
            end
         end
      end
   end
*/
   assign encrypt_done = ready_out;
   assign decrypt_done = ready_out;

   always @(posedge nice_clk) begin
      case (state_r)
         ENCRYPT, DECRYPT : begin
            if (ready_out) begin
               resbuf_r[0] <= result_out[31:0];
               resbuf_r[1] <= result_out[63:32];
               resbuf_r[2] <= result_out[95:64];
               resbuf_r[3] <= result_out[127:96];
            end else begin
               resbuf_r[0] <= resbuf_r[0];
               resbuf_r[1] <= resbuf_r[1];
               resbuf_r[2] <= resbuf_r[2];
               resbuf_r[3] <= resbuf_r[3];
            end
         end

         default: begin
            resbuf_r[0] <= resbuf_r[0];
            resbuf_r[1] <= resbuf_r[1];
            resbuf_r[2] <= resbuf_r[2];
            resbuf_r[3] <= resbuf_r[3];
         end
      endcase
   end
   //（当前状态为idle且E203发出nice_req_valid且指令有效）或（状态lbuf，lbuf计数值小于最后值）或（状态sbuf，sbuf_cmd小于等于最后值且sbuf计数值不是最后值）或（状态rowsum，rcv_data_buf计数值小于最后值，且（rcv_data_buf_idx非零，且上个周期的状态为rowsum时（储存响应握手或E203发出nice_rsp_ready信号））
   assign nice_icb_cmd_valid =   (state_is_idle & nice_req_valid & custom_mem_op)
                              | nice_icb_cmd_valid_lkey
                              | nice_icb_cmd_valid_ldata
                              | nice_icb_cmd_valid_res
//                              | nice_icb_cmd_valid_rowsum
                              ;

   assign nice_icb_cmd_addr  = (state_is_idle & custom_mem_op) ? nice_req_rs1 :
                              maddr_acc_r;//（状态idle且命令有效）为寄存器1，否则为maddr_acc_r

   assign nice_icb_cmd_read  = (state_is_idle & custom_mem_op) ? (custom3_load_key | custom3_load_data) : 
                              state_is_sm4_res ? 1'b0 : 
                              1'b1;//（状态idle且为lkey或ldata指令，为1，为sm4_res指令，为0），或者为sm4_res状态为0，否则为1
   assign nice_icb_cmd_wdata = (state_is_idle & custom3_sm4_res) ? resbuf_r[sbuf_idx] :
                              state_is_sm4_res ? resbuf_r[sbuf_idx] : 
                              `E203_XLEN'b0; //（状态idle，sbuf指令）或subf状态，为rowbuf_r[sbuf_idx]，否则为0

   //assign nice_icb_cmd_wmask = {`sirv_XLEN_MW{custom3_sbuf}} & 4'b1111;
   assign nice_icb_cmd_size  = 2'b10;//为2，代表4字节32位宽数据
   assign nice_mem_holdup    =  state_is_lkey | state_is_ldata | state_is_sm4_res | state_is_encrypt | state_is_decrypt; //为非idle状态，访问memory锁

   
   // nice_active
   
   assign nice_active = state_is_idle ? nice_req_valid : 1'b1;

endmodule
`endif//}
