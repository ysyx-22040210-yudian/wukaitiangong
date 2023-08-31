@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Wed May 31 02:54:34 +0800 2023
REM SW Build 2708876 on Wed Nov  6 21:40:23 MST 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim e203_tb_top_behav -key {Behavioral:sim_1:Functional:e203_tb_top} -tclbatch e203_tb_top.tcl -view E:/VMshare/e203/script/jichuang/jichuang.srcs/sim_1/imports/e203/jichuang/jichuang.sim/e203_tb_top_behav.wcfg -log simulate.log"
call xsim  e203_tb_top_behav -key {Behavioral:sim_1:Functional:e203_tb_top} -tclbatch e203_tb_top.tcl -view E:/VMshare/e203/script/jichuang/jichuang.srcs/sim_1/imports/e203/jichuang/jichuang.sim/e203_tb_top_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0