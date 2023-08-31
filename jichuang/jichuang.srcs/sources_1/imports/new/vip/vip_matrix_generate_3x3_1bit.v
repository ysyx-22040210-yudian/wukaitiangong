module  vip_matrix_generate_3x3_1bit
(
    input             clk,  
    input             rst_n,

    input             per_frame_vsync,
    input             per_frame_href,
    input             per_frame_clken,
    input             per_img_Bit,
    
    output            matrix_frame_vsync,
    output            matrix_frame_href,
    output            matrix_frame_clken,
    output reg        matrix_p11,
    output reg        matrix_p12, 
    output reg        matrix_p13,
    output reg        matrix_p21, 
    output reg        matrix_p22, 
    output reg        matrix_p23,
    output reg        matrix_p31, 
    output reg        matrix_p32, 
    output reg        matrix_p33
);

//wire define
wire       row1_data;  
wire       row2_data;  
wire       read_frame_href;
wire       read_frame_clken;

//reg define
reg        row3_data;  
reg  [1:0] per_frame_vsync_r;
reg  [1:0] per_frame_href_r;
reg  [1:0] per_frame_clken_r;

//*****************************************************
//**                    main code
//*****************************************************

assign read_frame_href    = per_frame_href_r[0] ;
assign read_frame_clken   = per_frame_clken_r[0];
assign matrix_frame_vsync = per_frame_vsync_r[1];
assign matrix_frame_href  = per_frame_href_r[1] ;
assign matrix_frame_clken = per_frame_clken_r[1];

//��ǰ���ݷ��ڵ�3��
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        row3_data <= 0;
    else begin
        if(per_frame_clken)
            row3_data <= per_img_Bit ;
        else
            row3_data <= row3_data ;
    end
end

//���ڴ洢�����ݵ�RAM
shift_3h u_shift_3h
(
.clk(clk)  ,
.ce (per_frame_clken),  
.din(per_img_Bit)  , 
      
.dout   (),  
.dout_s0(row2_data),
.dout_s1(row1_data),
.dout_s2()

);                                                                                   

//��ͬ���ź��ӳ����ģ�����ͬ��������
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        per_frame_vsync_r <= 0;
        per_frame_href_r  <= 0;
        per_frame_clken_r <= 0;
    end
    else begin
        per_frame_vsync_r <= { per_frame_vsync_r[0], per_frame_vsync };
        per_frame_href_r  <= { per_frame_href_r[0],  per_frame_href  };
        per_frame_clken_r <= { per_frame_clken_r[0], per_frame_clken };
    end
end

//��ͬ�������Ŀ����ź��£����ͼ�����
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        {matrix_p11, matrix_p12, matrix_p13} <= 3'h0;
        {matrix_p21, matrix_p22, matrix_p23} <= 3'h0;
        {matrix_p31, matrix_p32, matrix_p33} <= 3'h0;
    end
    else if(read_frame_href) begin
        if(read_frame_clken) begin
            {matrix_p11, matrix_p12, matrix_p13} <= {matrix_p12, matrix_p13, row1_data};
            {matrix_p21, matrix_p22, matrix_p23} <= {matrix_p22, matrix_p23, row2_data};
            {matrix_p31, matrix_p32, matrix_p33} <= {matrix_p32, matrix_p33, row3_data};
        end
        else begin
            {matrix_p11, matrix_p12, matrix_p13} <= {matrix_p11, matrix_p12, matrix_p13};
            {matrix_p21, matrix_p22, matrix_p23} <= {matrix_p21, matrix_p22, matrix_p23};
            {matrix_p31, matrix_p32, matrix_p33} <= {matrix_p31, matrix_p32, matrix_p33};
        end
    end
    else begin
        {matrix_p11, matrix_p12, matrix_p13} <= 3'h0;
        {matrix_p21, matrix_p22, matrix_p23} <= 3'h0;
        {matrix_p31, matrix_p32, matrix_p33} <= 3'h0;
    end
end

endmodule 