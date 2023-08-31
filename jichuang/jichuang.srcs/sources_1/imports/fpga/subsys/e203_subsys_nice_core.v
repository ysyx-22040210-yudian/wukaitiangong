/*
e203_subsys_nice_coreģ��ΪЭ����ģ�飬��E203��cpuģ������������ݽ�����
NICEģ����ź���Ҫ��CPU�ڲ�������ģ�鴦����Ϊ��
(1)e203_ifu:ȡָ�Ԫ��ȡָ���Լ�����PC��
(2)e203_exu:ִ�е�Ԫ(���ִ�С��洢���������ύд�أ�
(3)e203_lsu:�洢�����ʵ�Ԫ
nice_req_inst����Ҫ�漰(1)(2)�������֡�
����(1)����e203_ifuģ������e203_ifu_ifetch��e203_ifu_ift2icb����PC��ַ�����ָ����e203_ifu_ift2icbͨ��ifu_rsp_instr�źŻش�ָ�

���e203_ifu_ifetchͨ��ifu_o_ir�ش�ָ�e203_core.v�е�e203_ifuģ�顣��ͬʱ���ݸ�e203_exuģ���i_ir��e203_exu���䴫�ݸ�e203_exu_alu��i_instr�������մ��ݸ�e203_exu_niceģ�飬�ɸ�ģ�����nice_req_inst�ź�ָ���e203_subsys_nice_coreЭ��������
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
    input                         nice_req_valid       , // �ں˸���nice����չָ�������һ�еĿ�ʼ��������ֻ����һ��ʱ������
    output                        nice_req_ready       , //��ִ��ָ���ʱ������ͣ�������ʱ������ߣ��ڸյõ���չָ���ʱ����nice_req_validͬʱΪ1���������
    input  [`E203_XLEN-1:0]       nice_req_inst        , //��չָ�nice_req_validΪ1��ʱ���Ǹ�����ʱ����Ч
    input  [`E203_XLEN-1:0]       nice_req_rs1         , //��չָ���rs1������չָ��nice_req_instͬ����
    input  [`E203_XLEN-1:0]       nice_req_rs2         , //��չָ���rs2,����չָ��nice_req_instͬ����
    // Control cmd_rsp	
    output                        nice_rsp_valid       , //ִ������չָ������ߣ�����һ��ʱ������
    input                         nice_rsp_ready       , //��ִ��ָ���ʱ���ں˻�Ѹ��ź����ߣ�����ʱ�����͡���ִ�����һ�����ڵ�ʱ����nice_rsp_validͬʱΪ1���������
    output [`E203_XLEN-1:0]       nice_rsp_rdat        , //��ָ��ִ�е�ʱ��ʵʱ���ں˷��ص�ǰ�������ݣ�nice_rsp_validΪ1��ʱ���Ǹ�����ʱ����Ч��Ҳ����д�ص��ں˵ļĴ����� (�������ֻ��д�ؼĴ����е�ʵʱָ��������������)//
    output                        nice_rsp_err    	  ,
    // Memory lsu_req	
    output                        nice_icb_cmd_valid   , //��ǰ��idle״̬���ҵ�ǰ��ǲ��ָ����nice�������Ƿ´��niceָ���ʱ�򡣻��ߵ�ǰ����ִ��nice�ķ´��й�ָ���ʱ�����ߣ����ź�Ϊ1��ʱ�򣬷´�ĵ�ַ������Ч��
    input                         nice_icb_cmd_ready   , //��niceָ��ִ���ڼ��Ϊ1
    output [`E203_ADDR_SIZE-1:0]  nice_icb_cmd_addr    , //niceָ��ĵ�ַ����״̬ΪIDLE��ʱ�򣬲��ҵ�ǰ�Ƿô��niceָ���ʱ�򣬻��niceָ���rs1��Ӧ�Ĵ����е�ֵ��Ϊ�´��ַ�������ǰ״̬������ִ��niceָ���ʱ�򣬷´�ĵ�ַ�ɶ�Ӧ��ָ����ƣ�������������´��������ĸ���ַ������  
    output                        nice_icb_cmd_read    , //ֻ��д�ش洢����ʱ�����ͣ������κ�ʱ��������
    output [`E203_XLEN-1:0]       nice_icb_cmd_wdata   , //��ǰд�ش洢����niceָ���ʱ�����洢����д������ݣ����������������д���3�����ݣ������������0
//    output [`E203_XLEN_MW-1:0]     nice_icb_cmd_wmask   ,  // 
    output [1:0]                  nice_icb_cmd_size    , //��Ϊ32λ��
    // Memory lsu_rsp	
    input                         nice_icb_rsp_valid   , //��lsu����niceָ��ô��ʱ�����ߣ���Ϊ�ߵ�ƽ�ڼ���ԶԴ洢����д����
    output                        nice_icb_rsp_ready   , //��Ϊ1
    input  [`E203_XLEN-1:0]       nice_icb_rsp_rdata   , //��lsu����niceָ��ô��ʱ�򣬻�Ѵ洢���е����ݶ���������nice_icb_rsp_validΪ1��ʱ�򣬸����ݲ�����Ч��
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
   
   wire [6:0] opcode      = {7{nice_req_valid}} & nice_req_inst[6:0]; //opcode��ǰ7λ
   wire [2:0] rv32_func3  = {3{nice_req_valid}} & nice_req_inst[14:12];//rv32_func3Ϊ{14->12}
   wire [6:0] rv32_func7  = {7{nice_req_valid}} & nice_req_inst[31:25];//rv32_func7Ϊ{31->25}

//   wire opcode_custom0 = (opcode == 7'b0001011); 
//   wire opcode_custom1 = (opcode == 7'b0101011); 
//   wire opcode_custom2 = (opcode == 7'b1011011); 
   wire opcode_custom3 = (opcode == 7'b1111011); //NICEʹ����custom3�͵�RISC-Vָ��

   wire rv32_func3_000 = (rv32_func3 == 3'b000); //func3���
   wire rv32_func3_001 = (rv32_func3 == 3'b001); 
   wire rv32_func3_010 = (rv32_func3 == 3'b010); 
   wire rv32_func3_011 = (rv32_func3 == 3'b011); 
   wire rv32_func3_100 = (rv32_func3 == 3'b100); 
   wire rv32_func3_101 = (rv32_func3 == 3'b101); 
   wire rv32_func3_110 = (rv32_func3 == 3'b110); 
   wire rv32_func3_111 = (rv32_func3 == 3'b111); 

   wire rv32_func7_0000000 = (rv32_func7 == 7'b0000000); //func7���
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
   
   //���������Զ���ָ����custom3�������func3��func7�Ĺ�ϵ
   wire custom3_load_key     = opcode_custom3 & rv32_func3_010 & rv32_func7_0000001; //load_key��ȡrs1
   wire custom3_load_data    = opcode_custom3 & rv32_func3_010 & rv32_func7_0000010; //load_data��ȡrs1 
   wire custom3_encrypt      = opcode_custom3 & rv32_func3_110 & rv32_func7_0000110; //encrypt����data���ݣ�������key��չ
   wire custom3_decrypt      = opcode_custom3 & rv32_func3_110 & rv32_func7_0000111; //decrypt����data���ݣ�������key��չ
   wire custom3_sm4_res      = opcode_custom3 & rv32_func3_010 & rv32_func7_0000100; //sm4_res��data����д���ڴ�
   
   //  multi-cyc op 
   //���������źţ��ֱ����Э������ָ�����Ҫ����memory
   wire custom_multi_cyc_op = custom3_load_key | custom3_load_data | custom3_encrypt | custom3_decrypt | custom3_sm4_res;
   // need access memory
   wire custom_mem_op = custom3_load_key | custom3_load_data | custom3_sm4_res;
 
   
   // NICE FSM ��NICE�ڲ���ָ��ĵ���ʹ��״̬�������ĸ�״̬�����к�����ָ��״̬
   
   parameter NICE_FSM_WIDTH = 3; //��ʼ��״̬
   parameter IDLE     = 3'd0; 
   parameter LKEY     = 3'd1; 
   parameter LDATA    = 3'd2; 
   parameter ENCRYPT  = 3'd3; 
   parameter DECRYPT  = 3'd4;
   parameter SM4_RES  = 3'd5;

   //��̬�ʹ�̬
   wire [NICE_FSM_WIDTH-1:0] state_r;          //״ָ̬��
   wire [NICE_FSM_WIDTH-1:0] nxt_state;        //��һ״̬
   wire [NICE_FSM_WIDTH-1:0] state_idle_nxt;   //��һ״̬Ϊ��ʼ��IDLE
   wire [NICE_FSM_WIDTH-1:0] state_lkey_nxt;   //��һ״̬Ϊload_key
   wire [NICE_FSM_WIDTH-1:0] state_ldata_nxt;  //��һ״̬Ϊload_data
   wire [NICE_FSM_WIDTH-1:0] state_encrypt_nxt; //��һ״̬Ϊencrypt
   wire [NICE_FSM_WIDTH-1:0] state_decrypt_nxt; //��һ״̬Ϊdecrypt
   wire [NICE_FSM_WIDTH-1:0] state_sm4_res_nxt; //��һ״̬Ϊsm4_res
//------------------------------------------****************************************---------------------------------
   wire nice_req_hsked;    //��cpu�����źţ�cpu����ָ�� assign nice_req_hsked = nice_req_valid & nice_req_ready;//������������
   wire nice_rsp_hsked;    //��cpu�����źţ���cpu���ͽ�� assign nice_rsp_hsked = nice_rsp_valid & nice_rsp_ready; //������Ӧ����
   wire nice_icb_rsp_hsked;//��memory�����ź�   assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;//������Ӧ����
   wire illgel_instr = ~(custom_multi_cyc_op);//Ϊ1��û������ָ�illgel_instrΪ0������Э������ָ�Ϊ1������
     
   //����״̬�뿪ʹ���źţ��ĸ�״̬�ĺ���ʵ״̬�ģ���5��
   wire state_idle_exit_ena;  //�˳���ʼ��״̬ʹ��
   wire state_lkey_exit_ena;  //�˳�lkey״̬ʹ�� 
   wire state_ldata_exit_ena;  //�˳�ldata״̬ʹ��  
   wire state_encrypt_exit_ena;//�˳�encrypt״̬ʹ��
   wire state_decrypt_exit_ena;//�˳�decrypt״̬ʹ��
   wire state_sm4_res_exit_ena;//�˳�sm4_res״̬ʹ��
   wire state_ena;            //״̬ʹ��

   //����������ʲô״̬���ĸ��ź�
   wire state_is_idle     = (state_r == IDLE);  //state��idleʱ����ǰ״̬�ǳ�ʼ��
   wire state_is_lkey     = (state_r == LKEY);  //state��lkeyʱ����ǰ״̬��lkey״̬ 
   wire state_is_ldata    = (state_r == LDATA);  //state��ldataʱ����ǰ״̬��ldata״̬
   wire state_is_encrypt  = (state_r == ENCRYPT);//state��encryptʱ����ǰ״̬��encrypt״̬
   wire state_is_decrypt  = (state_r == DECRYPT);//state��decryptʱ����ǰ״̬��decrypt״̬
   wire state_is_sm4_res  = (state_r == SM4_RES);//state��sm4_resʱ����ǰ״̬��sm4_res״̬
   
   //״̬ת��
   //��ǰ״̬�ǳ�ʼ��״̬����cpu�������ֳɹ����ҵ�ǰû��ָ���ڲ��������˳���ʼ��״̬����ʼ���������ָ��״̬ 
   //��״̬�뿪ʹ���źŸ�ֵ������̬ΪIDLE�����ң�nice_req_hsked)�����ҵ�ǰΪ5ָ��֮һ��state_idle_exit_enaΪ��
   assign state_idle_exit_ena = state_is_idle & nice_req_hsked & ~illgel_instr; 
   //�жϳ�ʼ��״̬����һ��״̬������ָ����lbuf������LBUF״̬���������򱣳ֳ�ʼ��������ָ��״̬�Ĵ�̬����ΪIDLE
   assign state_idle_nxt =  custom3_load_key    ? LKEY   : 
                            custom3_load_data   ? LDATA  :
                            custom3_encrypt     ? ENCRYPT:
                            custom3_decrypt     ? DECRYPT:
                            custom3_sm4_res     ? SM4_RES:
			    IDLE;

   wire lkey_icb_rsp_hsked_last;//lkey���������ź� 
   //��ǰ״̬��lkey��lkey������ɣ����˳�lkey״̬ʹ��Ϊ1
   assign state_lkey_exit_ena = state_is_lkey & lkey_icb_rsp_hsked_last; //���������һ�����ݵ�ʱ���˳�lkey״̬
   //��̬Ϊlkey������(lkey_icb_rsp_hsked_last)��state_lkey_exit_enaΪ��
   assign state_lkey_nxt = IDLE;//lkey��һ״̬��idle����������
   wire   ldata_icb_rsp_hsked_last; 
   assign state_ldata_exit_ena = state_is_ldata & ldata_icb_rsp_hsked_last; //���������һ�����ݵ�ʱ���˳�ldata״̬
   assign state_ldata_nxt = IDLE;
   wire   encrypt_done; //encrypt���������ź�
   assign state_encrypt_exit_ena = state_is_encrypt & encrypt_done; //���ܽ������˳�encrypt״̬
   assign state_encrypt_nxt = IDLE;
   wire   decrypt_done; //decrypt���������ź�
   assign state_decrypt_exit_ena = state_is_decrypt & decrypt_done; //���ܽ������˳�decrypt״̬
   assign state_decrypt_nxt = IDLE;
   wire   res_icb_rsp_hsked_last; //sm4_res���������ź�
   assign state_sm4_res_exit_ena = state_is_sm4_res & res_icb_rsp_hsked_last; //���������һ�����ݵ�ʱ���˳�sm4_res״̬
   assign state_sm4_res_nxt = IDLE;

   //��̬��ֵ�����˳���Ӧ��������ʱ״̬ʹ��Ϊ1ʱ����һ��״̬�л���IDLE��ʼ��
   assign nxt_state =   ({NICE_FSM_WIDTH{state_idle_exit_ena   }} & state_idle_nxt   )
                      | ({NICE_FSM_WIDTH{state_lkey_exit_ena   }} & state_lkey_nxt   ) 
                      | ({NICE_FSM_WIDTH{state_ldata_exit_ena  }} & state_ldata_nxt  ) 
                      | ({NICE_FSM_WIDTH{state_encrypt_exit_ena}} & state_encrypt_nxt)
                      | ({NICE_FSM_WIDTH{state_decrypt_exit_ena}} & state_decrypt_nxt)
                      | ({NICE_FSM_WIDTH{state_sm4_res_exit_ena}} & state_sm4_res_nxt) 
                      ;
   //״̬ת��ʹ�ܣ�Ϊ�ĸ�ʹ�ܵĻ򡣵��˳���Ӧ����ʹ��Ϊ1ʱ����״̬ʹ����Ϊ1
   assign state_ena =   state_idle_exit_ena   | state_lkey_exit_ena 
                      | state_ldata_exit_ena  | state_encrypt_exit_ena
                      | state_decrypt_exit_ena| state_sm4_res_exit_ena;

   //ʱ��״̬��������sirv_gnrl_dfflr��D��������ʵ��״̬��
   //��ģ����һ��buffer����״̬�л���ʹ��Ϊ1ʱ��������һ��״̬����һ�ĺ��state_r���
   sirv_gnrl_dfflr #(NICE_FSM_WIDTH)   state_dfflr (state_ena, nxt_state, state_r, nice_clk, nice_rst_n);

   
   // instr EXU
   // LOAD KEY
   wire [KEY_WIDTH-1:0]  key_size = 2'd3;  // key���ֽ���Ŀ
   wire [DATA_WIDTH-1:0] data_size= 2'd3;        // key�ļ�����
   //wire [COL_IDX_W-1:0]  rownum;

   wire  nice_rsp_valid_enc; //���ܽ����ź�
   wire  nice_rsp_valid_dec; //���ܽ����ź�
   //ֻ�����ָ��Ľ����ź������ʱ�򣬴������Ǳ߲������ָ����ɵ����֣��������ܽ�����һ��ָ�����źź���Ҫ
   assign nice_rsp_valid_enc = state_is_encrypt & encrypt_done; //���ܽ�����������ܽ����ź�
   assign nice_rsp_valid_dec = state_is_decrypt & decrypt_done; //���ܽ�����������ܽ����ź�
   // 1. custom3_lkey
   ///������һ��lkey�ļ�����
   wire [KEY_WIDTH-1:0] lkey_cnt_r;      //���ڼ���ֵ,16��
   wire [KEY_WIDTH-1:0] lkey_cnt_nxt;    //��һ������ֵ
   wire lkey_cnt_clr;                    //�������㣬ʹ��
   wire lkey_cnt_incr;                   //�������ӣ�ʹ��
   wire lkey_cnt_ena;                    //������D��������ʹ��
   wire lkey_cnt_last;                   //���������ֵ
   wire lkey_icb_rsp_hsked;              //״̬��Ϊlkey�����Ҵ�����Ӧ���ֳɹ�
   wire nice_rsp_valid_lkey;             //״̬��Ϊlkey�����������ֵ��E203����������Ӧ�ź�
   wire nice_icb_cmd_valid_lkey;         //״̬��Ϊlkey������ֵС�����ֵ

   //�źŸ�ֵ
   //��֪assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;����nice_icb_rsp_ready is 1'b1 always������nice_icb_rsp_hsked = nice_icb_rsp_valid
   assign lkey_icb_rsp_hsked = state_is_lkey & nice_icb_rsp_hsked; //��ǰ״̬Ϊlkey��������Ӧ����
   assign lkey_icb_rsp_hsked_last = lkey_icb_rsp_hsked & lkey_cnt_last; //����ǰ״̬Ϊlkey��������Ӧ���֣�����Ϊ���ֵ
   assign lkey_cnt_last = (lkey_cnt_r == key_size); //�����������ֵ��Ҳ����lkey_cnt_rΪ5'd15
   //��֪assign nice_req_hsked = nice_req_valid & nice_req_ready;����lbuf_cnt_clr����Ϊ��ǰָ��Ϊlkey��������������
   assign lkey_cnt_clr = custom3_load_key & nice_req_hsked;
   assign lkey_cnt_incr= lkey_icb_rsp_hsked & ~lkey_cnt_last;//��ǰ״̬Ϊlkey��������Ӧ���֣�����ֵ�������ֵ
   assign lkey_cnt_ena = lkey_cnt_clr | lkey_cnt_incr;//��ǰָ��Ϊlkey�������������֣����ߵ�ǰ״̬lkey������ָ�����֣�����ֵ�������ֵ
   //��ǰָ��lkey�������������֣�lkey_cnt_nxt���㣻��ǰ״̬lkey��������Ӧ���֣�����ֵ�������ֵ��lkey_cnt_nxtΪlkey_cnt_r+1
   assign lkey_cnt_nxt =   ({KEY_WIDTH{lkey_cnt_clr }} & {KEY_WIDTH{1'b0}})
                         | ({KEY_WIDTH{lkey_cnt_incr}} & (lkey_cnt_r + 1'b1))
                         ;
   //D����������ʱ���������ʱ�ӣ�nice_clk ; ��λ�źţ�nice_rst_n ; ʹ���źţ�lkey_cnt_ena ;����������lkey_cnt_nxt �� ������ݣ�lkey_cnt_r
   sirv_gnrl_dfflr #(KEY_WIDTH)   lkey_cnt_dfflr (lkey_cnt_ena, lkey_cnt_nxt, lkey_cnt_r, nice_clk, nice_rst_n);

   // nice_rsp_valid wait for nice_icb_rsp_valid in LBUF
   assign nice_rsp_valid_lkey = state_is_lkey & lkey_cnt_last & nice_icb_rsp_valid;//��ǰ״̬Ϊlkey������ֵΪ���ֵ��E203����������Ӧ�ź�

   // nice_icb_cmd_valid sets when lkey_cnt_r is not full in LOAD_KEY_BUF
   assign nice_icb_cmd_valid_lkey = (state_is_lkey & (lkey_cnt_r < key_size));//��ǰ״̬Ϊlkey�����ּ���ֵС�����ֵ

   // LOAD DATA
   // 2. custom3_ldata
   ///������һ��ldata�ļ�����
   wire [DATA_WIDTH-1:0] ldata_cnt_r;      //���ڼ���ֵ,16��
   wire [DATA_WIDTH-1:0] ldata_cnt_nxt;    //��һ������ֵ
   wire ldata_cnt_clr;                    //�������㣬ʹ��
   wire ldata_cnt_incr;                   //�������ӣ�ʹ��
   wire ldata_cnt_ena;                    //������D��������ʹ��
   wire ldata_cnt_last;                   //���������ֵ
   wire ldata_icb_rsp_hsked;              //״̬��Ϊldata�����Ҵ�����Ӧ���ֳɹ�
   wire nice_rsp_valid_ldata;             //״̬��Ϊldata�����������ֵ��E203����������Ӧ�ź�
   wire nice_icb_cmd_valid_ldata;         //״̬��Ϊldata������ֵС�����ֵ

   //�źŸ�ֵ
   //��֪assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;����nice_icb_rsp_ready is 1'b1 always������nice_icb_rsp_hsked = nice_icb_rsp_valid
   assign ldata_icb_rsp_hsked = state_is_ldata & nice_icb_rsp_hsked; //��ǰ״̬Ϊldata��������Ӧ����
   assign ldata_icb_rsp_hsked_last = ldata_icb_rsp_hsked & ldata_cnt_last; //����ǰ״̬Ϊldata��������Ӧ���֣�����Ϊ���ֵ
   assign ldata_cnt_last = (ldata_cnt_r == data_size); //�����������ֵ��Ҳ����ldata_cnt_rΪ5'd15
   //��֪assign nice_req_hsked = nice_req_valid & nice_req_ready;����lbuf_cnt_clr����Ϊ��ǰָ��Ϊldata��������������
   assign ldata_cnt_clr = custom3_load_data & nice_req_hsked;
   assign ldata_cnt_incr= ldata_icb_rsp_hsked & ~ldata_cnt_last;//��ǰ״̬Ϊldata��������Ӧ���֣�����ֵ�������ֵ
   assign ldata_cnt_ena = ldata_cnt_clr | ldata_cnt_incr;//��ǰָ��Ϊldata�������������֣����ߵ�ǰ״̬ldata������ָ�����֣�����ֵ�������ֵ
   //��ǰָ��ldata�������������֣�ldata_cnt_nxt���㣻��ǰ״̬ldata��������Ӧ���֣�����ֵ�������ֵ��ldata_cnt_nxtΪldata_cnt_r+1
   assign ldata_cnt_nxt =   ({DATA_WIDTH{ldata_cnt_clr }} & {DATA_WIDTH{1'b0}})
                         | ({DATA_WIDTH{ldata_cnt_incr}} & (ldata_cnt_r + 1'b1))
                         ;
   //D����������ʱ���������ʱ�ӣ�nice_clk ; ��λ�źţ�nice_rst_n ; ʹ���źţ�ldata_cnt_ena ;����������ldata_cnt_nxt �� ������ݣ�ldata_cnt_r
   sirv_gnrl_dfflr #(DATA_WIDTH)   ldata_cnt_dfflr (ldata_cnt_ena, ldata_cnt_nxt, ldata_cnt_r, nice_clk, nice_rst_n);

   // nice_rsp_valid wait for nice_icb_rsp_valid in LBUF
   assign nice_rsp_valid_ldata = state_is_ldata & ldata_cnt_last & nice_icb_rsp_valid;//��ǰ״̬Ϊldata������ֵΪ���ֵ��E203����������Ӧ�ź�

   // nice_icb_cmd_valid sets when ldata_cnt_r is not full in LOAD_DATA_BUF
   assign nice_icb_cmd_valid_ldata = (state_is_ldata & (ldata_cnt_r < data_size));//��ǰ״̬Ϊldata�����ּ���ֵС�����ֵ

   // 3. custom3_sm4_res
   //cmd�ź��Ǹ��洢�������ַ��wdata�ģ�rsp�ź��ǴӴ洢����дȡ���ݵģ�����cmd�ź�Ҫ��rsp�ź���ǰһ�ģ���������һ�����
   wire [DATA_WIDTH-1:0] res_cnt_r;   //��ǰ����ֵ
   wire [DATA_WIDTH-1:0] res_cnt_nxt; //�¸�����ֵ
   wire res_cnt_clr;
   wire res_cnt_incr;                   //res_cnt���ӣ�ʹ��
   wire res_cnt_ena;                    //D��������ʹ��
   wire res_cnt_last;                   //��ǰ����ֵΪ���ֵ
   wire res_icb_cmd_hsked;              //��ǰ״̬Ϊres����(״̬ΪIDLE��ָ��Ϊres)���������ֳɹ�
   wire res_icb_rsp_hsked;              //��ǰ״̬Ϊres��������Ӧ���ֳɹ�
   wire nice_rsp_valid_res;             //״̬��Ϊres�����������ֵ��E203����������Ӧ�ź�
   wire nice_icb_cmd_valid_res;         //״̬Ϊres��res_cmd_cnt_rС�ڵ������ֵ��res_cnt�������ֵ
   wire nice_icb_cmd_hsked;              //�����������ֳɹ�

   // -------------------------------------------------------
   // -- �Դ洢��д���������źŵļ���
   // -------------------------------------------------------
   //assign nice_icb_cmd_hsked = nice_icb_cmd_valid & nice_icb_cmd_ready;   //������������
   assign res_icb_cmd_hsked = (state_is_sm4_res | (state_is_idle & custom3_sm4_res)) & nice_icb_cmd_hsked;//��ǰ״̬Ϊres����idle״ָ̬��Ϊres)�������������ֳɹ�
   //  assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;//������Ӧ����
   assign res_icb_rsp_hsked = state_is_sm4_res & nice_icb_rsp_hsked;//��ǰ״̬res��������Ӧ����
   assign res_icb_rsp_hsked_last = res_icb_rsp_hsked & res_cnt_last;//��ǰ״̬res��������Ӧ���֣�����ֵΪ���ֵ
   assign res_cnt_last = (res_cnt_r == data_size);//����ֵΪ���ֵ
   //assign res_cnt_clr = custom3_res & nice_req_hsked;
   assign res_cnt_clr = res_icb_rsp_hsked_last;//����res_icb_rsp_hsked_last����ǰ״̬res��������Ӧ���֣�����ֵΪ���ֵ
   assign res_cnt_incr = res_icb_rsp_hsked & ~res_cnt_last;//��ǰ״̬res��������Ӧ���֣�����ֵ�������ֵ
   assign res_cnt_ena = res_cnt_clr | res_cnt_incr; //��ǰ״̬res��������Ӧ���֡�
   //��ǰ״̬res��������Ӧ���֣�������ֵΪ���ֵ��Ϊ2'b00������Ϊ���ڼ���ֵ+1��
   assign res_cnt_nxt =   ({DATA_WIDTH{res_cnt_clr }} & {DATA_WIDTH{1'b0}})
                         | ({DATA_WIDTH{res_cnt_incr}} & (res_cnt_r + 1'b1))
                         ;
   //D����������ʱ�������
   sirv_gnrl_dfflr #(DATA_WIDTH)   res_cnt_dfflr (res_cnt_ena, res_cnt_nxt, res_cnt_r, nice_clk, nice_rst_n);

   // nice_rsp_valid wait for nice_icb_rsp_valid in SBUF
   //��ǰ״̬res������ֵΪ���ֵ��E203����������Ӧ�ź�
   assign nice_rsp_valid_res = state_is_sm4_res & res_cnt_last & nice_icb_rsp_valid;
   
   //res_cmd������
   // -------------------------------------------------------
   // -- �Դ洢��д���������źŵļ���
   // -------------------------------------------------------
   wire [DATA_WIDTH-1:0] res_cmd_cnt_r;  //res_cmd�ּ���ֵ
   wire [DATA_WIDTH-1:0] res_cmd_cnt_nxt;//res_cmd�¸�����ֵ 
   wire res_cmd_cnt_clr;                   //��ǰ״̬res��������Ӧ���֣�res����ֵΪ���ֵ
   wire res_cmd_cnt_incr;                  //��ǰ״̬Ϊres����idle״ָ̬��Ϊres)�������������ֳɹ���subf_cmd����ֵ�������ֵ
   wire res_cmd_cnt_ena;                   //����ǰ״̬res��������Ӧ���֣�res����ֵΪ���ֵ���򣨵�ǰ״̬Ϊres����idle״ָ̬��Ϊres)�������������ֳɹ���subf_cmd����ֵ�������ֵ��
   wire res_cmd_cnt_last;                  //res_cmd����ֵΪ���ֵ

   assign res_cmd_cnt_last = (res_cmd_cnt_r == data_size); //res_cmd����ֵΪ���ֵ
   assign res_cmd_cnt_clr  = res_icb_rsp_hsked_last;     //��ǰ״̬res��������Ӧ���֣�res����ֵΪ���ֵ
   assign res_cmd_cnt_incr = res_icb_cmd_hsked & ~res_cmd_cnt_last;//��ǰ״̬Ϊres����idle״ָ̬��Ϊres)�������������ֳɹ���subf_cmd����ֵ�������ֵ
   assign res_cmd_cnt_ena = res_cmd_cnt_clr | res_cmd_cnt_incr;//����ǰ״̬res��������Ӧ���֣�res����ֵΪ���ֵ���򣨵�ǰ״̬Ϊres����idle״ָ̬��Ϊres)�������������ֳɹ���subf_cmd����ֵ�������ֵ��
   //��ǰ״̬res��������Ӧ���֣�res����Ϊ���ֵ��Ϊ2'b00����ǰ״̬Ϊres����idle״ָ̬��Ϊres)�������������ֳɹ���res_cmd����ֵ�������ֵ��Ϊres_cmd_cnt_r+1
   assign res_cmd_cnt_nxt =   ({DATA_WIDTH{res_cmd_cnt_clr }} & {DATA_WIDTH{1'b0}})
                             | ({DATA_WIDTH{res_cmd_cnt_incr}} & (res_cmd_cnt_r + 1'b1) );
   
   //D����������ʱ�������                          ;
   sirv_gnrl_dfflr #(DATA_WIDTH)   res_cmd_cnt_dfflr (res_cmd_cnt_ena, res_cmd_cnt_nxt, res_cmd_cnt_r, nice_clk, nice_rst_n);

   // nice_icb_cmd_valid sets when res_cmd_cnt_r is not full in SBUF
   //��ǰ״̬res��res_cmdС�ڵ������ֵ��res���������ֵ
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

   //�źŸ�ֵ
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

   //D����������ʱ�������
//   sirv_gnrl_dfflr #(DATA_WIDTH)   rowbuf_cnt_dfflr (rowbuf_cnt_ena, rowbuf_cnt_nxt, rowbuf_cnt_r, nice_clk, nice_rst_n);
  
   //rowsum��recieve data buffer
   // recieve data buffer, to make sure rowsum ops come from registers 
   wire rcv_data_buf_ena;
   wire rcv_data_buf_set;
   wire rcv_data_buf_clr;
   wire rcv_data_buf_valid;
   wire [`E203_XLEN-1:0] rcv_data_buf; 
   wire [DATA_WIDTH-1:0] rcv_data_buf_idx; 
   wire [DATA_WIDTH-1:0] rcv_data_buf_idx_nxt; 

   //�źŸ�ֵ
//   assign rcv_data_buf_set = rowbuf_icb_rsp_hsked;
//   assign rcv_data_buf_clr = rowbuf_rsp_hsked;
//   assign rcv_data_buf_ena = rcv_data_buf_clr | rcv_data_buf_set;
//   assign rcv_data_buf_idx_nxt =   ({DATA_WIDTH{rcv_data_buf_clr}} & {DATA_WIDTH{1'b0}})
//                                 | ({DATA_WIDTH{rcv_data_buf_set}} & rowbuf_cnt_r      );
//
//   //D����������ʱ�����������һ����ʹ���źŵ�һ��ʱ���ӳ٣��ڶ������������ݵĻ��壬�������Ƕ�rowbufд������
//   sirv_gnrl_dfflr #(1)       rcv_data_buf_valid_dfflr (1'b1, rcv_data_buf_ena, rcv_data_buf_valid, nice_clk, nice_rst_n);
//   sirv_gnrl_dfflr #(`E203_XLEN)   rcv_data_buf_dfflr (rcv_data_buf_ena, nice_icb_rsp_rdata, rcv_data_buf, nice_clk, nice_rst_n);
//   sirv_gnrl_dfflr #(DATA_WIDTH)   rowbuf_cnt_d_dfflr (rcv_data_buf_ena, rcv_data_buf_idx_nxt, rcv_data_buf_idx, nice_clk, nice_rst_n);
//
   // rowsum���ۼ���ģ��
   // rowsum accumulator 
   wire [`E203_XLEN-1:0] rowsum_acc_r;
   wire [`E203_XLEN-1:0] rowsum_acc_nxt;
   wire [`E203_XLEN-1:0] rowsum_acc_adder;
   wire rowsum_acc_ena;
   wire rowsum_acc_set;
   wire rowsum_acc_flg;
   wire nice_icb_cmd_valid_rowsum;
   wire [`E203_XLEN-1:0] rowsum_res;

   //rowsum���ۼӣ��źŸ�ֵ
   //rowsum_acc_flg��rcv_data_buf_idx���㣬���ϸ����ڵ�״̬Ϊrowsumʱ��������Ӧ���ֻ�E203����nice_rsp_ready�źţ�
//   assign rowsum_acc_set = rcv_data_buf_valid & (rcv_data_buf_idx == {DATA_WIDTH{1'b0}});//32'b0
//   assign rowsum_acc_flg = rcv_data_buf_valid & (rcv_data_buf_idx != {DATA_WIDTH{1'b0}});
//   assign rowsum_acc_adder = rcv_data_buf + rowsum_acc_r;/**************����Ҫ�ļӷ����㣻assign <�Ĵ������ͱ���> = <��ֵ���ʽ>��****/
//   assign rowsum_acc_ena = rowsum_acc_set | rowsum_acc_flg;
//   assign rowsum_acc_nxt =   ({`E203_XLEN{rowsum_acc_set}} & rcv_data_buf)
//                           | ({`E203_XLEN{rowsum_acc_flg}} & rowsum_acc_adder)
//                           ;
//   //D����������ʱ���ۼӵ�ʱ�����
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

   // keybuf��keybuf�����ݻ��棬lkey��д��
   // rowbuf access list:
   //  1. lkey will write to keybuf, write data comes from memory, data length is defined by key_size
   //  2. ldata will read from databuf, and store it to memory, data length is defined by data_size
   //  2. sbuf will read from rowbuf, and store it to memory, data length is defined by clonum 
   //  3. rowsum will accumulate data, and store to rowbuf, data length is defined by clonum 
   wire [`E203_XLEN-1:0] keybuf_r    [KEY_NUM-1:0]; //4��32λ������
   wire [`E203_XLEN-1:0] keybuf_wdat [KEY_NUM-1:0];//4��32λ������
   wire [KEY_NUM-1:0]    keybuf_we;                  //4λ�������
   wire [KEY_WIDTH-1:0]  keybuf_idx_mux;             //keybuf�����ѡ��
   wire [`E203_XLEN-1:0] keybuf_wdat_mux;            //keybuf��д������ѡ��
   wire keybuf_wr_mux;                               //keybuf��д���ź�ѡ��
   //wire [DATA_WIDTH-1:0] sbuf_idx; 
   
   // lkey write to keybuf
   wire [DATA_WIDTH-1:0] lkey_idx = lkey_cnt_r;            //lkeyд�����ţ�д�����ѡ��Ϊlkey_cnt_r����lkey������ʱ���������ǰ�ļ���ֵ����0��2
   wire lkey_wr = lkey_icb_rsp_hsked;                      //lkeyд���ʹ�ܣ�д��ʹ�ܣ�Ϊlkey_icb_rsp_hsked������ǰ״̬Ϊlkey��������Ӧ����
   wire [`E203_XLEN-1:0] lkey_wdata = nice_icb_rsp_rdata;  //lkeyд������ݣ�д�����ݣ��ⲿ����Ĵ�memory��ȡ������

   // rowsum write to rowbuf(column accumulated data)
 /*  wire [DATA_WIDTH-1:0] rowsum_idx = rcv_data_buf_idx;  //rowsumд�����ţ�д�����ѡ��Ϊrcv_data_buf_idx����ǰ�ļ���ֵ����0��2
   wire rowsum_wr = rcv_data_buf_valid;                    //rowsumд���ʹ�ܣ�д��ʹ�ܣ�Ϊrcv_data_buf-valid����rcv_data_buf_ena����һ��ʱ��
   wire [`E203_XLEN-1:0] rowsum_wdata = rowbuf_r[rowsum_idx] + rcv_data_buf; //	rowsumд������ݣ�д�����ݣ�Ϊrowbuf_r��ǰ������rcv_data_buf�ļӺ�*/

   // rowbuf write mux
   //д������ѡ��
   assign keybuf_wdat_mux =   ({`E203_XLEN{lkey_wr  }} & lkey_wdata  );
                           /* | ({`E203_XLEN{rowsum_wr}} & rowsum_wdata)
                            ;*/
   //д��ʹ��ѡ��lkey_wr
   assign keybuf_wr_mux   =  lkey_wr;// | rowsum_wr;
   //д�����ѡ����lkey_wrΪ�ߣ���Ϊlkey_idx
   assign keybuf_idx_mux  =   ({DATA_WIDTH{lkey_wr  }} & lkey_idx  );
                           /* | ({DATA_WIDTH{rowsum_wr}} & rowsum_idx)
                            ;  */
   
   //D����������ʱ��///
   //ʵ����16�������8λ��D������
   // keybuf inst
   genvar i;
   generate 
     for (i=0; i<KEY_NUM; i=i+1) begin:gen_keybuf
       //keybuf_weΪʹ���źţ�Ϊkeybuf_wr_mux��һ�����ʽ���룬i�ĵ�2λ��rowbuf_idx_mux��Ȳſ���
       assign keybuf_we[i] =   (keybuf_wr_mux & (keybuf_idx_mux == i[DATA_WIDTH-1:0]))
                             ;
       //keybuf_wdatΪ�������ݣ�ʹ��ʱΪkeybuf_wdat_mux
       assign keybuf_wdat[i] =   ({`E203_XLEN{keybuf_we[i]}} & keybuf_wdat_mux   )
                               ;
  
       sirv_gnrl_dfflr #(`E203_XLEN) keybuf_dfflr (keybuf_we[i], keybuf_wdat[i], keybuf_r[i], nice_clk, nice_rst_n);
     end
   endgenerate

//ldata write to databuf
   wire [`E203_XLEN-1:0] databuf_r    [DATA_NUM-1:0]; //4��32λ������
   wire [`E203_XLEN-1:0] databuf_wdat [DATA_NUM-1:0];//4��32λ������
   wire [DATA_NUM-1:0]    databuf_we;                  //4λ�������
   wire [DATA_WIDTH-1:0]  databuf_idx_mux;             //databuf�����ѡ��
   wire [`E203_XLEN-1:0] databuf_wdat_mux;            //databuf��д������ѡ��
   wire databuf_wr_mux;                               //databuf��д���ź�ѡ��
   //wire [DATA_WIDTH-1:0] sbuf_idx; 
   
   // ldata write to databuf
   wire [DATA_WIDTH-1:0] ldata_idx = ldata_cnt_r;            //ldataд�����ţ�д�����ѡ��Ϊldata_cnt_r����ldata������ʱ���������ǰ�ļ���ֵ����0��2
   wire ldata_wr = ldata_icb_rsp_hsked;                      //ldataд���ʹ�ܣ�д��ʹ�ܣ�Ϊldata_icb_rsp_hsked������ǰ״̬Ϊldata��������Ӧ����
   wire [`E203_XLEN-1:0] ldata_wdata = nice_icb_rsp_rdata;  //ldataд������ݣ�д�����ݣ��ⲿ����Ĵ�memory��ȡ������

   // rowsum write to rowbuf(column accumulated data)
 /*  wire [DATA_WIDTH-1:0] rowsum_idx = rcv_data_buf_idx;  //rowsumд�����ţ�д�����ѡ��Ϊrcv_data_buf_idx����ǰ�ļ���ֵ����0��2
   wire rowsum_wr = rcv_data_buf_valid;                    //rowsumд���ʹ�ܣ�д��ʹ�ܣ�Ϊrcv_data_buf-valid����rcv_data_buf_ena����һ��ʱ��
   wire [`E203_XLEN-1:0] rowsum_wdata = rowbuf_r[rowsum_idx] + rcv_data_buf; //	rowsumд������ݣ�д�����ݣ�Ϊrowbuf_r��ǰ������rcv_data_buf�ļӺ�*/

   // rowbuf write mux
   //д������ѡ��
   assign databuf_wdat_mux =   ({`E203_XLEN{ldata_wr  }} & ldata_wdata  );
                           /* | ({`E203_XLEN{rowsum_wr}} & rowsum_wdata)
                            ;*/
   //д��ʹ��ѡ��ldata_wr
   assign databuf_wr_mux   =  ldata_wr;// | rowsum_wr;
   //д�����ѡ����ldata_wrΪ�ߣ���Ϊldata_idx
   assign databuf_idx_mux  =   ({DATA_WIDTH{ldata_wr  }} & ldata_idx  );
                           /* | ({DATA_WIDTH{rowsum_wr}} & rowsum_idx)
                            ;  */
   
   //D����������ʱ��///
   //ʵ����16�������8λ��D������
   // databuf inst
   genvar j;
   generate 
     for (j=0; j<DATA_NUM; j=j+1) begin:gen_databuf
       //databuf_weΪʹ���źţ�Ϊdatabuf_wr_mux��һ�����ʽ���룬i�ĵ�2λ��rowbuf_idx_mux��Ȳſ���
       assign databuf_we[j] =   (databuf_wr_mux & (databuf_idx_mux == j[DATA_WIDTH-1:0]))
                             ;
       //databuf_wdatΪ�������ݣ�ʹ��ʱΪdatabuf_wdat_mux
       assign databuf_wdat[j] =   ({`E203_XLEN{databuf_we[j]}} & databuf_wdat_mux   )
                               ;
  
       sirv_gnrl_dfflr #(`E203_XLEN) databuf_dfflr (databuf_we[j], databuf_wdat[j], databuf_r[j], nice_clk, nice_rst_n);
     end
   endgenerate

   // mem aacess addr management��memory�ĵ�ַ
   wire [`E203_XLEN-1:0] maddr_acc_r; 
   assign nice_icb_cmd_hsked = nice_icb_cmd_valid & nice_icb_cmd_ready;   //������������
   // custom3_lkey��lkey������memory��ʹ��
   //����ǰ״̬Ϊidle������Ϊlkey�����Ҵ����������֣��򣨵�ǰ״̬lkey�������������֣�
   //wire [`E203_XLEN-1:0] lbuf_maddr    = state_is_idle ? nice_req_rs1 : maddr_acc_r ; 
   wire lkey_maddr_ena    =   (state_is_idle & custom3_load_key & nice_icb_cmd_hsked)
                            | (state_is_lkey & nice_icb_cmd_hsked)
                            ;

   wire ldata_maddr_ena   =   (state_is_idle & custom3_load_data & nice_icb_cmd_hsked)
                            | (state_is_ldata & nice_icb_cmd_hsked)
                            ;                       

   // custom3_sbuf ��sbuf������memory��ʹ��
   //����ǰ״̬Ϊidle������Ϊsbuf�����Ҵ����������֣��򣨵�ǰ״̬sbuf�������������֣�
   //wire [`E203_XLEN-1:0] sbuf_maddr    = state_is_idle ? nice_req_rs1 : maddr_acc_r ; 
   wire  res_maddr_ena    =   (state_is_idle & custom3_sm4_res & nice_icb_cmd_hsked)
                            | (state_is_sm4_res & nice_icb_cmd_hsked)
                            ;
/*
   // custom3_rowsum��	rowsum������memory��ʹ��
   //����ǰ״̬Ϊidle������Ϊrowsum�����Ҵ����������֣��򣨵�ǰ״̬rowsum�������������֣�
   //wire [`E203_XLEN-1:0] rowsum_maddr  = state_is_idle ? nice_req_rs1 : maddr_acc_r ; 
   wire rowsum_maddr_ena  =   (state_is_idle & custom3_rowsum & nice_icb_cmd_hsked)
                            | (state_is_rowsum & nice_icb_cmd_hsked)
                            ;
*/
   // maddr acc 
   //wire  maddr_incr = lbuf_maddr_ena | sbuf_maddr_ena | rowsum_maddr_ena | rbuf_maddr_ena;
   //����ǰ״̬Ϊidle��������Ч�����Ҵ����������֣��򣨵�ǰ״̬��idle�������������֣�
   wire  maddr_ena = lkey_maddr_ena | ldata_maddr_ena | res_maddr_ena;// | sbuf_maddr_ena | rowsum_maddr_ena;//����memory��ʹ��
   //��ǰ״̬Ϊidle������Ϊ��Ч�����Ҵ�����������
   wire  maddr_ena_idle = maddr_ena & state_is_idle;//����memory��ʹ�ܣ��ҵ�ǰ״̬Ϊidle
  
  //��ǰ״̬Ϊidle������Ϊ��Ч�����Ҵ����������֣�Ϊ�Ĵ���1ֵ������Ϊmaddr_acc_r.��ÿ�ζ�д���ڴ��ַ��μ�4
//maddr_acc_r��Ϊrs1�Ĵ�����ַÿ�μ�4��������Ϊ32/8=4������32λ���ݣ���memory����Ҫռ��4���ֽڡ�
   wire [`E203_XLEN-1:0] maddr_acc_op1 = maddr_ena_idle ? nice_req_rs1 : maddr_acc_r; // not reused
   //32/8 = 4������ÿ��Ҫ��4
   wire [`E203_XLEN-1:0] maddr_acc_op2 = maddr_ena_idle ? `E203_XLEN'h4 : `E203_XLEN'h4; 
   //��һ����ַ��Ϊ��ǰ��ַ+4
   wire [`E203_XLEN-1:0] maddr_acc_next = maddr_acc_op1 + maddr_acc_op2;//������1��������2
   wire  maddr_acc_ena = maddr_ena;  //	����memory��ʹ�ܣ�Ϊ����ǰ״̬Ϊidle��������Ч�����Ҵ����������֣��򣨵�ǰ״̬��idle�������������֣�
   
   //D��������ʹ���źţ�maddr_acc_ena���������ݣ�maddr_acc_next�������maddr_acc_r
   sirv_gnrl_dfflr #(`E203_XLEN)   maddr_acc_dfflr (maddr_acc_ena, maddr_acc_next, maddr_acc_r, nice_clk, nice_rst_n);

   
   // Control cmd_req
   
   assign nice_req_hsked = nice_req_valid & nice_req_ready;//������������
   //nice�������������������źţ���ǰ״̬��idle����ָ����Ч����Ϊnice_icb_cmd_ready������Ϊ1'b1
   assign nice_req_ready = state_is_idle & (custom_mem_op ? nice_icb_cmd_ready : 1'b1);

   
   // Control cmd_rsp
   
   assign nice_rsp_hsked = nice_rsp_valid & nice_rsp_ready; //������Ӧ����
   assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;//������Ӧ����
   //����ǰ״̬lbuf��lbuf����ֵΪ���ֵ��E203����������Ӧ�źţ��򣨵�ǰ״̬sbuf��sbuf����ֵΪ���ֵ��E203����������Ӧ�źţ��򣨵�ǰ״̬rowsum��rcv_data_buf_idx����ֵΪ���ֵ��rowsum_acc_flgΪ�ͣ���rcv_data_buf_idx���㣬���ϸ����ڵ�״̬Ϊrowsumʱ��������Ӧ���ֻ�E203����nice_rsp_ready�źţ���
   assign nice_rsp_valid = nice_rsp_valid_lkey | nice_rsp_valid_ldata | nice_rsp_valid_res | nice_rsp_valid_enc | nice_rsp_valid_dec;
   //| nice_rsp_valid_sdata | nice_rsp_valid_rowsum;//������Ӧ��Ч
   assign nice_rsp_rdat  = `E203_XLEN'd0; //{`E203_XLEN{state_is_rowsum}} & rowsum_res;//��ǰ״̬ΪrowsumʱΪrowsum_res

   // memory access bus error
   //assign nice_rsp_err_irq  =   (nice_icb_rsp_hsked & nice_icb_rsp_err)
   //                          | (nice_req_hsked & illgel_instr)
   //                          ; 
   assign nice_rsp_err   =   (nice_icb_rsp_hsked & nice_icb_rsp_err);//������Ӧ�������ڷ���memoryʱ����

   
   // Memory lsu��memory���
   
   // memory access list:
   //  1. In IDLE, custom_mem_op will access memory(lbuf/sbuf/rowsum)
   //  2. In LBUF, it will read from memory as long as lbuf_cnt_r is not full
   //  3. In SBUF, it will write to memory as long as sbuf_cnt_r is not full
   //  3. In ROWSUM, it will read from memory as long as rowsum_cnt_r is not full
   //assign nice_icb_rsp_ready = state_is_ldst_rsp & nice_rsp_ready; 
   // rsp always ready
   reg   [`E203_XLEN-1:0] resbuf_r    [DATA_NUM-1:0];
   assign nice_icb_rsp_ready = 1'b1; //ʼ��Ϊ1'b1
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
   //����ǰ״̬Ϊidle��E203����nice_req_valid��ָ����Ч����״̬lbuf��lbuf����ֵС�����ֵ����״̬sbuf��sbuf_cmdС�ڵ������ֵ��sbuf����ֵ�������ֵ����״̬rowsum��rcv_data_buf����ֵС�����ֵ���ң�rcv_data_buf_idx���㣬���ϸ����ڵ�״̬Ϊrowsumʱ��������Ӧ���ֻ�E203����nice_rsp_ready�źţ���
   assign nice_icb_cmd_valid =   (state_is_idle & nice_req_valid & custom_mem_op)
                              | nice_icb_cmd_valid_lkey
                              | nice_icb_cmd_valid_ldata
                              | nice_icb_cmd_valid_res
//                              | nice_icb_cmd_valid_rowsum
                              ;

   assign nice_icb_cmd_addr  = (state_is_idle & custom_mem_op) ? nice_req_rs1 :
                              maddr_acc_r;//��״̬idle��������Ч��Ϊ�Ĵ���1������Ϊmaddr_acc_r

   assign nice_icb_cmd_read  = (state_is_idle & custom_mem_op) ? (custom3_load_key | custom3_load_data) : 
                              state_is_sm4_res ? 1'b0 : 
                              1'b1;//��״̬idle��Ϊlkey��ldataָ�Ϊ1��Ϊsm4_resָ�Ϊ0��������Ϊsm4_res״̬Ϊ0������Ϊ1
   assign nice_icb_cmd_wdata = (state_is_idle & custom3_sm4_res) ? resbuf_r[sbuf_idx] :
                              state_is_sm4_res ? resbuf_r[sbuf_idx] : 
                              `E203_XLEN'b0; //��״̬idle��sbufָ���subf״̬��Ϊrowbuf_r[sbuf_idx]������Ϊ0

   //assign nice_icb_cmd_wmask = {`sirv_XLEN_MW{custom3_sbuf}} & 4'b1111;
   assign nice_icb_cmd_size  = 2'b10;//Ϊ2������4�ֽ�32λ������
   assign nice_mem_holdup    =  state_is_lkey | state_is_ldata | state_is_sm4_res | state_is_encrypt | state_is_decrypt; //Ϊ��idle״̬������memory��

   
   // nice_active
   
   assign nice_active = state_is_idle ? nice_req_valid : 1'b1;

endmodule
`endif//}
