################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../application/demo_nice.c \
../application/insn.c 

OBJS += \
./application/demo_nice.o \
./application/insn.o 

C_DEPS += \
./application/demo_nice.d \
./application/insn.d 


# Each subdirectory must supply rules for building sources it contributes
application/%.o: ../application/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv-nuclei-elf-gcc -march=rv32im -mabi=ilp32 -mcmodel=medany -mno-save-restore -funroll-all-loops -finline-limit=600 -ftree-dominator-opts -fno-if-conversion2 -fselective-scheduling -fno-code-hoisting -funroll-loops -finline-functions -falign-functions=4 -falign-jumps=4 -falign-loops=4 -O2 -ffunction-sections -fdata-sections -fno-common  -g -D__IDE_RV_CORE=null -DSOC_HBIRDV2 -DDOWNLOAD_MODE=DOWNLOAD_MODE_ILM -DDOWNLOAD_MODE_STRING=\"ILM\" -DBOARD_DDR200T -I"E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\hbird_sdk\NMSIS\Core\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\hbird_sdk\SoC\hbirdv2\Common\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\hbird_sdk\SoC\hbirdv2\Board\ddr200t\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\application" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


