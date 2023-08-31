
module ov5640_ddr_hdmi(    
    input                 sys_clk      ,  //ϵͳʱ��
    input                 sys_rst_n    ,  //ϵͳ��λ���͵�ƽ��Ч
    //����ͷ�ӿ�                       
    input                 cam_pclk     ,  //cmos ��������ʱ��
    input                 cam_vsync    ,  //cmos ��ͬ���ź�
    input                 cam_href     ,  //cmos ��ͬ���ź�
    input   [7:0]         cam_data     ,  //cmos ����
    output                cam_rst_n    ,  //cmos ��λ�źţ��͵�ƽ��Ч
    output                cam_pwdn     ,  //��Դ����ģʽѡ�� 0������ģʽ 1����Դ����ģʽ
    output                cam_scl      ,  //cmos SCCB_SCL��
    inout                 cam_sda      ,  //cmos SCCB_SDA��       
    // DDR3                            
    inout   [15:0]        ddr3_dq      ,  //DDR3 ���� ***********15->31****************************
    inout   [1:0]         ddr3_dqs_n   ,  //DDR3 dqs�� ***************************************
    inout   [1:0]         ddr3_dqs_p   ,  //DDR3 dqs��  *****************************************
    output  [13:0]        ddr3_addr    ,  //DDR3 ��ַ   
    output  [2:0]         ddr3_ba      ,  //DDR3 banck ѡ��
    output                ddr3_ras_n   ,  //DDR3 ��ѡ��
    output                ddr3_cas_n   ,  //DDR3 ��ѡ��
    output                ddr3_we_n    ,  //DDR3 ��дѡ��
    output                ddr3_reset_n ,  //DDR3 ��λ
    output  [0:0]         ddr3_ck_p    ,  //DDR3 ʱ����
    output  [0:0]         ddr3_ck_n    ,  //DDR3 ʱ�Ӹ�
    output  [0:0]         ddr3_cke     ,  //DDR3 ʱ��ʹ��
    output  [0:0]         ddr3_cs_n    ,  //DDR3 Ƭѡ
    output  [1:0]         ddr3_dm      ,  //DDR3_dm ********************************************
    output  [0:0]         ddr3_odt     ,  //DDR3_odt	
     //hdmi�ӿ�             
   //*************delete start************************************              
   // input                 hpdin        ,    
    //***************delete end****************************************
    output                tmds_clk_p   ,  // TMDS ʱ��ͨ��
    output                tmds_clk_n   ,
    output  [2:0]         tmds_data_p  ,  // TMDS ����ͨ��
    output  [2:0]         tmds_data_n , 
    //*************delete start************************************         
   // output                tmds_oen     ,  // TMDS ���ʹ��
   // output                hpdout		
      //***************delete end****************************************				                            
   //********************************������������λ��
    output    [10:0]  pixel_xpos               ,  //���ص������***********************************************
    output    [10:0]  pixel_ypos               ,  //���ص�������   *******************************************
    output    [10:0] rectangular_up   ,
    output    [10:0] rectangular_down ,
    output    [10:0] rectangular_left ,
    output    [10:0] rectangular_right,
    output    [10:0]  cnt_h,
    output    [10:0]  cnt_v,
    output           rectangular_flag 
    );     
                                
parameter  V_CMOS_DISP = 11'd768;                  //CMOS�ֱ���--��
parameter  H_CMOS_DISP = 11'd1024;                 //CMOS�ֱ���--��	
parameter  TOTAL_H_PIXEL = H_CMOS_DISP + 12'd1216; //CMOS�ֱ���--��
parameter  TOTAL_V_PIXEL = V_CMOS_DISP + 12'd504;    										   
							   
//wire define                          
wire         clk_50m                   ;  //50mhzʱ��
wire         locked                    ;  //ʱ�������ź�
wire         rst_n                     ;  //ȫ�ָ�λ 								    
wire         i2c_exec                  ;  //I2C����ִ���ź�****************************************
wire  [23:0] i2c_data                  ;  //I2CҪ���õĵ�ַ������(��8λ��ַ,��8λ����) **************      
wire         cam_init_done             ;  //����ͷ��ʼ�����
wire         i2c_done                  ;  //I2C�Ĵ�����������ź�*********************************
wire         i2c_dri_clk               ;  //I2C����ʱ��	*******************************************
wire         wr_en                     ;  //DDR3������ģ��дʹ��
wire  [15:0] wr_data                   ;  //DDR3������ģ��д����
wire         rdata_req                 ;  //DDR3������ģ���ʹ��
wire  [15:0] rd_data                   ;  //DDR3������ģ�������
wire         cmos_frame_valid          ;  //������Чʹ���ź�
wire         init_calib_complete       ;  //DDR3��ʼ�����init_calib_complete
wire         sys_init_done             ;  //ϵͳ��ʼ�����(DDR��ʼ��+����ͷ��ʼ��)
wire         clk_200m                  ;  //ddr3�ο�ʱ��
wire         cmos_frame_vsync          ;  //���֡��Ч��ͬ���ź�
wire         lcd_de                    ;  //LCD ��������ʹ��*******************************************
wire         cmos_frame_href           ;  //���֡��Ч��ͬ���ź� 
wire  [27:0] app_addr_rd_min           ;  //��DDR3����ʼ��ַ*******************************************
wire  [27:0] app_addr_rd_max           ;  //��DDR3�Ľ�����ַ********************************************
wire  [7:0]  rd_bust_len               ;  //��DDR3�ж�����ʱ��ͻ������**********************************
wire  [27:0] app_addr_wr_min           ;  //дDDR3����ʼ��ַ*******************************************
wire  [27:0] app_addr_wr_max           ;  //дDDR3�Ľ�����ַ*******************************************
wire  [7:0]  wr_bust_len               ;  //��DDR3��д����ʱ��ͻ������*********************************

wire         pixel_clk                   ;  //��Ƶ������LCD ����ʱ��**********************************
wire  [12:0] h_disp                    ;  //LCD��ˮƽ�ֱ���
wire  [12:0] v_disp                    ;  //LCD����ֱ�ֱ���     
wire  [10:0] h_pixel                   ;  //����ddr3��ˮƽ�ֱ��� **********no use**********************       
wire  [10:0] v_pixel                   ;  //����ddr3������ֱ�ֱ��� ***********no use ******************
wire  [15:0] lcd_id                    ;  //LCD����ID��**********************no use********************
wire  [27:0] ddr3_addr_max             ;  //����DDR3������д��ַ 
wire         i2c_rh_wl                 ;  //I2C��д�����ź�*********************no use***************           
wire  [7:0]  i2c_data_r                ;  //I2C������ **************************no use**************
wire  [12:0] total_h_pixel             ;  //ˮƽ�����ش�С *********************no use****************
wire  [12:0] total_v_pixel             ;  //��ֱ�����ش�С*********************no use*****************
wire  [2:0]  tmds_data_p               ;  // TMDS ����ͨ��
wire  [2:0]  tmds_data_n               ;
wire  [15:0] post_rgb                  ;  //������ͼ������
wire         post_frame_vsync          ;  //�����ĳ��ź�
wire         post_frame_de             ;  //������������Чʹ�� 

//*****************************************************
//**                    main code
//*****************************************************

//��ʱ�������������λ�����ź�
assign  rst_n = sys_rst_n & locked;

//ϵͳ��ʼ����ɣ�DDR3��ʼ�����
assign  sys_init_done = init_calib_complete;

 //ov5640 ����
ov5640_dri u_ov5640_dri(
    .clk               (clk_50m),
    .rst_n             (rst_n),

    .cam_pclk          (cam_pclk ),
    .cam_vsync         (cam_vsync),
    .cam_href          (cam_href ),
    .cam_data          (cam_data ),
    .cam_rst_n         (cam_rst_n),
    .cam_pwdn          (cam_pwdn ),
    .cam_scl           (cam_scl  ),
    .cam_sda           (cam_sda  ),
    
    .capture_start     (init_calib_complete),
    .cmos_h_pixel      (H_CMOS_DISP),
    .cmos_v_pixel      (V_CMOS_DISP),
    .total_h_pixel     (TOTAL_H_PIXEL),
    .total_v_pixel     (TOTAL_V_PIXEL),
    .cmos_frame_vsync  (cmos_frame_vsync),
    .cmos_frame_href   (cmos_frame_href ),
    .cmos_frame_valid  (cmos_frame_valid),
    .cmos_frame_data   (wr_data         )
    );   

wire                 post_frame_vsync_1    ;
wire                 post_frame_hsync_1    ;
wire                 post_frame_de_1       ;
wire   [7:0 ]        img_y                 ;
                                      


rgb2ycbcr u_rgb2ycbcr(
    //module clock
    .clk             (cam_pclk    ),            // ʱ���ź�
    .rst_n           (rst_n  ),            // ��λ�źţ�����Ч��
    //ͼ����ǰ�����ݽӿ�
    .pre_frame_vsync (cmos_frame_vsync),    // vsync�ź�
    .pre_frame_hsync (cmos_frame_href ),    // href�ź�
    .pre_frame_de    (cmos_frame_valid ),    // data enable�ź�
    .img_red         (wr_data[15:11] ),
    .img_green       (wr_data[10:5 ] ),
    .img_blue        (wr_data[ 4:0 ] ),
    //ͼ���������ݽӿ�
    .post_frame_vsync(post_frame_vsync_1),   // vsync�ź�
    .post_frame_hsync(post_frame_hsync_1),   // href�ź�
    .post_frame_de   (post_frame_de_1   ),      // data enable�ź�
    .img_y           (img_y             ),
    .img_cb          (),
    .img_cr          ()
);

wire   [15:0]    pre_y;
ddr3_top u_ddr3_top (
    .clk_200m            (clk_200m),                  //ϵͳʱ��
    .sys_rst_n           (rst_n),                     //��λ,����Ч
    .sys_init_done       (sys_init_done),             //ϵͳ��ʼ�����
    .init_calib_complete (init_calib_complete),       //ddr3��ʼ������ź�    
    //ddr3�ӿ��ź�       
    .app_addr_rd_min     (28'd0),                     //��DDR3����ʼ��ַ
    .app_addr_rd_max     (H_CMOS_DISP*V_CMOS_DISP),   //��DDR3�Ľ�����ַ***************better****
    .rd_bust_len         (H_CMOS_DISP[10:3]),         //��DDR3�ж�����ʱ��ͻ������****[10:3] -> [10:4]
    .app_addr_wr_min     (28'd0),                     //дDDR3����ʼ��ַ
    .app_addr_wr_max     (H_CMOS_DISP*V_CMOS_DISP),   //дDDR3�Ľ�����ַ***************better******
    .wr_bust_len         (H_CMOS_DISP[10:3]),         //��DDR3��д����ʱ��ͻ������****[10:3] -> [10:4]   
    // DDR3 IO�ӿ�              
    .ddr3_dq             (ddr3_dq),                   //DDR3 ����
    .ddr3_dqs_n          (ddr3_dqs_n),                //DDR3 dqs��
    .ddr3_dqs_p          (ddr3_dqs_p),                //DDR3 dqs��  
    .ddr3_addr           (ddr3_addr),                 //DDR3 ��ַ   
    .ddr3_ba             (ddr3_ba),                   //DDR3 banck ѡ��
    .ddr3_ras_n          (ddr3_ras_n),                //DDR3 ��ѡ��
    .ddr3_cas_n          (ddr3_cas_n),                //DDR3 ��ѡ��
    .ddr3_we_n           (ddr3_we_n),                 //DDR3 ��дѡ��
    .ddr3_reset_n        (ddr3_reset_n),              //DDR3 ��λ
    .ddr3_ck_p           (ddr3_ck_p),                 //DDR3 ʱ����
    .ddr3_ck_n           (ddr3_ck_n),                 //DDR3 ʱ�Ӹ�  
    .ddr3_cke            (ddr3_cke),                  //DDR3 ʱ��ʹ��
    .ddr3_cs_n           (ddr3_cs_n),                 //DDR3 Ƭѡ
    .ddr3_dm             (ddr3_dm),                   //DDR3_dm
    .ddr3_odt            (ddr3_odt),                  //DDR3_odt
    //�û�                                            
    .ddr3_read_valid     (1'b1),                      //DDR3 ��ʹ��
    .ddr3_pingpang_en    (1'b1),                      //DDR3 ƹ�Ҳ���ʹ��
    .wr_clk              (cam_pclk),                  //дʱ��
    .wr_load             (post_frame_vsync_1),          //����Դ�����ź�   
	.datain_valid        (post_frame_de_1),             //������Чʹ���ź�
    .datain              (img_y),//post_rgb),                  //��Ч���� 
    .rd_clk              (pixel_clk),                 //��ʱ�� 
    .rd_load             (rd_vsync),                  //���Դ�����ź�    
    .dataout             (pre_y),                   //rfifo�������
    .rdata_req           (rdata_req)                  //������������   
     ); 
     
  wire [7:0] Diff_Threshold;  
 assign Diff_Threshold = 8'd20;
 
  wire  post_frame_clken  ;
  wire [15:0] post_img     ;   
  wire rd_vsync;
  wire rdata_req;
  wire post_3_frame_vsync ;
  wire post_3_frame_href  ;
  wire post_3_frame_clken ;
  wire post_3_img_Bit     ;

 //ͼ����ģ��
vip u_vip(
    //module clock
    .clk              (pixel_clk),          // ʱ���ź�
    .rst_n            (rst_n ),            // ��λ�źţ�����Ч��
    
     .IMG_HDISP     (H_CMOS_DISP), 
     .IMG_VDISP     (V_CMOS_DISP), 
    //huiduhua1deshuru
     .pre_frame_vsync_1  (rd_vsync),
     .pre_frame_hsync_1  (video_hs),
     .pre_frame_de_1     (video_de),
     .pre_rgb_1          (pre_y ),
     .xpos             (pixel_xpos),
     .ypos             (pixel_ypos),     
    
    .Diff_Threshold   (Diff_Threshold),
    //ͼ���������ݽӿ�
    . post_frame_vsync (post_frame_vsync),  // �����ĳ��ź�
    . post_frame_href  (post_frame_href ),                 // ���������ź�
    . post_frame_clken (post_frame_clken),     // ������������Чʹ�� 
    .  post_img        (post_img         ),           // ������ͼ������
    
    //**********************zuobiao 
    .rectangular_up   (rectangular_up    ),
    .rectangular_down (rectangular_down  ),
    .rectangular_left (rectangular_left  ),
    .rectangular_right(rectangular_right ),
    .rectangular_flag (rectangular_flag  ) 
//   //pengzhanghoudejieguo
//    .post_3_frame_vsync (post_3_frame_vsync),
//    .post_3_frame_href  (post_3_frame_href),
//    .post_3_frame_clken (post_3_frame_clken),
//    .post_3_img_Bit     (post_3_img_Bit)
);  
//assign post_img={16{post_3_img_Bit}};
wire video_hs;
wire video_de;
//HDMI������ʾģ��    
hdmi_top u_hdmi_top(
    .pixel_clk            (pixel_clk),
    .pixel_clk_5x         (pixel_clk_5x),    
    .sys_rst_n            (sys_init_done & rst_n),
    //hdmi�ӿ�
    //***************delete start***************************
   // .hpdin                (hpdin),       
    //***************delete end ***************************              
    .tmds_clk_p           (tmds_clk_p),    // TMDS ʱ��ͨ��
    .tmds_clk_n           (tmds_clk_n),
    .tmds_data_p          (tmds_data_p),   // TMDS ����ͨ��
    .tmds_data_n          (tmds_data_n),
    //***************delete start***************************
   // .tmds_oen             (tmds_oen),      // TMDS ���ʹ��
   // .hpdout               (hpdout),
    //***************delete end ***************************       
    //xuyaoshuju
   
    .video_hs_i           (post_frame_href  ),
    .video_vs_i           (post_frame_vsync ),
    .video_de_i           (post_frame_clken ),
    
    //�û��ӿ� 
    .video_vs             (rd_vsync),      //HDMI���ź� 
    .video_hs             (video_hs), 
    .video_de             (video_de),
    
    .h_disp               (h_disp),        //HDMI��ˮƽ�ֱ���
    .v_disp               (v_disp),        //HDMI����ֱ�ֱ���   
    .pixel_xpos           (pixel_xpos),    //���ص������
    .pixel_ypos           (pixel_ypos),          
    .cnt_h          (cnt_h),
    .cnt_v          (cnt_v),
    .data_in              (post_img),       //�������� 
    .data_req             (rdata_req)      //������������   
);   

 clk_wiz_0 u_clk_wiz_0
   (
    // Clock out ports
    .clk_out1              (clk_200m),     
    .clk_out2              (clk_50m),
    .clk_out3              (pixel_clk_5x),
    .clk_out4              (pixel_clk),
    // Status and control signals
    .reset                 (1'b0), 
    .locked                (locked),       
   // Clock in ports
    .clk_in1               (sys_clk)
    );     
 
endmodule