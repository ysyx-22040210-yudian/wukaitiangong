@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Wed May 31 02:53:42 +0800 2023
REM SW Build 2708876 on Wed Nov  6 21:40:23 MST 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto b35d37c62f0b4c22b54f9f35bffab06e --incr --debug typical --relax --mt 2 -L xil_defaultlib -L xbip_utils_v3_0_10 -L c_reg_fd_v12_0_6 -L c_mux_bit_v12_0_6 -L c_shift_ram_v12_0_14 -L fifo_generator_v13_2_5 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot e203_tb_top_behav xil_defaultlib.e203_tb_top xil_defaultlib.glbl -log elaborate.log"
call xelab  -wto b35d37c62f0b4c22b54f9f35bffab06e --incr --debug typical --relax --mt 2 -L xil_defaultlib -L xbip_utils_v3_0_10 -L c_reg_fd_v12_0_6 -L c_mux_bit_v12_0_6 -L c_shift_ram_v12_0_14 -L fifo_generator_v13_2_5 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot e203_tb_top_behav xil_defaultlib.e203_tb_top xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
