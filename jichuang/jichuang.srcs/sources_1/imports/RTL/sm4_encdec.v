`timescale 1ns / 100ps

module sm4_encdec(
    clk                 ,
    reset_n             ,
    sm4_enable_in       ,
    encdec_enable_in    ,
    key_exp_ready_in    ,
    valid_in            ,
    data_in             ,
    keyi_00_in            ,
    keyi_01_in            ,
    keyi_02_in            ,
    keyi_03_in            ,
    keyi_04_in            ,
    keyi_05_in            ,
    keyi_06_in            ,
    keyi_07_in            ,
    keyi_08_in            ,
    keyi_09_in            ,
    keyi_10_in            ,
    keyi_11_in            ,
    keyi_12_in            ,
    keyi_13_in            ,
    keyi_14_in            ,
    keyi_15_in            ,
    keyi_16_in            ,
    keyi_17_in            ,
    keyi_18_in            ,
    keyi_19_in            ,
    keyi_20_in            ,
    keyi_21_in            ,
    keyi_22_in            ,
    keyi_23_in            ,
    keyi_24_in            ,
    keyi_25_in            ,
    keyi_26_in            ,
    keyi_27_in            ,
    keyi_28_in            ,
    keyi_29_in            ,
    keyi_30_in            ,
    keyi_31_in            ,
    ready_out           ,
    result_out      
);
    input			 clk		        ;
    input			 reset_n	        ;
    input            sm4_enable_in      ;
    input            encdec_enable_in   ;
    input            key_exp_ready_in   ;
    input            valid_in           ;
    input   [127: 0] data_in            ;
    input   [31 : 0] keyi_00_in           ;
    input   [31 : 0] keyi_01_in           ;
    input   [31 : 0] keyi_02_in           ;
    input   [31 : 0] keyi_03_in           ;
    input   [31 : 0] keyi_04_in           ;
    input   [31 : 0] keyi_05_in           ;
    input   [31 : 0] keyi_06_in           ;
    input   [31 : 0] keyi_07_in           ;
    input   [31 : 0] keyi_08_in           ;
    input   [31 : 0] keyi_09_in           ;
    input   [31 : 0] keyi_10_in           ;
    input   [31 : 0] keyi_11_in           ;
    input   [31 : 0] keyi_12_in           ;
    input   [31 : 0] keyi_13_in           ;
    input   [31 : 0] keyi_14_in           ;
    input   [31 : 0] keyi_15_in           ;
    input   [31 : 0] keyi_16_in           ;
    input   [31 : 0] keyi_17_in           ;
    input   [31 : 0] keyi_18_in           ;
    input   [31 : 0] keyi_19_in           ;
    input   [31 : 0] keyi_20_in           ;
    input   [31 : 0] keyi_21_in           ;
    input   [31 : 0] keyi_22_in           ;
    input   [31 : 0] keyi_23_in           ;
    input   [31 : 0] keyi_24_in           ;
    input   [31 : 0] keyi_25_in           ;
    input   [31 : 0] keyi_26_in           ;
    input   [31 : 0] keyi_27_in           ;
    input   [31 : 0] keyi_28_in           ;
    input   [31 : 0] keyi_29_in           ;
    input   [31 : 0] keyi_30_in           ;
    input   [31 : 0] keyi_31_in           ;
    output  [127: 0] result_out         ;   
    output           ready_out          ;
    
    reg     [127 : 0] reg_result_00     ;
    reg     [127 : 0] reg_result_01     ;
    reg     [127 : 0] reg_result_02     ;
    reg     [127 : 0] reg_result_03     ;
    reg     [127 : 0] reg_result_04     ;
    reg     [127 : 0] reg_result_05     ;
    reg     [127 : 0] reg_result_06     ;
    reg     [127 : 0] reg_result_07     ;
    reg     [127 : 0] reg_result_08     ;
    reg     [127 : 0] reg_result_09     ;
    reg     [127 : 0] reg_result_10     ;
    reg     [127 : 0] reg_result_11     ;
    reg     [127 : 0] reg_result_12     ;
    reg     [127 : 0] reg_result_13     ;
    reg     [127 : 0] reg_result_14     ;
    reg     [127 : 0] reg_result_15     ;
    reg     [127 : 0] reg_result_16     ;
    reg     [127 : 0] reg_result_17     ;
    reg     [127 : 0] reg_result_18     ;
    reg     [127 : 0] reg_result_19     ;
    reg     [127 : 0] reg_result_20     ;
    reg     [127 : 0] reg_result_21     ;
    reg     [127 : 0] reg_result_22     ;
    reg     [127 : 0] reg_result_23     ;
    reg     [127 : 0] reg_result_24     ;
    reg     [127 : 0] reg_result_25     ;
    reg     [127 : 0] reg_result_26     ;
    reg     [127 : 0] reg_result_27     ;
    reg     [127 : 0] reg_result_28     ;
    reg     [127 : 0] reg_result_29     ;
    reg     [127 : 0] reg_result_30     ;
    reg     [127 : 0] result_out        ;
    reg     [31  : 0] reg_tmp           ;
    wire    [31  : 0] word_0            ;
    wire    [31  : 0] word_1            ;
    wire    [31  : 0] word_2            ;
    wire    [31  : 0] word_3            ;
    wire    [127 : 0] reversed_result_31;
    wire    [127 : 0] result_00         ;
    wire    [127 : 0] result_01         ;
    wire    [127 : 0] result_02         ;
    wire    [127 : 0] result_03         ;
    wire    [127 : 0] result_04         ;
    wire    [127 : 0] result_05         ;
    wire    [127 : 0] result_06         ;
    wire    [127 : 0] result_07         ;
    wire    [127 : 0] result_08         ;
    wire    [127 : 0] result_09         ;
    wire    [127 : 0] result_10         ;
    wire    [127 : 0] result_11         ;
    wire    [127 : 0] result_12         ;
    wire    [127 : 0] result_13         ;
    wire    [127 : 0] result_14         ;
    wire    [127 : 0] result_15         ;
    wire    [127 : 0] result_16         ;
    wire    [127 : 0] result_17         ;
    wire    [127 : 0] result_18         ;
    wire    [127 : 0] result_19         ;
    wire    [127 : 0] result_20         ;
    wire    [127 : 0] result_21         ;
    wire    [127 : 0] result_22         ;
    wire    [127 : 0] result_23         ;
    wire    [127 : 0] result_24         ;
    wire    [127 : 0] result_25         ;
    wire    [127 : 0] result_26         ;
    wire    [127 : 0] result_27         ;
    wire    [127 : 0] result_28         ;
    wire    [127 : 0] result_29         ;
    wire    [127 : 0] result_30         ;
    wire    [127 : 0] result_31         ;
    reg     [1   : 0] current           ;
    reg     [1   : 0] next              ;
    
    `define IDLE                2'b00
    `define WAITING_FOR_KEY     2'b01
    `define ENCRYPTION          2'b10
    
    always@(posedge clk or negedge reset_n)
    if(!reset_n)
        current <= `IDLE;
    else if(sm4_enable_in)
            current <= next;
        else 
            current <= `IDLE;
        
    always@(*)        
        begin
            next = `IDLE;
            case(current)
                `IDLE :
                        if(sm4_enable_in && encdec_enable_in)
                            next = `WAITING_FOR_KEY;
                        else
                            next = `IDLE;
                `WAITING_FOR_KEY :
                        if(key_exp_ready_in)
                            next = `ENCRYPTION;
                        else
                            next = `WAITING_FOR_KEY;
                `ENCRYPTION :
                        if(!encdec_enable_in || !sm4_enable_in)
                            next = `IDLE;
                        else 
                            next = `ENCRYPTION;
                default :
                        next = `IDLE;
            endcase
        end

     //���sm4�������ڹ�������ÿһ�ֵ�����ʱ��ͻὫ��Ӧ����������reg_tmp[i]��Ϊ1����i=31ʱ��˵���Ѿ������32�ֵ�������ʱready_out��Ϊ1����ʾ�������           
    always@(posedge clk or negedge reset_n)
    if(!reset_n)
        reg_tmp <= 32'b0;
    else if(current == `ENCRYPTION && valid_in)
        reg_tmp <= {reg_tmp[30 : 0], 1'b1};
    else
        reg_tmp <= {reg_tmp[30 : 0], 1'b0};


    assign ready_out = reg_tmp[31];
    
    encdec_flow u_00 ( .data_in(data_in      ), .round_key_in(keyi_00_in), .result_out(result_00) );
    encdec_flow u_01 ( .data_in(reg_result_00), .round_key_in(keyi_01_in), .result_out(result_01) );
    encdec_flow u_02 ( .data_in(reg_result_01), .round_key_in(keyi_02_in), .result_out(result_02) );
    encdec_flow u_03 ( .data_in(reg_result_02), .round_key_in(keyi_03_in), .result_out(result_03) );
    encdec_flow u_04 ( .data_in(reg_result_03), .round_key_in(keyi_04_in), .result_out(result_04) );
    encdec_flow u_05 ( .data_in(reg_result_04), .round_key_in(keyi_05_in), .result_out(result_05) );
    encdec_flow u_06 ( .data_in(reg_result_05), .round_key_in(keyi_06_in), .result_out(result_06) );
    encdec_flow u_07 ( .data_in(reg_result_06), .round_key_in(keyi_07_in), .result_out(result_07) );
    encdec_flow u_08 ( .data_in(reg_result_07), .round_key_in(keyi_08_in), .result_out(result_08) );
    encdec_flow u_09 ( .data_in(reg_result_08), .round_key_in(keyi_09_in), .result_out(result_09) );
    encdec_flow u_10 ( .data_in(reg_result_09), .round_key_in(keyi_10_in), .result_out(result_10) );
    encdec_flow u_11 ( .data_in(reg_result_10), .round_key_in(keyi_11_in), .result_out(result_11) );
    encdec_flow u_12 ( .data_in(reg_result_11), .round_key_in(keyi_12_in), .result_out(result_12) );
    encdec_flow u_13 ( .data_in(reg_result_12), .round_key_in(keyi_13_in), .result_out(result_13) );
    encdec_flow u_14 ( .data_in(reg_result_13), .round_key_in(keyi_14_in), .result_out(result_14) );
    encdec_flow u_15 ( .data_in(reg_result_14), .round_key_in(keyi_15_in), .result_out(result_15) );
    encdec_flow u_16 ( .data_in(reg_result_15), .round_key_in(keyi_16_in), .result_out(result_16) );
    encdec_flow u_17 ( .data_in(reg_result_16), .round_key_in(keyi_17_in), .result_out(result_17) );
    encdec_flow u_18 ( .data_in(reg_result_17), .round_key_in(keyi_18_in), .result_out(result_18) );
    encdec_flow u_19 ( .data_in(reg_result_18), .round_key_in(keyi_19_in), .result_out(result_19) );
    encdec_flow u_20 ( .data_in(reg_result_19), .round_key_in(keyi_20_in), .result_out(result_20) );
    encdec_flow u_21 ( .data_in(reg_result_20), .round_key_in(keyi_21_in), .result_out(result_21) );
    encdec_flow u_22 ( .data_in(reg_result_21), .round_key_in(keyi_22_in), .result_out(result_22) );
    encdec_flow u_23 ( .data_in(reg_result_22), .round_key_in(keyi_23_in), .result_out(result_23) );
    encdec_flow u_24 ( .data_in(reg_result_23), .round_key_in(keyi_24_in), .result_out(result_24) );
    encdec_flow u_25 ( .data_in(reg_result_24), .round_key_in(keyi_25_in), .result_out(result_25) );
    encdec_flow u_26 ( .data_in(reg_result_25), .round_key_in(keyi_26_in), .result_out(result_26) );
    encdec_flow u_27 ( .data_in(reg_result_26), .round_key_in(keyi_27_in), .result_out(result_27) );
    encdec_flow u_28 ( .data_in(reg_result_27), .round_key_in(keyi_28_in), .result_out(result_28) );
    encdec_flow u_29 ( .data_in(reg_result_28), .round_key_in(keyi_29_in), .result_out(result_29) );
    encdec_flow u_30 ( .data_in(reg_result_29), .round_key_in(keyi_30_in), .result_out(result_30) );
    encdec_flow u_31 ( .data_in(reg_result_30), .round_key_in(keyi_31_in), .result_out(result_31) );
    
    assign { word_0, word_1, word_2, word_3} = result_31;
    assign reversed_result_31 = {word_3, word_2, word_1, word_0};
    
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_00 <= 128'h0; else reg_result_00 <= result_00;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_01 <= 128'h0; else reg_result_01 <= result_01;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_02 <= 128'h0; else reg_result_02 <= result_02;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_03 <= 128'h0; else reg_result_03 <= result_03;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_04 <= 128'h0; else reg_result_04 <= result_04;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_05 <= 128'h0; else reg_result_05 <= result_05;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_06 <= 128'h0; else reg_result_06 <= result_06;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_07 <= 128'h0; else reg_result_07 <= result_07;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_08 <= 128'h0; else reg_result_08 <= result_08;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_09 <= 128'h0; else reg_result_09 <= result_09;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_10 <= 128'h0; else reg_result_10 <= result_10;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_11 <= 128'h0; else reg_result_11 <= result_11;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_12 <= 128'h0; else reg_result_12 <= result_12;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_13 <= 128'h0; else reg_result_13 <= result_13;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_14 <= 128'h0; else reg_result_14 <= result_14;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_15 <= 128'h0; else reg_result_15 <= result_15;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_16 <= 128'h0; else reg_result_16 <= result_16;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_17 <= 128'h0; else reg_result_17 <= result_17;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_18 <= 128'h0; else reg_result_18 <= result_18;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_19 <= 128'h0; else reg_result_19 <= result_19;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_20 <= 128'h0; else reg_result_20 <= result_20;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_21 <= 128'h0; else reg_result_21 <= result_21;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_22 <= 128'h0; else reg_result_22 <= result_22;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_23 <= 128'h0; else reg_result_23 <= result_23;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_24 <= 128'h0; else reg_result_24 <= result_24;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_25 <= 128'h0; else reg_result_25 <= result_25;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_26 <= 128'h0; else reg_result_26 <= result_26;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_27 <= 128'h0; else reg_result_27 <= result_27;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_28 <= 128'h0; else reg_result_28 <= result_28;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_29 <= 128'h0; else reg_result_29 <= result_29;
    always@(posedge clk or negedge reset_n) if(!reset_n) reg_result_30 <= 128'h0; else reg_result_30 <= result_30;
    always@(posedge clk or negedge reset_n) if(!reset_n) result_out    <= 128'h0; else result_out    <= reversed_result_31;
        
                                                    
endmodule
