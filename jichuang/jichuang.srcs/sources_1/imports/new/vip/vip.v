module vip
(
    //module clock
    input           clk               , // 时钟信号
    input           rst_n             , // 复位信号（低有效）
    input   [10:0]  IMG_HDISP         , // CMOS分辨率--行
    input   [10:0]  IMG_VDISP         , // CMOS分辨率--列
   
    //灰度化后的数据输入
    input           pre_frame_vsync_1 , // 场同步信号
    input           pre_frame_hsync_1 , // 行同步信号
    input           pre_frame_de_1    , // 有效信号
    input    [15:0] pre_rgb_1         , // rgb565数据输入
    input    [10:0] xpos              , // xpos输入
    input    [10:0] ypos              , // ypos输入

    input    [7:0]  Diff_Threshold    , // 帧差阈值输入
  
    //图像处理后的数据接口
    output          post_frame_vsync  , // 场同步信号
    output          post_frame_href   , // 行同步信号
    output          post_frame_clken  , // 数据输入使能
    output   [15:0] post_img,           // RGB565颜色数据
    
    //********************************方框上下左右位置
    output    [10:0] rectangular_up   ,
    output    [10:0] rectangular_down ,
    output    [10:0] rectangular_left ,
    output    [10:0] rectangular_right,
    output           rectangular_flag 
//    //膨胀处理后的数据输出
//    output          post_3_frame_vsync,
//    output          post_3_frame_href ,
//    output          post_3_frame_clken,
//    output          post_3_img_Bit     
);
//wire      post_frame_vsync_1;
//wire      post_frame_hsync_1;
//wire      post_frame_de_1   ;

wire  post_1_frame_vsync ;
wire  post_1_frame_href  ;
wire  post_1_frame_clken ;
wire  post_1_img_Bit     ;

canchajisuan u_canchajisuan(
   
    .clk             (clk               ), // 时钟信号
    .rst_n           (rst_n             ), // 复位信号（低有效）

    .per_frame_vsync (pre_frame_vsync_1 ),
    .per_frame_href  (pre_frame_hsync_1 ),
    .per_frame_clken (pre_frame_de_1    ),
    .per_img_Y0      (pre_rgb_1[15:8]   ),
    .per_img_Y1      (pre_rgb_1[7:0]    ),
    .Diff_Threshold  (Diff_Threshold    ),

    .post_frame_vsync(post_1_frame_vsync),
    .post_frame_href (post_1_frame_href ),
    .post_frame_clken(post_1_frame_clken),
    .post_img_Bit    (post_1_img_Bit    )
);

wire post_2_frame_vsync;
wire post_2_frame_href ;
wire post_2_frame_clken;
wire post_2_img_Bit    ;

fushi  u_fushi(
    .clk             (clk               ),
    .rst_n           (rst_n             ),

    .per_frame_vsync (post_1_frame_vsync),
    .per_frame_href  (post_1_frame_href ),
    .per_frame_clken (post_1_frame_clken),
    .per_img_Bit     (post_1_img_Bit    ),

    .post_frame_vsync(post_2_frame_vsync),
    .post_frame_href (post_2_frame_href ),
    .post_frame_clken(post_2_frame_clken),
    .post_img_Bit    (post_2_img_Bit    )

);

wire   post_3_frame_vsync;
wire   post_3_frame_href ;
wire   post_3_frame_clken;
wire   post_3_img_Bit    ;
       
pengzhang u_pengzhang(
   .clk              (clk               ),
   .rst_n            (rst_n             ),

   .per_frame_vsync  (post_2_frame_vsync),
   .per_frame_href   (post_2_frame_href ),
   .per_frame_clken  (post_2_frame_clken),
   .per_img_Bit      (post_2_img_Bit    ),
    
   .post_frame_vsync (post_3_frame_vsync),
   .post_frame_href  (post_3_frame_href ), 
   .post_frame_clken (post_3_frame_clken), 
   .post_img_Bit     (post_3_img_Bit    ) 

);



biankuangjiance u_biankuangjiance(
    //全局时钟
    . clk             (clk               ),
    . rst_n           (rst_n             ),
    . x_cnt           (xpos              ),
    . y_cnt           (ypos              ),
    .IMG_HDISP        (IMG_HDISP         ),
    .IMG_VDISP        (IMG_VDISP         ),

    //图像数据准备去处理
    . per_frame_vsync (post_3_frame_vsync),
    . per_frame_href  (post_3_frame_href ),
    . per_frame_clken (post_3_frame_clken),
    . per_img_Bit     (post_3_img_Bit    ),

    .rectangular_up   (rectangular_up    ),
    .rectangular_down (rectangular_down  ),
    .rectangular_left (rectangular_left  ),
    .rectangular_right(rectangular_right ),
    .rectangular_flag (rectangular_flag  ) 
 );

wire [7:0]    red   ;
wire [7:0]    green ;
wire [7:0]    blue  ;
 
 jiabiankuang u_jiabiankuang(
    //全局时钟
    .clk                (clk              ),
    .rst_n              (rst_n            ),
    .x_cnt              ( xpos            ),
    .y_cnt              ( ypos            ),
    .IMG_HDISP          (IMG_HDISP        ),
    .IMG_VDISP          (IMG_VDISP        ),
     // 图像数据准备去处理
    .per_frame_vsync    (pre_frame_vsync_1),
    .per_frame_href     (pre_frame_hsync_1),
    .per_frame_clken    (pre_frame_de_1   ),
    .huiduzhi           (pre_rgb_1[7:0]   ),
  

    . rectangular_up    (rectangular_up   ),
    . rectangular_down  (rectangular_down ),
    . rectangular_left  (rectangular_left ),
    . rectangular_right (rectangular_right),
    . rectangular_flag  (rectangular_flag ), //标志着是否存在运动目标

    //处理后的图像   
    .post_frame_vsync   (post_frame_vsync ),
    .post_frame_href    (post_frame_href  ),
    .post_frame_clken   (post_frame_clken ),
    .post_img_red       (red              ),
    .post_img_green     (green            ),
    .post_img_blue      (blue             )
 );

assign post_img={red[7:3],green[7:2],blue[7:3]};

//ila_0 u_ila0 (
//	.clk(clk), // input wire clk


//	.probe0(Diff_Threshold), // input wire [7:0]  probe0  
//	.probe1(post_img), // input wire [15:0]  probe1 
//	.probe2(post_1_img_Bit), // input wire [0:0]  probe2 
//	.probe3(post_2_img_Bit), // input wire [0:0]  probe3 
//	.probe4(post_3_img_Bit) // input wire [0:0]  probe4
//);
endmodule