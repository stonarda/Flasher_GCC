
ASS_FILES=
INCL_DIRS=
SRC_FILES=

OUTPUT_NAME="Flash"

##### Target #####
TARGET_ARCH=armv6-m
TARGET_FREQ=12000000

##### Toolchain #####
CC=arm-none-eabi-gcc
LINKER_SCRIPT:=flash_Debug.ld
C_FLAGS=-march=$(TARGET_ARCH) -mcpu=cortex-m0plus -mthumb -nostdlib -Xlinker --gc-sections -Xlinker -Map="flash.map" -Xlinker -print-memory-usage -T $(LINKER_SCRIPT) -o "$(OUTPUT_NAME).axf"

C_FLAGS+= -L../../../MCUXpressoIDE_10.0.2_411/nxp/ide/tools/lib/gcc/arm-none-eabi/5.4.1/armv6-m
C_FLAGS+= -L../../../MCUXpressoIDE_10.0.2_411/nxp/ide/tools/arm-none-eabi/lib/armv6-m

##### Useful Directories #####
DIR_PROJECT:=.
DIR_ARM_PACK:=../../ARM/PACK
DIR_BUILD=$(DIR_PROJECT)/__build

##### Project #####

# Assembly
ASS_FILES=$(shell find -path "$(DIR_PROJECT)/*" -type f -name "*.s")

# Source
SRC_FILES=$(shell find -path "$(DIR_PROJECT)/*" -type f -name "*.c")

# Include
INCL_DIRS=$(DIR_PROJECT)/include

##### FreeRTOS #####
DIR_RTOS=$(DIR_ARM_PACK)/ARM/CMSIS-FreeRTOS/9.1.0
DIR_RTOS_SRC=$(DIR_RTOS)/Source

# Include
INCL_DIRS+=$(DIR_RTOS)/Source/include
INCL_DIRS+=$(DIR_RTOS)/Source/portable/GCC/ARM_CM0
INCL_DIRS+=$(DIR_RTOS)/CMSIS/RTOS2/FreeRTOS/Include
INCL_DIRS+=$(DIR_ARM_PACK)/Keil.Kinetis_KWxx_DFP/1.7.0/Device/Include
INCL_DIRS+=$(DIR_ARM_PACK)/Keil/Kinetis_KWxx_DFP/1.7.0/Device/Source
INCL_DIRS+=$(DIR_ARM_PACK)/Keil/Kinetis_KWxx_DFP/1.7.0/Device/Source/ARM

# Source
SRC_FILES+=$(DIR_RTOS_SRC)/timers.c
SRC_FILES+=$(DIR_RTOS_SRC)/tasks.c
SRC_FILES+=$(DIR_RTOS_SRC)/queue.c
SRC_FILES+=$(DIR_RTOS_SRC)/portable/GCC/ARM_CM0/port.c
SRC_FILES+=$(DIR_RTOS_SRC)/portable/MemMang/heap_4.c
SRC_FILES+=$(DIR_RTOS_SRC)/list.c
SRC_FILES+=$(DIR_RTOS_SRC)/event_groups.c
SRC_FILES+=$(DIR_ARM_PACK)/ARM/CMSIS-FreeRTOS/9.1.0/CMSIS/RTOS2/FreeRTOS/Source/freertos_evr.c
SRC_FILES+=$(DIR_RTOS_SRC)/croutine.c

##### Board #####

# Assembly
#ASS_FILES+=$(DIR_ARM_PACK)/Keil/Kinetis_KWxx_DFP/1.7.0/Device/Source/ARM/startup_MKW41Z4.s

#Include
INCL_DIRS+=$(DIR_ARM_PACK)/Keil/MDK-Middleware/7.4.1/Board
INCL_DIRS+=$(DIR_ARM_PACK)/Keil/Kinetis_KWxx_DFP/1.7.0/Device/Include
INCL_DIRS+=$(DIR_ARM_PACK)/ARM/CMSIS/5.1.1/CMSIS/Include

#Source
SRC_FILES+=$(DIR_ARM_PACK)/Keil/Kinetis_KWxx_DFP/1.7.0/Device/Source/system_MKW41Z4.c
SRC_FILES+=$(DIR_ARM_PACK)/Keil/Kinetis_KWxx_DFP/1.7.0/Boards/NXP/FRDM-KW41Z/Common/LED_FRDM-KW41Z.c

SRC_FILES+=../Flasher_Xpresso/startup/startup_mkw41z4.c

##### Finalising #####
SRC_PATHS:=$(sort $(SRC_FILES))
INCL_PATHS:=$(addprefix -I, $(sort $(INCL_DIRS)))

##### Compilation #####
compile:
	$(CC) $(INCL_PATHS) $(C_FLAGS) $(SRC_PATHS)
	arm-none-eabi-size "$(OUTPUT_NAME).axf"

#arm-none-eabi-objcopy -v -O binary "$(OUTPUT_NAME).axf" "flash.bin"
	
print-%:
	@echo '$*=$($*)'
