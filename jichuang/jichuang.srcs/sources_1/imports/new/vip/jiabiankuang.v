`timescale 1ns / 1ps

module jiabiankuang
(
//全局时钟
   input       clk   ,
   input       rst_n ,
   input      [10:0] IMG_HDISP,
   input      [10:0] IMG_VDISP,
   input       [10:0]    x_cnt        ,
   input       [10:0]    y_cnt        ,
   // 图像数据准备去处理
   input      per_frame_vsync   ,
   input      per_frame_href    ,
   input      per_frame_clken   ,
   input[7:0] huiduzhi       ,
//   input[5:0] per_img_green     ,
//   input[4:0] per_img_blue      ,

   input[10:0] rectangular_up    ,
   input[10:0] rectangular_down  ,
   input[10:0] rectangular_left  ,
   input[10:0] rectangular_right ,
   input       rectangular_flag  ,  //标志着是否存在运动目标
   
   //处理后的图像   
  output   reg post_frame_vsync      ,  
  output   reg post_frame_href       ,  
  output   reg post_frame_clken      ,  
  output   reg [7:0] post_img_red    ,  
  output   reg [7:0] post_img_green  ,  
  output   reg [7:0] post_img_blue       
   
 );
 
// ila_2 your_instance_name (
// 	.clk(clk), // input wire clk
 
// 	.probe0(per_frame_vsync), // input wire [0:0]  probe0  
// 	.probe1(per_frame_href), // input wire [0:0]  probe1 
// 	.probe2(per_frame_clken), // input wire [0:0]  probe2 
// 	.probe3(huiduzhi), // input wire [7:0]  probe3 
// 	.probe4(rectangular_up), // input wire [10:0]  probe4 
// 	.probe5(rectangular_down), // input wire [10:0]  probe5 
// 	.probe6(rectangular_left), // input wire [10:0]  probe6 
// 	.probe7(rectangular_right), // input wire [10:0]  probe7 
// 	.probe8(rectangular_flag), // input wire [0:0]  probe8 
// 	.probe9(post_frame_vsync), // input wire [0:0]  probe9 
// 	.probe10(post_frame_href), // input wire [0:0]  probe10 
// 	.probe11(post_frame_clken), // input wire [0:0]  probe11 
// 	.probe12(post_img_red), // input wire [7:0]  probe12 
// 	.probe13(post_img_green), // input wire [7:0]  probe13 
// 	.probe14(post_img_blue) // input wire [7:0]  probe14
// );
 
// reg [10:0]  x_cnt;
// reg [10:0]  y_cnt;
 
 wire [7:0]  rgb888_r ; 
 wire [7:0]  rgb888_g ;
 wire [7:0]  rgb888_b ;
 
 assign rgb888_r         = huiduzhi;
 assign rgb888_g         = huiduzhi;
 assign rgb888_b         = huiduzhi;
//同步输出数据接口信号 

 //对输入的像素进行“行/场”方向计数，得到其纵横坐标
// always@(posedge clk or posedge rst_n)
//begin
//   if(!rst_n)
//     begin
//     x_cnt<=11'd0;
//     y_cnt<=11'd0;
//     end
//  else
//     if (per_frame_vsync)begin
//        x_cnt <=11'd0;
//        y_cnt<= 11'd0;
//     end
//     else if (per_frame_clken)begin
//        if(x_cnt<IMG_HDISP-1)begin
//          x_cnt<=x_cnt+1'b1;
//          y_cnt<=y_cnt;
//        end
//        else begin
//           x_cnt<=11'd0;
//           y_cnt<=y_cnt+1'b1;
//        end
//     end
// end
 
 always@(posedge clk or negedge rst_n)begin
if (!rst_n)begin
    post_frame_vsync  <=1'd0;
    post_frame_href   <=1'd0;
    post_frame_clken  <=1'd0;
    post_img_red      <=8'd0;
    post_img_green    <=8'd0;
    post_img_blue     <=8'd0;
end
else begin
    post_frame_vsync<=per_frame_vsync;
    post_frame_href<=per_frame_href;
    post_frame_clken<=per_frame_clken;
     
    if (rectangular_flag)begin  //检测运动目标
        if((x_cnt>rectangular_left)&&(x_cnt<rectangular_right)&&((y_cnt==rectangular_up)||(y_cnt==rectangular_down)))begin  //绘制上下边界
        post_img_red    <=8'd255; 
        post_img_green  <=8'd0;
        post_img_blue   <=8'd0;
        end else  if((y_cnt>rectangular_up)&&(y_cnt<rectangular_down)&&((x_cnt==rectangular_left)||(x_cnt==rectangular_right)))begin  //绘制左右边界
          post_img_red    <=8'd255; 
          post_img_green  <=8'd0;
          post_img_blue   <=8'd0;
         //else  if((y_cnt<rectangular_up)&&(y_cnt>rectangular_down)&&((x_cnt==rectangular_left)||(x_cnt==rectangular_right)))begin  //绘制左右边界      
         // post_img_red1    <=8'd255;                                                                                                              
         // post_img_green1  <=8'd0;                                                                                                                
         // post_img_blue1   <=8'd0;                                                                                                                
            end else begin
               post_img_red   <=rgb888_r  ;
               post_img_green <=rgb888_g ;
               post_img_blue  <=rgb888_b  ;
                end
    end
    else begin
        post_img_red   <=rgb888_r  ;
        post_img_green <=rgb888_g ;
        post_img_blue  <=rgb888_b  ;
      end
    end
end
   
//reg   per_frame_vsync_r ;
//reg   per_frame_href_r  ;  
//reg   per_frame_clken_r ;
// always@(posedge clk or negedge rst_n)
// begin
// if(!rst_n)
//    begin
//    per_frame_vsync_r<=0;
//    per_frame_href_r <=0;
//    per_frame_clken_r<=0;
//    end
//  else
//    begin
//    per_frame_vsync_r<=per_frame_vsync  ;
//    per_frame_href_r <=per_frame_href   ;
//    per_frame_clken_r<=per_frame_clken  ;
//    
//    post_frame_vsync =per_frame_vsync_r ; 
//    post_frame_href  =per_frame_href_r ;  
//    post_frame_clken =per_frame_clken_r ; 
//    
//    end
//end
////assign  post_frame_vsync =per_frame_vsync_r ;
////assign  post_frame_href  =per_frame_href_r ;
////assign  post_frame_clken =per_frame_clken_r ;
//
//
//
////assign  post_img_red       =post_frame_href ? post_img_red1:8'd0;   
////assign  post_img_green     = post_frame_href ? post_img_green1: 8'd0;         
////assign  post_img_blue      = post_frame_href ? post_img_blue1: 8'd0;
//assign  post_img_red       =post_img_red1;      
//assign  post_img_green     = post_img_green1;  
//assign  post_img_blue      = post_img_blue1;   

endmodule
