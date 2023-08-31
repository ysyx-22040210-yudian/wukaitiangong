`timescale 1ns / 1ps
module canchajisuan(
//ȫ��ʱ��
input            clk        ,  //����ʱ��
input            rst_n      ,//ȫ�ָ�λ

//ͼ������׼��ȥ����
input                 per_frame_vsync    ,//����Ч�ź�
input                 per_frame_href     ,//���ź���Ч
input                 per_frame_clken    ,//�������/����ʹ��ʱ��
input     [7:0]       per_img_Y0          ,//ͼ���������
input     [7:0]       per_img_Y1          ,//ͼ���������
//input     [15:0]       YCbCr_img_Y_pre    ,//ͬʱ��DDR�ж���ǰһ֡�ĻҶ�

//�Ѿ��������ͼ������
output          post_frame_vsync    ,// ����Ч�ź�
output          post_frame_href     ,//����Ч�ź�
output          post_frame_clken    ,//���ʹ��
output          post_img_Bit        ,//ͼ�������־��1��Ч��0��Ч��

//�û��ӿ�
input   [7:0]   Diff_Threshold //����ͼ���Ե������ֵ
    );
//wire [7:0] Diff_Threshold;
wire YCbCr_img_Y_pre_valid;
reg  [7:0] per_img_Y_delay;

//ǰһ֡�ĻҶȣ��뵱ǰ֡�Ҷ����һ��ʱ������
//assign   YCbCr_img_Y_pre_valid = per_frame_clken_r[0];

//assign Diff_Threshold=7'd0;

//����ǰ֡�Ҷ��ӳ�һ��ʱ������
//always@(posedge clk or negedge rst_n) begin
//    if (!rst_n)
//       per_img_Y_delay<=8'd0;
//    else
//       per_img_Y_delay<=per_img_Y;     
// end
//�Ƚ�����
reg post_img_Bit_r;
always@(posedge clk or negedge rst_n) 
begin
     if (!rst_n)
     post_img_Bit_r<=1'b0;
     else if (per_frame_clken) begin //��Ƶ�Ҷ�������Ч      
       if(per_img_Y0 > per_img_Y1)begin
         if (per_img_Y0 - per_img_Y1 > Diff_Threshold)  //�ҶȲ������ֵ
             post_img_Bit_r<=1'b1;
         else
             post_img_Bit_r<=1'b0;
        end
        else begin
         if ( per_img_Y1 - per_img_Y0> Diff_Threshold)  //�ҶȲ������ֵ
             post_img_Bit_r<=1'b1;
         else
             post_img_Bit_r<=1'b0;
        end 
    end
end

 
//��ʱ1ʱ���ź�ͬ��
reg [1:0] per_frame_vsync_r;
reg [1:0] per_frame_href_r;
reg [1:0] per_frame_clken_r;
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
     begin
     per_frame_vsync_r<=0;
     per_frame_href_r<=0;
     per_frame_clken_r<=0;
     end
  else
     begin
     per_frame_vsync_r<={per_frame_vsync_r[0],per_frame_vsync};
     per_frame_href_r<={per_frame_href_r[0],per_frame_href};
     per_frame_clken_r<={per_frame_clken_r[0],per_frame_clken};
     end
 end
 
 assign  post_frame_vsync = per_frame_vsync_r[0];
 assign  post_frame_href = per_frame_href_r[0];
 assign  post_frame_clken = per_frame_clken_r[0];
 assign  post_img_Bit  = post_frame_href ? post_img_Bit_r:1'b0;
 
endmodule
