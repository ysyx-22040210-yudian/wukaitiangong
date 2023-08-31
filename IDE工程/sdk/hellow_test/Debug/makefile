################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include hbird_sdk/SoC/hbirdv2/Common/Source/Stubs/subdir.mk
-include hbird_sdk/SoC/hbirdv2/Common/Source/GCC/subdir.mk
-include hbird_sdk/SoC/hbirdv2/Common/Source/Drivers/subdir.mk
-include hbird_sdk/SoC/hbirdv2/Common/Source/subdir.mk
-include application/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
SECONDARY_FLASH += \
hellow_test.hex \

SECONDARY_LIST += \
hellow_test.lst \

SECONDARY_SIZE += \
hellow_test.siz \


# All Target
all: hellow_test.elf secondary-outputs

# Tool invocations
hellow_test.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU RISC-V Cross C++ Linker'
	riscv-nuclei-elf-g++ -march=rv32im -mabi=ilp32 -mcmodel=medany -mno-save-restore -funroll-all-loops -finline-limit=600 -ftree-dominator-opts -fno-if-conversion2 -fselective-scheduling -fno-code-hoisting -funroll-loops -finline-functions -falign-functions=4 -falign-jumps=4 -falign-loops=4 -O2 -ffunction-sections -fdata-sections -fno-common  -g -T "E:\VMshare\e203\zhengdian_E203\sdk\hellow_test\hbird_sdk\SoC\hbirdv2\Board\ddr200t\Source\GCC\gcc_hbirdv2_ilm.ld" -nostartfiles -Xlinker --gc-sections -Wl,-Map,"hellow_test.map" --specs=nano.specs --specs=nosys.specs -u _isatty -u _write -u _sbrk -u _read -u _close -u _fstat -u _lseek -o "hellow_test.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	$(MAKE) --no-print-directory post-build

hellow_test.hex: hellow_test.elf
	@echo 'Invoking: GNU RISC-V Cross Create Flash Image'
	riscv-nuclei-elf-objcopy -O ihex "hellow_test.elf"  "hellow_test.hex"
	@echo 'Finished building: $@'
	@echo ' '

hellow_test.lst: hellow_test.elf
	@echo 'Invoking: GNU RISC-V Cross Create Listing'
	riscv-nuclei-elf-objdump --source --all-headers --demangle --line-numbers --wide "hellow_test.elf" > "hellow_test.lst"
	@echo 'Finished building: $@'
	@echo ' '

hellow_test.siz: hellow_test.elf
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	riscv-nuclei-elf-size --format=berkeley "hellow_test.elf"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(CC_DEPS)$(C++_DEPS)$(OBJS)$(C_UPPER_DEPS)$(CXX_DEPS)$(SECONDARY_FLASH)$(SECONDARY_LIST)$(SECONDARY_SIZE)$(ASM_DEPS)$(S_UPPER_DEPS)$(C_DEPS)$(CPP_DEPS) hellow_test.elf
	-@echo ' '

post-build:
	-riscv-nuclei-elf-objcopy -O verilog "hellow_test.elf" "hellow_test.verilog";sed -i 's/@800/@000/g' "hellow_test.verilog"; sed -i 's/@00002FB8/@00002000/g' "hellow_test.verilog";
	-@echo ' '

secondary-outputs: $(SECONDARY_FLASH) $(SECONDARY_LIST) $(SECONDARY_SIZE)

.PHONY: all clean dependents post-build

-include ../makefile.targets
