/*                                                                      
 Copyright 2018-2020 Nuclei System Technology, Inc.                
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
  Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */                                                                      
                                                                         
                                                                         
                                                                         
//=====================================================================
//
// Designer   : Bob Hu
//
// Description:
//  The top module of the example AXI slave
//
// ====================================================================
module sirv_expl_axi_slv #(
    parameter AW = 32,
    parameter DW = 32 
)(
  input  axi_arvalid,
  output axi_arready,
  input  [AW-1:0] axi_araddr,
  input  [3:0] axi_arcache,
  input  [2:0] axi_arprot,
  input  [1:0] axi_arlock,
  input  [1:0] axi_arburst,
  input  [3:0] axi_arlen,
  input  [2:0] axi_arsize,

  input  axi_awvalid,
  output axi_awready,
  input  [AW-1:0] axi_awaddr,
  input  [3:0] axi_awcache,
  input  [2:0] axi_awprot,
  input  [1:0] axi_awlock,
  input  [1:0] axi_awburst,
  input  [3:0] axi_awlen,
  input  [2:0] axi_awsize,

  output reg axi_rvalid,
  input  axi_rready,
  //output reg [DW-1:0] axi_rdata,
  output reg [10:0] axi_rdata,
  output [1:0] axi_rresp,
  output axi_rlast,

  input  axi_wvalid,
  output axi_wready,
  input  [DW-1:0] axi_wdata,
  input  [(DW/8)-1:0] axi_wstrb,
  input  axi_wlast,

  output axi_bvalid,
  input  axi_bready,
  output [1:0] axi_bresp,

  input  clk,  
  input  rst_n,
  //*****************ISP to OUTER
  input                 sys_clk      ,   //50M Hz
  input                 cam_pclk     ,  //cmos ???????????
  input                 cam_vsync    ,  //cmos ????????
  input                 cam_href     ,  //cmos ????????
  input   [7:0]         cam_data     ,  //cmos ????
  output                cam_rst_n    ,  //cmos ??��??????????��
  output                cam_pwdn     ,  //???????????? 0???????? 1???????????
  output                cam_scl      ,  //cmos SCCB_SCL??
  inout                 cam_sda      ,  //cmos SCCB_SDA??       
  // DDR3                            
  inout   [15:0]        ddr3_dq      ,  //DDR3 ???? ***********15->31****************************
  inout   [1:0]         ddr3_dqs_n   ,  //DDR3 dqs?? ***************************************
  inout   [1:0]         ddr3_dqs_p   ,  //DDR3 dqs??  *****************************************
  output  [13:0]        ddr3_addr    ,  //DDR3 ???   
  output  [2:0]         ddr3_ba      ,  //DDR3 banck ???
  output                ddr3_ras_n   ,  //DDR3 ?????
  output                ddr3_cas_n   ,  //DDR3 ?????
  output                ddr3_we_n    ,  //DDR3 ??��???
  output                ddr3_reset_n ,  //DDR3 ??��
  output  [0:0]         ddr3_ck_p    ,  //DDR3 ?????
  output  [0:0]         ddr3_ck_n    ,  //DDR3 ????
  output  [0:0]         ddr3_cke     ,  //DDR3 ??????
  output  [0:0]         ddr3_cs_n    ,  //DDR3 ??
  output  [1:0]         ddr3_dm      ,  //DDR3_dm ********************************************
  output  [0:0]         ddr3_odt     ,  //DDR3_odt	
   //hdmi???             
 //*************delete start************************************              
 // input                 hpdin        ,    
  //***************delete end****************************************
  output                tmds_clk_p   ,  // TMDS ??????
  output                tmds_clk_n   ,
  output  [2:0]         tmds_data_p  ,  // TMDS ???????
  output  [2:0]         tmds_data_n  
);

//********************************������������λ��
    wire    [10:0] rectangular_up    ;
    wire    [10:0] rectangular_down  ;
    wire    [10:0] rectangular_left  ;
    wire    [10:0] rectangular_right ;
    
    
    wire           rectangular_flag  ;
    wire    [10:0] pixel_xpos      ;
    wire    [10:0] pixel_ypos      ;
    wire    [10:0]  cnt_h;
    wire    [10:0]  cnt_v;
    
    wire [11:0]  Y = rectangular_up + rectangular_down;
    wire [11:0]  X = rectangular_left + rectangular_right;
  //assign axi_rvalid = axi_arvalid;
  assign axi_arready = axi_rready;

  //assign axi_rdata = {DW{1'b0}};
  assign axi_rresp = 2'b0;
  assign axi_rlast = 1'b1;

  assign axi_bvalid = axi_wvalid;
  assign axi_wready = axi_bready;
  assign axi_bresp  = 2'b0;

  assign axi_awready = 1'b1;

  reg  start;
  reg [10:0] isp_x, isp_y;
  reg [10:0] r_up    ;
  reg [10:0] r_down  ;
  reg [10:0] r_left  ;
  reg [10:0] r_right ;
  reg [10:0] r_pixel_xpos;
  reg [10:0] r_pixel_ypos;
  reg        r_flag  ;
  reg    [10:0]  cnt_h_r;
  reg    [10:0]  cnt_v_r;
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
       start <= 1'b0;
    end else begin
       if (axi_awvalid & axi_awready & (axi_awaddr == 32'h1004_1000)) begin
          start <= axi_wdata;
       end else begin
          start <= start;
       end
    end
  end

  /* always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
       axi_rdata <= 32'b0;
       axi_rvalid <= 1'b0;
    end else begin
       if (axi_arvalid & axi_arready & (axi_araddr == 32'h1004_1004)) begin
          axi_rdata <= isp_x;
          axi_rvalid <= 1'b1;
       end else begin
          axi_rdata <= axi_rdata;
          axi_rvalid <= 1'b0;
       end
    end
  end*/
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
       //axi_rdata <= 32'b0;
       axi_rdata <= 11'b0;
       axi_rvalid <= 1'b0;
    end else begin
       if (axi_arvalid & axi_arready) begin
          case(axi_araddr)
            32'h1004_1004 : begin 
                axi_rdata <= isp_x;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_1008 : begin 
                axi_rdata <= isp_y;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_100C : begin 
                axi_rdata <=  r_up;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_1010 : begin 
                axi_rdata <= r_down;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_1014 : begin 
                axi_rdata <= r_left;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_1018 : begin 
                axi_rdata <= r_right;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_101C : begin 
                axi_rdata <= r_flag;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_1020 : begin 
                axi_rdata <= r_pixel_xpos;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_1024 : begin 
                axi_rdata <= r_pixel_ypos;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_1028 : begin 
                axi_rdata <= cnt_h_r;
                axi_rvalid <= 1'b1;
            end
            
            32'h1004_102C : begin 
                axi_rdata <= cnt_v_r;
                axi_rvalid <= 1'b1;
            end
            
            default : begin 
                axi_rdata <= axi_rdata;
                axi_rvalid <= 1'b0;
            end
          endcase
       end else begin
          axi_rdata <= axi_rdata;
          axi_rvalid <= 1'b0;
       end
    end
  end
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
       isp_y <= 11'b0;
       isp_x <= 11'b0;
       r_up   <= 11'b0;
       r_down <= 11'b0;
       r_left <= 11'b0;
       r_right<= 11'b0;
       r_flag <= 11'b0;
       r_pixel_xpos <= 11'b0;   
       r_pixel_ypos <= 11'b0;   
       cnt_h_r  <= 11'b0;    
       cnt_v_r  <= 11'b0;    
    end else begin
       if(rectangular_flag) begin
       //if(1) begin
          isp_y <= Y[11:1];
          isp_x <= X[11:1];
          r_up   <= rectangular_up   ;
          r_down <= rectangular_down ;
          r_left <= rectangular_left ;
          r_right<= rectangular_right;
          r_flag <= rectangular_flag ;
          r_pixel_xpos <= pixel_xpos      ;   
          r_pixel_ypos <= pixel_ypos      ;   
          cnt_h_r  <= cnt_h;
          cnt_v_r  <= cnt_v;
       end else begin
          isp_y <= isp_y;
          isp_x <= isp_x;  
          r_up   <= r_up   ;
          r_down <= r_down ;
          r_left <= r_left ;
          r_right<= r_right;
          r_flag <= 0 ;
          r_pixel_xpos <= r_pixel_xpos;
          r_pixel_ypos <= r_pixel_ypos;
          cnt_h_r  <= cnt_h_r;
          cnt_v_r  <= cnt_v_r;
       end
    end
  end
/*  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
       axi_rdata <= 32'b0;
       axi_rvalid <= 1'b0;
    end else begin
       if (axi_arvalid & axi_arready & (axi_araddr == 32'h1004_1008)) begin
          axi_rdata <= isp_y;
          axi_rvalid <= 1'b1;
       end else begin
          axi_rdata <= axi_rdata;
          axi_rvalid <= 1'b0;
       end
    end
  end
  */
ov5640_ddr_hdmi isp(    
    .sys_clk      (sys_clk),  //ϵͳʱ��
    .sys_rst_n    (start),  //ϵͳ��λ���͵�ƽ��Ч
    //����ͷ�ӿ�       ()                
    .cam_pclk     (cam_pclk),  //cmos ��������ʱ��
    .cam_vsync    (cam_vsync),  //cmos ��ͬ���ź�
    .cam_href     (cam_href),  //cmos ��ͬ���ź�
    .cam_data     (cam_data),  //cmos ����
    .cam_rst_n    (cam_rst_n),  //cmos ��λ�źţ��͵�ƽ��Ч
    .cam_pwdn     (cam_pwdn),  //��Դ����ģʽѡ�� 0������ģʽ 1����Դ����ģʽ
    .cam_scl      (cam_scl),  //cmos SCCB_SCL��
    .cam_sda      (cam_sda),  //cmos SCCB_SDA��       
    // DDR3       ()                     
    .ddr3_dq      (ddr3_dq),  //DDR3 ���� ***********15->31****************************
    .ddr3_dqs_n   (ddr3_dqs_n),  //DDR3 dqs�� ***************************************
    .ddr3_dqs_p   (ddr3_dqs_p),  //DDR3 dqs��  *****************************************
    .ddr3_addr    (ddr3_addr),  //DDR3 ��ַ   
    .ddr3_ba      (ddr3_ba),  //DDR3 banck ѡ��
    .ddr3_ras_n   (ddr3_ras_n),  //DDR3 ��ѡ��
    .ddr3_cas_n   (ddr3_cas_n),  //DDR3 ��ѡ��
    .ddr3_we_n    (ddr3_we_n),  //DDR3 ��дѡ��
    .ddr3_reset_n (ddr3_reset_n),  //DDR3 ��λ
    .ddr3_ck_p    (ddr3_ck_p),  //DDR3 ʱ����
    .ddr3_ck_n    (ddr3_ck_n),  //DDR3 ʱ�Ӹ�
    .ddr3_cke     (ddr3_cke),  //DDR3 ʱ��ʹ��
    .ddr3_cs_n    (ddr3_cs_n),  //DDR3 Ƭѡ
    .ddr3_dm      (ddr3_dm),  //DDR3_dm ********************************************
    .ddr3_odt     (ddr3_odt),  //DDR3_odt	
     //hdmi�ӿ�     ()        
   //*************()delete start************************************              
   // input       ()          hpdin        ,    
    //************()***delete end****************************************
    .tmds_clk_p   (tmds_clk_p),  // TMDS ʱ��ͨ��
    .tmds_clk_n   (tmds_clk_n),
    .tmds_data_p  (tmds_data_p),  // TMDS ����ͨ��
    .tmds_data_n  (tmds_data_n),
    
    //**********************zuobiao 
    .pixel_xpos       (pixel_xpos),
    .pixel_ypos       (pixel_ypos),
    .rectangular_up   (rectangular_up    ),
    .rectangular_down (rectangular_down  ),
    .rectangular_left (rectangular_left  ),
    .rectangular_right(rectangular_right ),
    .cnt_h          (cnt_h),
    .cnt_v          (cnt_v),
    .rectangular_flag (rectangular_flag  ) 

    );     

endmodule
