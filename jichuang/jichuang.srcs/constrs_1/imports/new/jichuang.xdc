#============================================================================
#
#
#	Bing
#
#
#----------------------------------------------------------------------------



#=========================== Sys Clock & rstn ================================
## Clock Signal     50M
set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS15 } [get_ports { clk }]; #R4
create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports clk]
##set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets sys_clk_gen/inst/CLK_I_50M_PLL]; 
## mcu Rst_n
set_property -dict { PACKAGE_PIN U7  IOSTANDARD LVCMOS15 } [get_ports { mcu_rst }]; #PL_KEY1   U7
#----------------------------------------------------------------------------

#---------------------------ISP-------------------------------------------------
#HDMI½Ó¿Ú
set_property PACKAGE_PIN J22 [get_ports {tmds_data_p[0]}]
set_property PACKAGE_PIN K21 [get_ports {tmds_data_p[1]}]
set_property PACKAGE_PIN H20 [get_ports {tmds_data_p[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_data_p[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_data_p[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_data_p[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports tmds_oen]
#set_property PACKAGE_PIN C20 [get_ports tmds_oen]
set_property PACKAGE_PIN J20 [get_ports tmds_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports tmds_clk_p]
#set_property IOSTANDARD LVCMOS33 [get_ports hpdin]
#set_property PACKAGE_PIN E22 [get_ports hpdin]
#set_property IOSTANDARD LVCMOS33 [get_ports hpdout]
#set_property PACKAGE_PIN G18 [get_ports hpdout]

#CAMERA
create_clock -period 40.000 -name cmos_pclk [get_ports cam_pclk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cam_pclk_IBUF]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports cam_pclk]
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports cam_rst_n]
set_property -dict {PACKAGE_PIN AB18 IOSTANDARD LVCMOS33} [get_ports cam_pwdn]
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cam_data[0]}]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cam_data[1]}]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cam_data[2]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cam_data[3]}]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cam_data[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cam_data[5]}]
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cam_data[6]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33 IOB TRUE} [get_ports {cam_data[7]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports cam_vsync]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports cam_href]
set_property -dict {PACKAGE_PIN N13 IOSTANDARD LVCMOS33} [get_ports cam_scl]
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports cam_sda]
##------------------------------ISP END-----------------------------------------


#=========================== Debug JTAG ======================================

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IOBUF_jtag_TCK/O]

# mcu_TCK   N14
# mcu_TDO   R14
# mcu_TMS   P17
# rst
# mcu_TDI   P15
# JTAG Debug Port
set_property -dict { PACKAGE_PIN Y17  IOSTANDARD LVCMOS33 } [get_ports { mcu_TCK }]; #N14
set_property -dict { PACKAGE_PIN W10  IOSTANDARD LVCMOS33 } [get_ports { mcu_TDO }]; #R14
set_property -dict { PACKAGE_PIN AB10  IOSTANDARD LVCMOS33 } [get_ports { mcu_TMS }]; #P17
set_property -dict { PACKAGE_PIN T15  IOSTANDARD LVCMOS33 } [get_ports { mcu_TDI }]; #P15
set_property KEEPER true [get_ports mcu_TMS]

#------------------------ End of Debug JTAG ----------------------------------





#=============================== UART 0 ======================================

set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { uart0_tx }]; #D17
set_property -dict { PACKAGE_PIN E14   IOSTANDARD LVCMOS33 } [get_ports { uart0_rx }]; #E14

#---------------------------- End of UART 0 --------------------------------


#LED1       ---> V9
#LED2       ---> Y8
#LED3       ---> Y7
#LED4       ---> W7
#PL_KEY1    ---> T4
#PL_KEY2    ---> T3



## GPIOA
#LEDs
set_property -dict { PACKAGE_PIN V9   IOSTANDARD LVCMOS15 } [get_ports { gpioA_0 }]; # V9
set_property -dict { PACKAGE_PIN Y8   IOSTANDARD LVCMOS15 } [get_ports { gpioA_1 }]; # Y8
set_property -dict { PACKAGE_PIN Y7   IOSTANDARD LVCMOS15 } [get_ports { gpioA_2 }]; # Y7
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS15 } [get_ports { gpioA_3 }]; # W7

#KEY
set_property -dict { PACKAGE_PIN T4   IOSTANDARD LVCMOS15 } [get_ports { gpioA_4 }]; # T4

# 40P
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { gpioA_5 }]; # P18
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { gpioA_6 }]; # P19
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { gpioA_7 }]; # R18
#
#
### OLED Display
#set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { gpioA_20 }]; #OLED_DC          Y14
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { gpioA_21 }]; #OLED_RES         V16
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { gpioA_22 }]; #OLED_CLK   D0    U18
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { gpioA_23 }]; #OLED_SDIN  D1    T17
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { gpioA_24 }]; #VBAT             R17
#set_property -dict { PACKAGE_PIN W20   IOSTANDARD LVCMOS33 } [get_ports { gpioA_25 }]; #VDD              W20

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE Yes [current_design]





