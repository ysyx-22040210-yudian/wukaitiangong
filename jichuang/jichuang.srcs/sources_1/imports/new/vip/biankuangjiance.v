`timescale 1ns / 1ps
module biankuangjiance
(
//全局时钟
input       clk     ,
input       rst_n   ,
input     [10:0]  IMG_HDISP,
input     [10:0]  IMG_VDISP,
input       [10:0]         x_cnt        ,
input       [10:0]         y_cnt        ,
// 图像数据准备去处理
input      per_frame_vsync  ,
input      per_frame_href   ,
input      per_frame_clken  ,
input      per_img_Bit      ,


 
output reg [10:0] rectangular_up     ,
output reg [10:0] rectangular_down   ,
output reg [10:0] rectangular_left   ,
output reg [10:0] rectangular_right  ,
output reg        rectangular_flag
 );

//ila_1 your_instance_name (
//	.clk(clk), // input wire clk

//	.probe0(per_frame_vsync), // input wire [0:0]  probe0  
//	.probe1(per_frame_href), // input wire [0:0]  probe1 
//	.probe2(per_frame_clken), // input wire [0:0]  probe2 
//	.probe3(per_img_Bit), // input wire [0:0]  probe3 
//	.probe4(flag_reg), // input wire [0:0]  probe4 
//	.probe5(up_reg), // input wire [10:0]  probe5 
//	.probe6(down_reg), // input wire [10:0]  probe6 
//	.probe7(left_reg), // input wire [10:0]  probe7 
//	.probe8(right_reg), // input wire [10:0]  probe8
//	.probe9(x_cnt), // input wire [10:0]  probe9   
//    .probe10(y_cnt), // input wire [10:0]  probe10 
//    .probe11(IMG_HDISP), // input wire [10:0]  probe11  
//    .probe12(IMG_VDISP) // input wire [10:0]  probe12   
    	
//);

//reg [10:0] x_cnt;
//reg [10:0] y_cnt;
    
reg [10:0] up_reg;
reg [10:0] down_reg;  
reg [10:0] left_reg;  
reg [10:0] right_reg; 
reg        flag_reg;    
  
//对输入的像素进行“行/场”方向计数，得到其横纵坐标
//always@(posedge clk or posedge rst_n)
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
//        if(x_cnt<IMG_HDISP-1'b1)begin
//          x_cnt<=x_cnt+1'b1;
//          y_cnt<=y_cnt;
//        end
//        else begin
//           x_cnt<=11'd0;
//           y_cnt<=y_cnt+1'b1;
//        end
//     end
// end
//求出运动目标的最大矩形边框
always@(posedge clk or negedge rst_n) begin
     if (!rst_n)begin
         up_reg <=IMG_VDISP;
         down_reg <=11'd0;
         left_reg<=IMG_HDISP;
         right_reg<=11'd0;
         flag_reg<=1'b0;
      end
      else if (per_frame_vsync && (x_cnt==IMG_HDISP-1)&&(y_cnt==IMG_VDISP-1))begin
         up_reg <=IMG_VDISP;
         down_reg <=11'd0;
         left_reg<=IMG_HDISP;
         right_reg<=11'd0;
         flag_reg<=1'b0;
       end
       else if (per_frame_clken & per_img_Bit)begin
          flag_reg<=1'b1;
          if(x_cnt<left_reg)
             left_reg<=x_cnt;//左边界
          else
             left_reg<=left_reg;
          if (x_cnt>right_reg)
             right_reg<=x_cnt; //有边界
          else 
             right_reg<=right_reg;
          if (y_cnt<up_reg)
             up_reg<=y_cnt;    //上边界
          else
             up_reg<=up_reg;
          if (y_cnt>down_reg)
             down_reg<=y_cnt;//下边界
          else
             down_reg<=down_reg;
          
         // if (y_cnt>up_reg)             
         //    up_reg<=y_cnt;    //上边界    
         // else                          
         //    up_reg<=up_reg;            
         // if (y_cnt<down_reg)           
         //    down_reg<=y_cnt;//下边界      
         // else                          
         //    down_reg<=down_reg;        
         
        end
    end
always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        rectangular_up     <=11'd0;
        rectangular_down   <=11'd0;   
        rectangular_left   <=11'd0;         
        rectangular_right  <=11'd0;         
        rectangular_flag   <=1'b0;    
    end
    else if ((x_cnt==IMG_HDISP-1)&&(y_cnt==IMG_VDISP-1))begin
        rectangular_up    <=up_reg;  
        rectangular_down  <=down_reg;   
        rectangular_left  <=left_reg;    
        rectangular_right <=right_reg;
        rectangular_flag  <=flag_reg;
    end
  end

endmodule
