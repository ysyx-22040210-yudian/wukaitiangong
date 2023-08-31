`timescale 1ns / 100ps

module sm4_top(
    clk		            ,
    reset_n	            ,
    sm4_enable_in       ,
    encdec_enable_in    ,
    encdec_sel_in       ,
    valid_in            ,
    data_in             ,
    enable_key_exp_in   ,
    user_key_valid_in   ,
    user_key_in         ,
    key_exp_ready_out   ,
    ready_out           ,
    result_out         
);
    
    input			 clk		        ;
    input			 reset_n	        ;
    input            sm4_enable_in      ;
    input            encdec_enable_in   ;
    input            encdec_sel_in      ;
    input            valid_in           ;
    input   [127: 0] data_in            ;
    input            enable_key_exp_in  ;
    input            user_key_valid_in  ;
    input   [127: 0] user_key_in        ;
    output           ready_out          ;
    output  [127: 0] result_out         ;
    
    output           key_exp_ready_out  ;
    wire    [31 : 0] keyi_00              ;
    wire    [31 : 0] keyi_01              ;
    wire    [31 : 0] keyi_02              ;
    wire    [31 : 0] keyi_03              ;
    wire    [31 : 0] keyi_04              ;
    wire    [31 : 0] keyi_05              ;
    wire    [31 : 0] keyi_06              ;
    wire    [31 : 0] keyi_07              ;
    wire    [31 : 0] keyi_08              ;
    wire    [31 : 0] keyi_09              ;
    wire    [31 : 0] keyi_10              ;
    wire    [31 : 0] keyi_11              ;
    wire    [31 : 0] keyi_12              ;
    wire    [31 : 0] keyi_13              ;
    wire    [31 : 0] keyi_14              ;
    wire    [31 : 0] keyi_15              ;
    wire    [31 : 0] keyi_16              ;
    wire    [31 : 0] keyi_17              ;
    wire    [31 : 0] keyi_18              ;
    wire    [31 : 0] keyi_19              ;
    wire    [31 : 0] keyi_20              ;
    wire    [31 : 0] keyi_21              ;
    wire    [31 : 0] keyi_22              ;
    wire    [31 : 0] keyi_23              ;
    wire    [31 : 0] keyi_24              ;
    wire    [31 : 0] keyi_25              ;
    wire    [31 : 0] keyi_26              ;
    wire    [31 : 0] keyi_27              ;
    wire    [31 : 0] keyi_28              ;
    wire    [31 : 0] keyi_29              ;
    wire    [31 : 0] keyi_30              ;
    wire    [31 : 0] keyi_31              ;
    
    sm4_encdec u_encdec (
        .clk                    (clk                 ),
        .reset_n                (reset_n             ),
        .sm4_enable_in          (sm4_enable_in       ),
        .encdec_enable_in       (encdec_enable_in    ),
        .key_exp_ready_in       (key_exp_ready_out   ),
        .valid_in               (valid_in            ),
        .data_in                (data_in             ),
        .keyi_00_in               (keyi_00               ),
        .keyi_01_in               (keyi_01               ),
        .keyi_02_in               (keyi_02               ),
        .keyi_03_in               (keyi_03               ),
        .keyi_04_in               (keyi_04               ),
        .keyi_05_in               (keyi_05               ),
        .keyi_06_in               (keyi_06               ),
        .keyi_07_in               (keyi_07               ),
        .keyi_08_in               (keyi_08               ),
        .keyi_09_in               (keyi_09               ),
        .keyi_10_in               (keyi_10               ),
        .keyi_11_in               (keyi_11               ),
        .keyi_12_in               (keyi_12               ),
        .keyi_13_in               (keyi_13               ),
        .keyi_14_in               (keyi_14               ),
        .keyi_15_in               (keyi_15               ),
        .keyi_16_in               (keyi_16               ),
        .keyi_17_in               (keyi_17               ),
        .keyi_18_in               (keyi_18               ),
        .keyi_19_in               (keyi_19               ),
        .keyi_20_in               (keyi_20               ),
        .keyi_21_in               (keyi_21               ),
        .keyi_22_in               (keyi_22               ),
        .keyi_23_in               (keyi_23               ),
        .keyi_24_in               (keyi_24               ),
        .keyi_25_in               (keyi_25               ),
        .keyi_26_in               (keyi_26               ),
        .keyi_27_in               (keyi_27               ),
        .keyi_28_in               (keyi_28               ),
        .keyi_29_in               (keyi_29               ),
        .keyi_30_in               (keyi_30               ),
        .keyi_31_in               (keyi_31               ),
        .ready_out              (ready_out           ),
        .result_out             (result_out          )
    );
    
    get_keyi u_key
	(
        .clk					(clk					),
        .reset_n				(reset_n				),
        .sm4_enable_in		    (sm4_enable_in		    ),
        .encdec_sel_in		    (encdec_sel_in		    ),
        .enable_key_exp_in	    (enable_key_exp_in	    ),
        .user_key_in			(user_key_in			),
        .user_key_valid_in	    (user_key_valid_in	    ),
        .key_exp_finished_out   (key_exp_ready_out      ),
        .keyi00_out			    (keyi_00    			    ),
        .keyi01_out			    (keyi_01    			    ),
        .keyi02_out			    (keyi_02    			    ),
        .keyi03_out			    (keyi_03    			    ),
        .keyi04_out			    (keyi_04    			    ),
        .keyi05_out			    (keyi_05    			    ),
        .keyi06_out			    (keyi_06    			    ),
        .keyi07_out			    (keyi_07    			    ),
        .keyi08_out			    (keyi_08    			    ),
        .keyi09_out			    (keyi_09    			    ),
        .keyi10_out			    (keyi_10    			    ),
        .keyi11_out			    (keyi_11    			    ),
        .keyi12_out			    (keyi_12    			    ),
        .keyi13_out			    (keyi_13    			    ),
        .keyi14_out			    (keyi_14    			    ),
        .keyi15_out			    (keyi_15    			    ),
        .keyi16_out			    (keyi_16    			    ),
        .keyi17_out			    (keyi_17    			    ),
        .keyi18_out			    (keyi_18    			    ),
        .keyi19_out			    (keyi_19    			    ),
        .keyi20_out			    (keyi_20    			    ),
        .keyi21_out			    (keyi_21    			    ),
        .keyi22_out			    (keyi_22    			    ),
        .keyi23_out			    (keyi_23    			    ),
        .keyi24_out			    (keyi_24    			    ),
        .keyi25_out			    (keyi_25    			    ),
        .keyi26_out			    (keyi_26    			    ),
        .keyi27_out			    (keyi_27    			    ),
        .keyi28_out			    (keyi_28    			    ),
        .keyi29_out			    (keyi_29    			    ),
        .keyi30_out			    (keyi_30    			    ),
        .keyi31_out			    (keyi_31    			    )
    );
    
endmodule
