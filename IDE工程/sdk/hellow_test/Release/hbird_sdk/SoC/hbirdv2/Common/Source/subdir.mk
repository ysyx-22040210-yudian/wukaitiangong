################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../hbird_sdk/SoC/hbirdv2/Common/Source/hbirdv2_common.c \
../hbird_sdk/SoC/hbirdv2/Common/Source/system_hbirdv2.c 

OBJS += \
./hbird_sdk/SoC/hbirdv2/Common/Source/hbirdv2_common.o \
./hbird_sdk/SoC/hbirdv2/Common/Source/system_hbirdv2.o 

C_DEPS += \
./hbird_sdk/SoC/hbirdv2/Common/Source/hbirdv2_common.d \
./hbird_sdk/SoC/hbirdv2/Common/Source/system_hbirdv2.d 


# Each subdirectory must supply rules for building sources it contributes
hbird_sdk/SoC/hbirdv2/Common/Source/%.o: ../hbird_sdk/SoC/hbirdv2/Common/Source/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv-nuclei-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -mno-save-restore -O2 -ffunction-sections -fdata-sections -fno-common  -g -D__IDE_RV_CORE=null -DSOC_HBIRDV2 -DDOWNLOAD_MODE=DOWNLOAD_MODE_ILM -DDOWNLOAD_MODE_STRING=\"ILM\" -DBOARD_DDR200T -I"E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\hbird_sdk\NMSIS\Core\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\hbird_sdk\SoC\hbirdv2\Common\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\hbird_sdk\SoC\hbirdv2\Board\ddr200t\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\application" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


