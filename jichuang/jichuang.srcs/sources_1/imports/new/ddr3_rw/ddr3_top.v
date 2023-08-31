
module ddr3_top(
    input              clk_200m            ,   //ddr3参考时钟
    input              sys_rst_n           ,   //复位,低有效
    input              sys_init_done       ,   //系统初始化完成               
    //DDR3接口信号                           
    input   [27:0]     app_addr_rd_min     ,   //读ddr3的起始地址
    input   [27:0]     app_addr_rd_max     ,   //读ddr3的结束地址
    input   [7:0]      rd_bust_len         ,   //从ddr3中读数据时的突发长度
    input   [27:0]     app_addr_wr_min     ,   //读ddr3的起始地址
    input   [27:0]     app_addr_wr_max     ,   //读ddr3的结束地址
    input   [7:0]      wr_bust_len         ,   //从ddr3中读数据时的突发长度
    // DDR3 IO接口 
    inout   [15:0]     ddr3_dq             ,   //ddr3 数据
    inout   [1:0]      ddr3_dqs_n          ,   //ddr3 dqs负
    inout   [1:0]      ddr3_dqs_p          ,   //ddr3 dqs正  
    output  [13:0]     ddr3_addr           ,   //ddr3 地址   
    output  [2:0]      ddr3_ba             ,   //ddr3 banck 选择
    output             ddr3_ras_n          ,   //ddr3 行选择
    output             ddr3_cas_n          ,   //ddr3 列选择
    output             ddr3_we_n           ,   //ddr3 读写选择
    output             ddr3_reset_n        ,   //ddr3 复位
    output  [0:0]      ddr3_ck_p           ,   //ddr3 时钟正
    output  [0:0]      ddr3_ck_n           ,   //ddr3 时钟负
    output  [0:0]      ddr3_cke            ,   //ddr3 时钟使能
    output  [0:0]      ddr3_cs_n           ,   //ddr3 片选
    output  [1:0]      ddr3_dm             ,   //ddr3_dm
    output  [0:0]      ddr3_odt            ,   //ddr3_odt      
    //用户
    input              ddr3_read_valid     ,   //DDR3 读使能   
    input              ddr3_pingpang_en    ,   //DDR3 乒乓操作使能       
    input              wr_clk              ,   //wfifo时钟   
    input              rd_clk              ,   //rfifo的读时钟      
    input              datain_valid        ,   //数据有效使能信号
    input   [7:0]      datain              ,   //有效数据 
    input              rdata_req           ,   //请求像素点颜色数据输入  
    input              rd_load             ,    //输出源更新信号
    input              wr_load             ,    //输入源更新信号
    output  [15:0]     dataout             ,   //rfifo输出数据
    output             init_calib_complete     //ddr3初始化完成信号
    );                
                      
 //wire define  
wire                  ui_clk               ;   //用户时钟
wire [27:0]           app_addr             ;   //ddr3 地址
wire [2:0]            app_cmd              ;   //用户读写命令
wire                  app_en               ;   //MIG IP核使能
wire                  app_rdy              ;   //MIG IP核空闲
wire [127:0]          app_rd_data          ;   //用户读数据
wire                  app_rd_data_end      ;   //突发读当前时钟最后一个数据 
wire                  app_rd_data_valid    ;   //读数据有效
wire [127:0]          app_wdf_data         ;   //用户写数据 
wire                  app_wdf_end          ;   //突发写当前时钟最后一个数据 
wire [15:0]           app_wdf_mask         ;   //写数据屏蔽                           
wire                  app_wdf_rdy          ;   //写空闲                               
wire                  app_sr_active        ;   //保留                                 
wire                  app_ref_ack          ;   //刷新请求                             
wire                  app_zq_ack           ;   //ZQ 校准请求                          
wire                  app_wdf_wren         ;   //ddr3 写使能                          
wire                  clk_ref_i            ;   //ddr3参考时钟                         
wire                  sys_clk_i            ;   //MIG IP核输入时钟                     
wire                  ui_clk_sync_rst      ;   //用户复位信号                         
wire [20:0]           rd_cnt               ;   //实际读地址计数                       
wire [3 :0]           state_cnt            ;   //状态计数器                           
wire [23:0]           rd_addr_cnt          ;   //用户读地址计数器                     
wire [23:0]           wr_addr_cnt          ;   //用户写地址计数器                     
wire                  rfifo_wren           ;   //从ddr3读出数据的有效使能             
wire [10:0]           wfifo_rcount         ;   //rfifo剩余数据计数                    
wire [10:0]           rfifo_wcount         ;   //wfifo写进数据计数  
wire                  init_calib_complete  ;   //ddr3初始化完成信号 

wire   [15:0]            datain_mux;
wire                  wr_end_wire; 
wire                   vsyncend_cnt;
reg  [1:0]            wr_end_wire_d;  
                                                                                                                                                                       
//*****************************************************                               
//**                    main code                                                     
//*****************************************************   
assign datain_mux =  (vsyncend==1'd0) ? {8'dz,datain} :{datain,8'dz};

//    always @(posedge rd_clk or negedge sys_rst_n)
//    begin
//        if (!sys_rst_n)
//        begin
//            wr_end_wire_d <= 2'b00;
//        end
//        else
//        begin
//            wr_end_wire_d <= {wr_end_wire_d[0],wr_end_wire};
//        end
//    end
                      
                                                                                      
//读写模块                                                                            
 ddr3_rw u_ddr3_rw(                                                                   
    .ui_clk               (ui_clk)              ,                                     
    .ui_clk_sync_rst      (ui_clk_sync_rst)     ,                                      
    //MIG 接口                                                                        
    .init_calib_complete  (init_calib_complete) ,   //ddr3初始化完成信号                                   
    .app_rdy              (app_rdy)             ,   //MIG IP核空闲                                   
    .app_wdf_rdy          (app_wdf_rdy)         ,   //写空闲                                   
    .app_rd_data_valid    (app_rd_data_valid)   ,   //读数据有效                                   
    .app_addr             (app_addr)            ,   //ddr3 地址                                   
    .app_en               (app_en)              ,   //MIG IP核使能                                   
    .app_wdf_wren         (app_wdf_wren)        ,   //ddr3 写使能                                    
    .app_wdf_end          (app_wdf_end)         ,   //突发写当前时钟最后一个数据                                   
    .app_cmd              (app_cmd)             ,   //用户读写命令                                                                                                                         
    //DDR3 地址参数                                                                   
    .app_addr_rd_min      (app_addr_rd_min)     ,   //读ddr3的起始地址                                  
    .app_addr_rd_max      (app_addr_rd_max)     ,   //读ddr3的结束地址                                  
    .rd_bust_len          (rd_bust_len)         ,   //从ddr3中读数据时的突发长度                                  
    .app_addr_wr_min      (app_addr_wr_min)     ,   //写ddr3的起始地址                                  
    .app_addr_wr_max      (app_addr_wr_max)     ,   //写ddr3的结束地址                                  
    .wr_bust_len          (wr_bust_len)         ,   //从ddr3中写数据时的突发长度                                  
    //用户接口                                                                        
    .rfifo_wren           (rfifo_wren)          ,   //从ddr3读出数据的有效使能 
    .rd_load              (rd_load)             ,   //输出源更新信号
    .wr_load              (wr_load)             ,   //输入源更新信号
    .ddr3_read_valid      (ddr3_read_valid)     ,   //DDR3 读使能
    .ddr3_pingpang_en     (ddr3_pingpang_en)    ,   //DDR3 乒乓操作使能    
    .wfifo_rcount         (wfifo_rcount)        ,   //rfifo剩余数据计数                  
    .rfifo_wcount         (rfifo_wcount)        ,            //wfifo写进数据计数
    .app_wdf_mask         (app_wdf_mask)        ,
    .vsyncend            (vsyncend)        
   // .wr_end_o             (wr_end_wire)
    );
    
//MIG IP核模块
mig_7series_0 u_mig_7series_0 (
    // Memory interface ports
    .ddr3_addr           (ddr3_addr)            ,         
    .ddr3_ba             (ddr3_ba)              ,            
    .ddr3_cas_n          (ddr3_cas_n)           ,         
    .ddr3_ck_n           (ddr3_ck_n)            ,        
    .ddr3_ck_p           (ddr3_ck_p)            ,          
    .ddr3_cke            (ddr3_cke)             ,            
    .ddr3_ras_n          (ddr3_ras_n)           ,         
    .ddr3_reset_n        (ddr3_reset_n)         ,      
    .ddr3_we_n           (ddr3_we_n)            ,        
    .ddr3_dq             (ddr3_dq)              ,            
    .ddr3_dqs_n          (ddr3_dqs_n)           ,        
    .ddr3_dqs_p          (ddr3_dqs_p)           ,                                                       
	.ddr3_cs_n           (ddr3_cs_n)            ,                         
    .ddr3_dm             (ddr3_dm)              ,    
    .ddr3_odt            (ddr3_odt)             ,          
    // Application interface ports                                        
    .app_addr            (app_addr)             ,         
    .app_cmd             (app_cmd)              ,          
    .app_en              (app_en)               ,        
    .app_wdf_data        (app_wdf_data)         ,      
    .app_wdf_end         (app_wdf_end)          ,       
    .app_wdf_wren        (app_wdf_wren)         ,           
    .app_rd_data         (app_rd_data)          ,       
    .app_rd_data_end     (app_rd_data_end)      ,                                        
    .app_rd_data_valid   (app_rd_data_valid)    ,     
    .init_calib_complete (init_calib_complete)  ,            
                                                     
    .app_rdy             (app_rdy)              ,      
    .app_wdf_rdy         (app_wdf_rdy)          ,          
    .app_sr_req          ('b0)                  ,                    
    .app_ref_req         ('b0)                  ,              
    .app_zq_req          ('b0)                  ,             
    .app_sr_active       (app_sr_active)        ,        
    .app_ref_ack         (app_ref_ack)          ,         
    .app_zq_ack          (app_zq_ack)           ,             
    .ui_clk              (ui_clk)               ,                
    .ui_clk_sync_rst     (ui_clk_sync_rst)      ,                                               
    .app_wdf_mask        (app_wdf_mask)                ,    
    // System Clock Ports                            
    .sys_clk_i           (clk_200m)             ,    
    // Reference Clock Ports                         
    .clk_ref_i           (clk_200m)             ,    
    .sys_rst             (sys_rst_n)                 
    );                                               
                                                     
ddr3_fifo_ctrl u_ddr3_fifo_ctrl (

    .rst_n               (sys_rst_n &&sys_init_done )  ,  
    //输入源接口
    .wr_clk              (wr_clk)                      ,
    .rd_clk              (rd_clk)                      ,
    .clk_100             (ui_clk)                      ,    //用户时钟 
    .datain_valid        (datain_valid)                ,    //数据有效使能信号
    .datain              (datain_mux)                      ,    //有效数据 
    .rfifo_din           (app_rd_data)                 ,    //用户读数据 
    .rdata_req           (rdata_req )                   , //&& wr_end_wire_d[1]   //请求像素点颜色数据输入 
    .rfifo_wren          (rfifo_wren)                  ,    //ddr3读出数据的有效使能 
    .wfifo_rden          (app_wdf_wren)                ,    //ddr3 写使能         
    //用户接口
    .wfifo_rcount        (wfifo_rcount)                ,    //rfifo剩余数据计数                 
    .rfifo_wcount        (rfifo_wcount)                ,    //wfifo写进数据计数                
    .wfifo_dout          (app_wdf_data)                ,    //用户写数据 
    .rd_load             (rd_load)                     ,    //输出源更新信号
    .wr_load             (wr_load)                     ,    //输入源更新信号
    .pic_data            (dataout)                       //rfifo输出数据        	
    );
    
//ila_0 your_instance_name (
//	.clk(rd_clk), // input wire clk


//	.probe0(dataout[15:8]), // input wire [7:0]  probe0  
//	.probe1(dataout[7:0]), // input wire [7:0]  probe1 
//	.probe2(vsyncend_cnt) // input wire [1:0]  probe2 
//);
endmodule