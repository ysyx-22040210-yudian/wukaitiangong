################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../application/core_list_join.c \
../application/core_main.c \
../application/core_matrix.c \
../application/core_portme.c \
../application/core_state.c \
../application/core_util.c \
../application/insn.c 

OBJS += \
./application/core_list_join.o \
./application/core_main.o \
./application/core_matrix.o \
./application/core_portme.o \
./application/core_state.o \
./application/core_util.o \
./application/insn.o 

C_DEPS += \
./application/core_list_join.d \
./application/core_main.d \
./application/core_matrix.d \
./application/core_portme.d \
./application/core_state.d \
./application/core_util.d \
./application/insn.d 


# Each subdirectory must supply rules for building sources it contributes
application/%.o: ../application/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv-nuclei-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -mno-save-restore -funroll-all-loops -finline-limit=600 -ftree-dominator-opts -fno-if-conversion2 -fselective-scheduling -fno-code-hoisting -funroll-loops -finline-functions -falign-functions=4 -falign-jumps=4 -falign-loops=4 -O2 -ffunction-sections -fdata-sections -fno-common  -g -D__IDE_RV_CORE=null -DSOC_HBIRDV2 -DDOWNLOAD_MODE=DOWNLOAD_MODE_ILM -DDOWNLOAD_MODE_STRING=\"ILM\" -DBOARD_DDR200T -DFLAGS_STR=\""-O2 -funroll-all-loops -finline-limit=600 -ftree-dominator-opts -fno-if-conversion2 -fselective-scheduling -fno-code-hoisting -fno-common -funroll-loops -finline-functions -falign-functions=4 -falign-jumps=4 -falign-loops=4"\" -DITERATIONS=500 -DPERFORMANCE_RUN=1 -I"E:\VMshare\e203\zhengdian_E203\sdk\mark_decenc\hbird_sdk\NMSIS\Core\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\mark_decenc\hbird_sdk\SoC\hbirdv2\Common\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\mark_decenc\hbird_sdk\SoC\hbirdv2\Board\ddr200t\Include" -I"E:\VMshare\e203\zhengdian_E203\sdk\mark_decenc\application" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


