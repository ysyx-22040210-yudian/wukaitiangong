`timescale 1ns / 100ps

module get_keyi
	(
        clk					,
        reset_n				,
        sm4_enable_in		,
        encdec_sel_in       ,
        enable_key_exp_in	,
        user_key_in			,
        user_key_valid_in	,
        key_exp_finished_out,
        keyi00_out			,
        keyi01_out			,
        keyi02_out			,
        keyi03_out			,
        keyi04_out			,
        keyi05_out			,
        keyi06_out			,
        keyi07_out			,
        keyi08_out			,
        keyi09_out			,
        keyi10_out			,
        keyi11_out			,
        keyi12_out			,
        keyi13_out			,
        keyi14_out			,
        keyi15_out			,
        keyi16_out			,
        keyi17_out			,
        keyi18_out			,
        keyi19_out			,
        keyi20_out			,
        keyi21_out			,
        keyi22_out			,
        keyi23_out			,
        keyi24_out			,
        keyi25_out			,
        keyi26_out			,
        keyi27_out			,
        keyi28_out			,
        keyi29_out			,
        keyi30_out			,
        keyi31_out			
);

input   clk                     ;
input   reset_n                 ;
input   sm4_enable_in           ;
input   encdec_sel_in           ;// 0: encryption, 1: decryption
input   enable_key_exp_in       ;
input   user_key_valid_in       ;
input   [127: 0]     user_key_in;

output  reg key_exp_finished_out;
output  reg [31 : 0] keyi00_out;
output  reg [31 : 0] keyi01_out;
output  reg [31 : 0] keyi02_out;
output  reg [31 : 0] keyi03_out;
output  reg [31 : 0] keyi04_out;
output  reg [31 : 0] keyi05_out;
output  reg [31 : 0] keyi06_out;
output  reg [31 : 0] keyi07_out;
output  reg [31 : 0] keyi08_out;
output  reg [31 : 0] keyi09_out;
output  reg [31 : 0] keyi10_out;
output  reg [31 : 0] keyi11_out;
output  reg [31 : 0] keyi12_out;
output  reg [31 : 0] keyi13_out;
output  reg [31 : 0] keyi14_out;
output  reg [31 : 0] keyi15_out;
output  reg [31 : 0] keyi16_out;
output  reg [31 : 0] keyi17_out;
output  reg [31 : 0] keyi18_out;
output  reg [31 : 0] keyi19_out;
output  reg [31 : 0] keyi20_out;
output  reg [31 : 0] keyi21_out;
output  reg [31 : 0] keyi22_out;
output  reg [31 : 0] keyi23_out;
output  reg [31 : 0] keyi24_out;
output  reg [31 : 0] keyi25_out;
output  reg [31 : 0] keyi26_out;
output  reg [31 : 0] keyi27_out;
output  reg [31 : 0] keyi28_out;
output  reg [31 : 0] keyi29_out;
output  reg [31 : 0] keyi30_out;
output  reg [31 : 0] keyi31_out;

reg     [127 : 0]   reg_user_key;
reg     [1   : 0]   current;
reg     [1   : 0]   next;
reg     [4   : 0]   count_round;
reg     [4   : 0]   reg_count_round;
wire    [4   : 0]   count_for_reg;
reg		[127 : 0]	reg_data_after_round;
reg     			reg_user_key_valid = 1'b0;
reg					reg_enable_key_exp;
wire    [31  : 0]  	cki;
wire	[127 : 0]	data_for_round;
wire	[127 : 0]	data_after_round;


always@(posedge clk)
if(!reset_n)
	reg_user_key_valid <= 1'b0;
else 
	reg_user_key_valid <= user_key_valid_in;
        
        
        
always@(posedge clk or negedge reset_n)
begin
	if(~reset_n)
    	reg_enable_key_exp <= 1'b0;
	else 
		reg_enable_key_exp <= enable_key_exp_in;
end

    
`define IDLE          2'b00
`define KEY_EXPANSION 2'b01

always@(posedge clk or negedge reset_n)
if(!reset_n)
	current	<=	`IDLE;
else if(sm4_enable_in)
	current	<=	next;
else
	current	<=	`IDLE;

always@(*) 
begin
	next = `IDLE;
	case(current)
		`IDLE:	
			if(enable_key_exp_in && ~reg_user_key_valid && user_key_valid_in )//在使能秘钥扩展，且检测到秘钥有效上升沿的时候，进入秘钥扩展状态
				next = `KEY_EXPANSION;
			else
				next = `IDLE;
							
		`KEY_EXPANSION:
			if( reg_count_round == 5'd31)//生成32轮秘钥后，进入IDLE状态
				next =	`IDLE;
			else
				next =	`KEY_EXPANSION;
										
		default:	
				next =	`IDLE;
	endcase
end


always@(posedge clk or negedge reset_n)
if(!reset_n)
	count_round	<=	5'd0;
else if(next == `KEY_EXPANSION)
	count_round	<=	count_round	+	1'b1;
else 
	count_round <=	5'd0;


always@(posedge clk or negedge reset_n)
begin
    if(!reset_n)
        reg_count_round <= 5'd0;
    else
        reg_count_round <= count_round;
end

    
always@(posedge clk or negedge reset_n)
if(!reset_n)
	key_exp_finished_out <=	1'd0;
else if(~sm4_enable_in || ~enable_key_exp_in && reg_enable_key_exp) //不用sm4的时候，或者检测到秘钥扩展使能下降沿的时候， 也不会结束当前正在进行的秘钥扩展 
    key_exp_finished_out <=	1'd0;
else if(current == `KEY_EXPANSION && next == `IDLE) //当前状态是秘钥扩展，下一个状态是IDLE的时候，秘钥扩展结束
	key_exp_finished_out <=	1'b1;

always@(posedge clk or negedge reset_n)
if(!reset_n)
	reg_user_key <= 128'h0;
else if(~reg_user_key_valid && user_key_valid_in) //检测到秘钥有效上升沿的时候，更新秘钥
	reg_user_key <= user_key_in;
	
	

assign	data_for_round = reg_count_round != 5'd0 ?	reg_data_after_round : reg_user_key; //第一轮秘钥扩展的时候，输入的数据是用户输入的秘钥，之后的轮数输入的数据是上一轮的输出

//获得当前轮数的cki
cki_lut	get_cki
	(
        .clk(clk),
		.count_round_in(count_round),
		.cki_out(cki)
	);

//进行一轮秘钥扩展
key_exp_flow	u_one_round	
	(	
		.count_round_in(reg_count_round),
		.data_in(data_for_round),
		.ck_parameter_in(cki),
		.result_out(data_after_round) //keyii, keyii+1, keyii+2, keyii+3
	);

    
always@(posedge clk or negedge reset_n)
if(!reset_n)
	reg_data_after_round <=	128'd0;
else if(current == `KEY_EXPANSION)
	reg_data_after_round <=	data_after_round;

    
assign count_for_reg = encdec_sel_in == 1'b0 ? reg_count_round : 5'b1_1111 -  reg_count_round;  //加密的时候，轮数不变，解密的时候，轮数是31-当前轮数
    
always@(posedge clk or negedge reset_n)
begin
if(!reset_n) begin
	keyi00_out <=	32'd0;
	keyi01_out <=	32'd0;
	keyi02_out <=	32'd0;
	keyi03_out <=	32'd0;
	keyi04_out <=	32'd0;
	keyi05_out <=	32'd0;
	keyi06_out <=	32'd0;
	keyi07_out <=	32'd0;
	keyi08_out <=	32'd0;
	keyi09_out <=	32'd0;
	keyi10_out <=	32'd0;
	keyi11_out <=	32'd0;
	keyi12_out <=	32'd0;
	keyi13_out <=	32'd0;
	keyi14_out <=	32'd0;
	keyi15_out <=	32'd0;
	keyi16_out <=	32'd0;
	keyi17_out <=	32'd0;
	keyi18_out <=	32'd0;
	keyi19_out <=	32'd0;
	keyi20_out <=	32'd0;
	keyi21_out <=	32'd0;
	keyi22_out <=	32'd0;
	keyi23_out <=	32'd0;
	keyi24_out <=	32'd0;
	keyi25_out <=	32'd0;
	keyi26_out <=	32'd0;
	keyi27_out <=	32'd0;
	keyi28_out <=	32'd0;
	keyi29_out <=	32'd0;
	keyi30_out <=	32'd0;
	keyi31_out <=	32'd0;
end
else begin //当前状态是秘钥扩展，且当前轮数是0-31的时候，输出当前轮数的keyii
	keyi00_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_0000	?	data_after_round[31:0]	:	 keyi00_out;	//当前状态是秘钥扩展，当前轮数是0的时候，输出keyii									
	keyi01_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_0001	?	data_after_round[31:0]	:	keyi01_out;//当前状态是秘钥扩展，当前轮数是1的时候，输出keyii+1
	keyi02_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_0010	?	data_after_round[31:0]	:	keyi02_out;
	keyi03_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_0011	?	data_after_round[31:0]	:	keyi03_out;
	keyi04_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_0100	?	data_after_round[31:0]	:	keyi04_out;
	keyi05_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_0101	?	data_after_round[31:0]	:	keyi05_out;
	keyi06_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_0110	?	data_after_round[31:0]	:	keyi06_out;
	keyi07_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_0111	?	data_after_round[31:0]	:	keyi07_out;
	keyi08_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_1000	?	data_after_round[31:0]	:	keyi08_out;
	keyi09_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_1001	?	data_after_round[31:0]	:	keyi09_out;
	keyi10_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_1010	?	data_after_round[31:0]	:	keyi10_out;
	keyi11_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_1011	?	data_after_round[31:0]	:	keyi11_out;
	keyi12_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_1100	?	data_after_round[31:0]	:	keyi12_out;
	keyi13_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_1101	?	data_after_round[31:0]	:	keyi13_out;
	keyi14_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_1110	?	data_after_round[31:0]	:	keyi14_out;
	keyi15_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b0_1111	?	data_after_round[31:0]	:	keyi15_out;
	keyi16_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_0000	?	data_after_round[31:0]	:	keyi16_out;
	keyi17_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_0001	?	data_after_round[31:0]	:	keyi17_out;
	keyi18_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_0010	?	data_after_round[31:0]	:	keyi18_out;
	keyi19_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_0011	?	data_after_round[31:0]	:	keyi19_out;
	keyi20_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_0100	?	data_after_round[31:0]	:	keyi20_out;
	keyi21_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_0101	?	data_after_round[31:0]	:	keyi21_out;
	keyi22_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_0110	?	data_after_round[31:0]	:	keyi22_out;
	keyi23_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_0111	?	data_after_round[31:0]	:	keyi23_out;
	keyi24_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_1000	?	data_after_round[31:0]	:	keyi24_out;
	keyi25_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_1001	?	data_after_round[31:0]	:	keyi25_out;
	keyi26_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_1010	?	data_after_round[31:0]	:	keyi26_out;
	keyi27_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_1011	?	data_after_round[31:0]	:	keyi27_out;
	keyi28_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_1100	?	data_after_round[31:0]	:	keyi28_out;
	keyi29_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_1101	?	data_after_round[31:0]	:	keyi29_out;
	keyi30_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_1110	?	data_after_round[31:0]	:	keyi30_out;
	keyi31_out <=	current == `KEY_EXPANSION && count_for_reg == 5'b1_1111	?	data_after_round[31:0]	:	keyi31_out;
	end
end

endmodule





