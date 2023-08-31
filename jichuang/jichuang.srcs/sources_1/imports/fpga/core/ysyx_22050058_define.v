/*
 * @Author: ysyx_22050058_wenjiabao
 * @Date: 2022-09-26 11:11:53
 * @LastEditTime: 2022-11-30 15:45:03
 * @Description: define file for ysyx_22050058
 * 
 * Copyright (c) 2022 by WenJiaBao wenjiabao0919@131.com, All Rights Reserved. 
 */




//*********************GLOABAL DEFINE*********************//

`define ysyx_22050058_RstEnable         1'b1
`define ysyx_22050058_RstDisable        1'b0
`define ysyx_22050058_WriteEnable       1'b1
`define ysyx_22050058_WriteDisable      1'b0
`define ysyx_22050058_ReadEnable        1'b1
`define ysyx_22050058_ReadDisable       1'b0
`define ysyx_22050058_MemWriteEnable    1'b1
`define ysyx_22050058_MemWriteDisable   1'b0
`define ysyx_22050058_MemReadEnable     1'b1
`define ysyx_22050058_MemReadDisable    1'b0
`define ysyx_22050058_MemReadVaild      1'b1
`define ysyx_22050058_MemReadnVaild     1'b0
`define ysyx_22050058_MemWriteVaild     1'b1
`define ysyx_22050058_MemWritenVaild    1'b0
`define ysyx_22050058_InstValid         1'b1
`define ysyx_22050058_InstnVaild        1'b0
`define ysyx_22050058_True              1'b1
`define ysyx_22050058_False             1'b0
`define ysyx_22050058_ChipEnable        1'b1
`define ysyx_22050058_ChipDisable       1'b0
`define ysyx_22050058_AluOpBus          7:0
`define ysyx_22050058_StoreSelBus       7:0
`define ysyx_22050058_AluOpBusNum       8
`define ysyx_22050058_StoreSelBusNum    8
`define ysyx_22050058_AluSelBus         2:0
`define ysyx_22050058_AluSelBusNum      3
`define ysyx_22050058_StallEnable       1'b1
`define ysyx_22050058_StallDisable      1'b0
`define ysyx_22050058_FlushEnable       1'b1
`define ysyx_22050058_FlushDisable      1'b0
`define ysyx_22050058_IsJump            1'b1
`define ysyx_22050058_NoJump            1'b0
`define ysyx_22050058_RegBUS            31:0
`define ysyx_22050058_RegAddrBus        31:0
`define ysyx_22050058_RegBUSNum         6
`define ysyx_22050058_RegAddrBusNum     5
`define ysyx_22050058_StoreSelBus       7:0

`define ysyx_22050058_InstAdderBus      31:0
`define ysyx_22050058_InstBus           31:0
`define ysyx_22050058_InstLen           32
`define ysyx_22050058_InstAdderBusNum   64
`define ysyx_22050058_RegNum            32
`define ysyx_22050058_RegNumLog2        5
`define ysyx_22050058_InstMemNum        4294
`define ysyx_22050058_InstMemNumLog2    31
`define ysyx_22050058_MemBUS            31:0
`define ysyx_22050058_MemAddrBus        31:0
`define ysyx_22050058_ZeroWord          'b0
`define ysyx_22050058_RstVector         `ysyx_22050058_InstAdderBusNum'h80000000
`define ysyx_22050058_ECALL             32'h999
`define ysyx_22050058_MEPC              32'h341
`define ysyx_22050058_MTVEC             32'h305
`define ysyx_22050058_MCAUSE            32'h342
`define ysyx_22050058_MSTATUS           32'h300

`define ysyx_22050058_NOP_REG_Addr      32'b0
`define ysyx_22050058_DPICNOSTOP        1'b0
`define ysyx_22050058_DPICSTOP          1'b1
//***************************InstBuffer***************************//
`define ysyx_22050058_InstBufferNum     8
`define ysyx_22050058_InstBufferNumLog  3
`define ysyx_22050058_SingleIssue       1'b0
`define ysyx_22050058_DualIssue         1'b1
//***************************Bpu***************************//
`define ysyx_22050058_BHRLEN           13
`define ysyx_22050058_BHR_BUS          `ysyx_22050058_BHRLEN-1:0
`define ysyx_22050058_BTB_BRANCHOP     3'b000
`define ysyx_22050058_BTB_RETOP        3'b001
`define ysyx_22050058_BTB_CSROP        3'b010
`define ysyx_22050058_BTB_CALLOP       3'b011
`define ysyx_22050058_BTB_CALLANDRETOP 3'b100
`define ysyx_22050058_BTB_JALOP        3'b101
`define ysyx_22050058_BTB_BxxOP        3'b110
//***************************Cache***************************//
`define ysyx_22050058_CacheAddrBus      31:0
`define ysyx_22050058_CacheAddrBus2     31:0
`define ysyx_22050058_CacheDataBUS      31:0
`define ysyx_22050058_CacheDataBUS2     31:0
`define ysyx_22050058_CacheWayBUS       255:0
`define ysyx_22050058_CacheBankBus      127:0
`define ysyx_22050058_CacheBankBusSel   127:0
`define ysyx_22050058_PLRU_BUS          31:0
`define ysyx_22050058_Dirty_BUS         127:0
`define ysyx_22050058_CacheIndexBus     10:5
`define ysyx_22050058_CacheTagBus       31:11
`define ysyx_22050058_CacheTagVBus      53:0
`define ysyx_22050058_CacheWay0Pick     1'b0
`define ysyx_22050058_CacheWay1Pick     1'b1
`define ysyx_22050058_CacheHit          1'b1
`define ysyx_22050058_CacheNotHit       1'b0
`define ysyx_22050058_BufferHit          1'b1
`define ysyx_22050058_BufferNotHit       1'b0
`define ysyx_22050058_BUFFER_EMPTY      2'b00
`define ysyx_22050058_BUFFER_WORK       2'b01
`define ysyx_22050058_BUFFER_FULL       2'b11
`define ysyx_22050058_WriteSelBus       7:0

`define ysyx_22050058_CACHEAXI_RIDLE         3'd0
`define ysyx_22050058_CACHEAXI_WIDLE         3'd0
`define ysyx_22050058_CACHEAXI_UNDCACHEREAD  3'd1
`define ysyx_22050058_CACHEAXI_UNDCACHEWRITE 3'd1
`define ysyx_22050058_CACHEAXI_DCACHEREAD    3'd2
`define ysyx_22050058_CACHEAXI_DCACHEWRITE   3'd2
`define ysyx_22050058_CACHEAXI_UNICACHEREAD  3'd3
`define ysyx_22050058_CACHEAXI_ICACHEREAD    3'd4
`define ysyx_22050058_CACHEPIPE_DCACHE       2'b1
`define ysyx_22050058_CACHEPIPE_DUNCACHE     2'b10

`define ysyx_22050058_DCACHENOMAL                 3'd0
`define ysyx_22050058_INVALIDREADCACHE            3'd1
`define ysyx_22050058_INVALIDCACHECHECKANDWRITE   3'd2
`define ysyx_22050058_INVALIDCACHEINCR            3'd3
`define ysyx_22050058_DCACHEINVALIDFINISH         3'd4
//***********************Instruction**********************//

//*******Instruction Opcode********//
`define ysyx_22050058_INST_TYPE_I                7'b0010011
`define ysyx_22050058_INST_TYPE_ILD              7'b0000011
`define ysyx_22050058_INST_TYPE_I64              7'b0011011
`define ysyx_22050058_INST_TYPE_R                7'b0110011
`define ysyx_22050058_INST_TYPE_R64              7'b0111011
`define ysyx_22050058_INST_TYPE_B                7'b1100011
`define ysyx_22050058_INST_TYPE_S                7'b0100011
`define ysyx_22050058_INST_Fence                 7'b0001111
`define ysyx_22050058_INST_JAL                   7'b1101111
`define ysyx_22050058_INST_JALR                  7'b1100111
`define ysyx_22050058_INST_AUIPC                 7'b0010111
`define ysyx_22050058_INST_LUI                   7'b0110111

`define ysyx_22050058_INST_CSR                   7'b1110011
//*******Instruction Funct3********//
`define ysyx_22050058_INST_JALRFUN3              3'b000
`define ysyx_22050058_INST_ADDFUN3               3'b000
`define ysyx_22050058_INST_ADDI                  3'b000 
`define ysyx_22050058_INST_ADDIW                 3'b000
`define ysyx_22050058_INST_ADDWFUN3              3'b000
`define ysyx_22050058_INST_SUBFUN3               3'b000
`define ysyx_22050058_INST_SUBWFUN3              3'b000
`define ysyx_22050058_INST_ANDFUN3               3'b111
`define ysyx_22050058_INST_ORFUN3                3'b110
`define ysyx_22050058_INST_XORFUN3               3'b100
`define ysyx_22050058_INST_ANDI                  3'b111
`define ysyx_22050058_INST_ORI                   3'b110
`define ysyx_22050058_INST_XORI                  3'b100
`define ysyx_22050058_INST_SLTFUN3               3'b010
`define ysyx_22050058_INST_SLTI                  3'b010
`define ysyx_22050058_INST_SLTIU                 3'b011
`define ysyx_22050058_INST_SLTUFUN3              3'b011
`define ysyx_22050058_INST_SLLIFUN3              3'b001
`define ysyx_22050058_INST_SRAIFUN3              3'b101
`define ysyx_22050058_INST_SRLIFUN3              3'b101
`define ysyx_22050058_INST_SLLIWFUN3             3'b001
`define ysyx_22050058_INST_SRLIWFUN3             3'b101
`define ysyx_22050058_INST_SRAIWFUN3             3'b101
`define ysyx_22050058_INST_SLLFUN3               3'b001
`define ysyx_22050058_INST_SRAFUN3               3'b101
`define ysyx_22050058_INST_SRLFUN3               3'b101
`define ysyx_22050058_INST_SLLWFUN3              3'b001
`define ysyx_22050058_INST_SRLWFUN3              3'b101
`define ysyx_22050058_INST_SRAWFUN3              3'b101
`define ysyx_22050058_INST_BEQ                   3'b000
`define ysyx_22050058_INST_BNE                   3'b001
`define ysyx_22050058_INST_BLT                   3'b100
`define ysyx_22050058_INST_BGE                   3'b101
`define ysyx_22050058_INST_BLTU                  3'b110
`define ysyx_22050058_INST_BGEU                  3'b111

`define ysyx_22050058_INST_MULFUN3               3'b000
`define ysyx_22050058_INST_MULHFUN3              3'b001
`define ysyx_22050058_INST_MULHSUFUN3            3'b010
`define ysyx_22050058_INST_MULHUFUN3             3'b011
`define ysyx_22050058_INST_DIVFUN3               3'b100
`define ysyx_22050058_INST_DIVUFUN3              3'b101
`define ysyx_22050058_INST_REMFUN3               3'b110
`define ysyx_22050058_INST_REMUFUN3              3'b111
`define ysyx_22050058_INST_MULWFUN3              3'b000
`define ysyx_22050058_INST_DIVWFUN3              3'b100
`define ysyx_22050058_INST_DIVUWFUN3             3'b101
`define ysyx_22050058_INST_REMWFUN3              3'b110
`define ysyx_22050058_INST_REMUWFUN3             3'b111

`define ysyx_22050058_INST_LB                    3'b000
`define ysyx_22050058_INST_LH                    3'b001
`define ysyx_22050058_INST_LW                    3'b010
`define ysyx_22050058_INST_LD                    3'b011
`define ysyx_22050058_INST_LBU                   3'b100
`define ysyx_22050058_INST_LHU                   3'b101
`define ysyx_22050058_INST_LWU                   3'b110
`define ysyx_22050058_INST_SB                    3'b000
`define ysyx_22050058_INST_SH                    3'b001
`define ysyx_22050058_INST_SW                    3'b010
`define ysyx_22050058_INST_SD                    3'b011

`define ysyx_22050058_INST_NOP                   3'b000
`define ysyx_22050058_INST_ENVIRONMENT           3'b000
`define ysyx_22050058_INST_CSRRC                 3'b011
`define ysyx_22050058_INST_CSRRS                 3'b010
`define ysyx_22050058_INST_CSRRW                 3'b001

//*******Instruction Funct6********//
`define ysyx_22050058_INST_SLLI                  6'b000000
`define ysyx_22050058_INST_SRAI                  6'b010000
`define ysyx_22050058_INST_SRLI                  6'b000000
`define ysyx_22050058_INST_SLLIW                 6'b000000
`define ysyx_22050058_INST_SRLIW                 6'b000000
`define ysyx_22050058_INST_SRAIW                 6'b010000
//*******Instruction Funct7********//
`define ysyx_22050058_INST_ADD                   7'b0000000
`define ysyx_22050058_INST_ADDW                  7'b0000000
`define ysyx_22050058_INST_SUB                   7'b0100000
`define ysyx_22050058_INST_SUBW                  7'b0100000
`define ysyx_22050058_INST_AND                   7'b0000000
`define ysyx_22050058_INST_OR                    7'b0000000
`define ysyx_22050058_INST_XOR                   7'b0000000
`define ysyx_22050058_INST_SLT                   7'b0000000
`define ysyx_22050058_INST_SLTU                  7'b0000000
`define ysyx_22050058_INST_SLL                   7'b0000000
`define ysyx_22050058_INST_SRA                   7'b0100000
`define ysyx_22050058_INST_SRL                   7'b0000000
`define ysyx_22050058_INST_SLLW                  7'b0000000
`define ysyx_22050058_INST_SRLW                  7'b0000000
`define ysyx_22050058_INST_SRAW                  7'b0100000
`define ysyx_22050058_INST_MDU                   7'b0000001

//*******Instruction Funct12********//
`define ysyx_22050058_INST_EBREAK                12'b000000000001
`define ysyx_22050058_INST_ECALL                 12'b000000000000
`define ysyx_22050058_INST_MRET                  12'b001100000010
//***********************AluOpcode***********************//
`define ysyx_22050058_ALU_NOP_OP                 `ysyx_22050058_AluOpBusNum'd0
`define ysyx_22050058_ALU_ADD_OP                 `ysyx_22050058_AluOpBusNum'd0
`define ysyx_22050058_ALU_SUB_OP                 `ysyx_22050058_AluOpBusNum'd1
`define ysyx_22050058_ALU_AND_OP                 `ysyx_22050058_AluOpBusNum'd2
`define ysyx_22050058_ALU_OR_OP                  `ysyx_22050058_AluOpBusNum'd3
`define ysyx_22050058_ALU_XOR_OP                 `ysyx_22050058_AluOpBusNum'd4
`define ysyx_22050058_ALU_COMP_OP                `ysyx_22050058_AluOpBusNum'd5
`define ysyx_22050058_ALU_COMPU_OP               `ysyx_22050058_AluOpBusNum'd6
`define ysyx_22050058_ALU_SLL_OP                 `ysyx_22050058_AluOpBusNum'd7
`define ysyx_22050058_ALU_SRL_OP                 `ysyx_22050058_AluOpBusNum'd8
`define ysyx_22050058_ALU_SRA_OP                 `ysyx_22050058_AluOpBusNum'd9
`define ysyx_22050058_ALU_BEQ_OP                 `ysyx_22050058_AluOpBusNum'd10
`define ysyx_22050058_ALU_BNE_OP                 `ysyx_22050058_AluOpBusNum'd11
`define ysyx_22050058_ALU_BLT_OP                 `ysyx_22050058_AluOpBusNum'd12
`define ysyx_22050058_ALU_BGE_OP                 `ysyx_22050058_AluOpBusNum'd13
`define ysyx_22050058_ALU_BLTU_OP                `ysyx_22050058_AluOpBusNum'd14
`define ysyx_22050058_ALU_BGEU_OP                `ysyx_22050058_AluOpBusNum'd15
`define ysyx_22050058_ALU_JAL_OP                 `ysyx_22050058_AluOpBusNum'd16
`define ysyx_22050058_ALU_JALR_OP                `ysyx_22050058_AluOpBusNum'd17
`define ysyx_22050058_ALU_AUIPC_OP               `ysyx_22050058_AluOpBusNum'd18
`define ysyx_22050058_ALU_LUI_OP                 `ysyx_22050058_AluOpBusNum'd19
`define ysyx_22050058_ALU_LB_OP                  `ysyx_22050058_AluOpBusNum'd20
`define ysyx_22050058_ALU_LH_OP                  `ysyx_22050058_AluOpBusNum'd21
`define ysyx_22050058_ALU_LW_OP                  `ysyx_22050058_AluOpBusNum'd22
`define ysyx_22050058_ALU_LD_OP                  `ysyx_22050058_AluOpBusNum'd23
`define ysyx_22050058_ALU_LBU_OP                 `ysyx_22050058_AluOpBusNum'd24
`define ysyx_22050058_ALU_LHU_OP                 `ysyx_22050058_AluOpBusNum'd25
`define ysyx_22050058_ALU_LWU_OP                 `ysyx_22050058_AluOpBusNum'd26
`define ysyx_22050058_ALU_SB_OP                  `ysyx_22050058_AluOpBusNum'd27
`define ysyx_22050058_ALU_SH_OP                  `ysyx_22050058_AluOpBusNum'd28
`define ysyx_22050058_ALU_SW_OP                  `ysyx_22050058_AluOpBusNum'd29
`define ysyx_22050058_ALU_SD_OP                  `ysyx_22050058_AluOpBusNum'd30
`define ysyx_22050058_ALU_SLLW_OP                `ysyx_22050058_AluOpBusNum'd31
`define ysyx_22050058_ALU_SRLW_OP                `ysyx_22050058_AluOpBusNum'd32
`define ysyx_22050058_ALU_SRAW_OP                `ysyx_22050058_AluOpBusNum'd33
`define ysyx_22050058_ALU_MUL_OP                 `ysyx_22050058_AluOpBusNum'd34
`define ysyx_22050058_ALU_MULH_OP                `ysyx_22050058_AluOpBusNum'd35
`define ysyx_22050058_ALU_MULHSU_OP              `ysyx_22050058_AluOpBusNum'd36
`define ysyx_22050058_ALU_MULHU_OP               `ysyx_22050058_AluOpBusNum'd37
`define ysyx_22050058_ALU_DIV_OP                 `ysyx_22050058_AluOpBusNum'd38
`define ysyx_22050058_ALU_DIVU_OP                `ysyx_22050058_AluOpBusNum'd39
`define ysyx_22050058_ALU_DIVW_OP                `ysyx_22050058_AluOpBusNum'd40
`define ysyx_22050058_ALU_DIVUW_OP               `ysyx_22050058_AluOpBusNum'd41
`define ysyx_22050058_ALU_REM_OP                 `ysyx_22050058_AluOpBusNum'd42
`define ysyx_22050058_ALU_REMU_OP                `ysyx_22050058_AluOpBusNum'd43
`define ysyx_22050058_ALU_REMW_OP                `ysyx_22050058_AluOpBusNum'd44
`define ysyx_22050058_ALU_REMUW_OP               `ysyx_22050058_AluOpBusNum'd45
`define ysyx_22050058_ALU_ECALL_OP               `ysyx_22050058_AluOpBusNum'd46
`define ysyx_22050058_ALU_MRET_OP                `ysyx_22050058_AluOpBusNum'd47
`define ysyx_22050058_ALU_CSRRC_OP               `ysyx_22050058_AluOpBusNum'd48
`define ysyx_22050058_ALU_CSRRS_OP               `ysyx_22050058_AluOpBusNum'd49
`define ysyx_22050058_ALU_CSRRW_OP               `ysyx_22050058_AluOpBusNum'd50
`define ysyx_22050058_Fencei_OP                   `ysyx_22050058_AluOpBusNum'd51
//*************************AluSel*************************//
`define ysyx_22050058_ALU_NOP_SEL                `ysyx_22050058_AluSelBusNum'd0
`define ysyx_22050058_ALU_ARITHMETIC_SEL         `ysyx_22050058_AluSelBusNum'd0
`define ysyx_22050058_ALU_LOGIC_SEL              `ysyx_22050058_AluSelBusNum'd1
`define ysyx_22050058_ALU_64W_SEL                `ysyx_22050058_AluSelBusNum'd2
`define ysyx_22050058_ALU_LOAD_SEL               `ysyx_22050058_AluSelBusNum'd3
`define ysyx_22050058_ALU_STORE_SEL              `ysyx_22050058_AluSelBusNum'd4
`define ysyx_22050058_ALU_64LOGICW_SEL           `ysyx_22050058_AluSelBusNum'd5
`define ysyx_22050058_ALU_CSR_SEL                `ysyx_22050058_AluSelBusNum'd6

//*************************END*************************//
//AXI
`define AXRESP_OKAY             2'b00
`define AXRESP_EXOKAY           2'b01
`define AXRESP_SLVERR           2'b10
`define AXI_ARCACHE_NORMAL_NON_CACHEABLE_NON_BUFFERABLE 2'b11

`define AXLOCK_EXCLUSIVE        2'b01
`define AXLOCK_LOCKED           2'b10

`define AXBURST_FIXED           2'b00
`define AXI_BURST_TYPE_INCR     2'b01
`define AXBURST_WRAP            2'b10

`define AXSIZE_FOUR_BYTE        3'b010

`define AXCACHE_REG_BUFFER      2'b00
`define AXCACHE_REG_CACHE       2'b01
`define AXCACHE_REG_READ_ALCT   2'b10
`define AXCACHE_REG_WRITE_ALCT  2'b11

`define AXPROT_REG_NORM_OR_PRI  2'b00
`define AXPROT_REG_SEC_OR_NSEC  2'b10
`define AXPROT_REG_INST_OR_DATA 2'b01
//burst
`define AXSIZE   2:0
`define AXLEN    3:0
`define AXBURST  1:0
`define AXI_IDLE 3'b000
`define ARREADY  3'b001   //wait for arready
`define RVALID   3'b010   //wait for rvalid
`define RLAST    3'b011   //wait for rlast
`define AWREADY  3'b100   //wait for awready
`define WREADY   3'b101   //wair for wready    
`define BVALID   3'b110   //wait for bvalid
