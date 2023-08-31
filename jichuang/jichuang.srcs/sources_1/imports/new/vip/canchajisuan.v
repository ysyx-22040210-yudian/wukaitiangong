`timescale 1ns / 1ps
module canchajisuan(
//全局时钟
input            clk        ,  //像素时钟
input            rst_n      ,//全局复位

//图像数据准备去处理
input                 per_frame_vsync    ,//场有效信号
input                 per_frame_href     ,//行信号有效
input                 per_frame_clken    ,//数据输出/捕获使能时钟
input     [7:0]       per_img_Y0          ,//图像亮度输出
input     [7:0]       per_img_Y1          ,//图像亮度输出
//input     [15:0]       YCbCr_img_Y_pre    ,//同时从DDR中读出前一帧的灰度

//已经处理过的图像数据
output          post_frame_vsync    ,// 场有效信号
output          post_frame_href     ,//行有效信号
output          post_frame_clken    ,//输出使能
output          post_img_Bit        ,//图像输出标志（1有效，0无效）

//用户接口
input   [7:0]   Diff_Threshold //用于图像边缘检测的阈值
    );
//wire [7:0] Diff_Threshold;
wire YCbCr_img_Y_pre_valid;
reg  [7:0] per_img_Y_delay;

//前一帧的灰度，与当前帧灰度相差一个时钟周期
//assign   YCbCr_img_Y_pre_valid = per_frame_clken_r[0];

//assign Diff_Threshold=7'd0;

//将当前帧灰度延迟一个时钟周期
//always@(posedge clk or negedge rst_n) begin
//    if (!rst_n)
//       per_img_Y_delay<=8'd0;
//    else
//       per_img_Y_delay<=per_img_Y;     
// end
//比较作差
reg post_img_Bit_r;
always@(posedge clk or negedge rst_n) 
begin
     if (!rst_n)
     post_img_Bit_r<=1'b0;
     else if (per_frame_clken) begin //视频灰度数据有效      
       if(per_img_Y0 > per_img_Y1)begin
         if (per_img_Y0 - per_img_Y1 > Diff_Threshold)  //灰度差大于阈值
             post_img_Bit_r<=1'b1;
         else
             post_img_Bit_r<=1'b0;
        end
        else begin
         if ( per_img_Y1 - per_img_Y0> Diff_Threshold)  //灰度差大于阈值
             post_img_Bit_r<=1'b1;
         else
             post_img_Bit_r<=1'b0;
        end 
    end
end

 
//延时1时钟信号同步
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
