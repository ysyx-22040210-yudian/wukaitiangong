`timescale 1ns / 100ps

module encdec_T(
		data_in,
		result_out
	);
input	[31:0]	data_in;
output	[31:0]	result_out;			

wire	[7:0]	byte_0;
wire	[7:0]	byte_1;
wire	[7:0]	byte_2;
wire	[7:0]	byte_3;
wire	[7:0]	byte_0_replaced;
wire	[7:0]	byte_1_replaced;
wire	[7:0]	byte_2_replaced;
wire	[7:0]	byte_3_replaced;
wire	[31:0]	word_replaced;
wire	[31:0]	data_after_linear;
wire	[31:0]	data_after_linear_key;

assign	{ byte_0, byte_1, byte_2, byte_3 } = data_in;
assign	word_replaced = {byte_0_replaced, byte_1_replaced, byte_2_replaced,byte_3_replaced};//S变换

sbox_lut	u_0
	(
		.data_in(byte_0),
		.result_out(byte_0_replaced)														
	);
	
sbox_lut	u_1
	(
		.data_in(byte_1),
		.result_out(byte_1_replaced)														
	);
	
sbox_lut	u_2
	(
		.data_in(byte_2),
		.result_out(byte_2_replaced)														
	);
	
sbox_lut	u_3
	(
		.data_in(byte_3),
		.result_out(byte_3_replaced)														
	);	

assign	result_out = ( 	 (word_replaced ^ {word_replaced[29:0], word_replaced[31:30]}) 
                       ^ ({word_replaced[21:0], word_replaced[31:22]} ^ {word_replaced[13:0], word_replaced[31:14]})) 
				   ^ {word_replaced[7:0], word_replaced[31:8]}; //L变换,L(B)=B⊕(B<<2)⊕(B<<10)⊕(B<<18)⊕(B<<24)
													
endmodule		