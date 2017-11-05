
CC=arm-linux-gnueabi-gcc

# Target Architecture
ARCH=armv6-m
MCU=cortex-m0plus
F_CPU=12000000

# Tool Options
COMP_FLAGS=-march=$(ARCH) -mthumb
#-mtune=$(MCU)

# Searches current dirs for written files
ASS_FILES := $(shell find -path "*" -type f -name "*.s")
C_FILES := $(shell find -path "*" -type f -name "*.c")
INCL_FILES := $(shell find -path "*" -type f -name "*.h")

# Generic Paths
ARM_PACK_DIR=../../ARM/PACK

# RTE Components
RTE_ABS_DIR=../Flasher_Keil/RTE
DEVICE_DIR=/Device/MKW41Z512xxx4
RTOS_DIR=/RTOS
BOARD_DIR=/_NXPKW41Z

ASS_FILES += $(shell find $(RTE_ABS_DIR)$(DEVICE_DIR) -type f -name "*.s")
C_FILES += $(shell find $(RTE_ABS_DIR)$(DEVICE_DIR) -type f -name "*.c")
INCL_FILES += $(shell find $(RTE_ABS_DIR)$(DEVICE_DIR) -type d)

INCL_FILES += $(shell find $(RTE_ABS_DIR)$(RTOS_DIR) -type d)
INCL_FILES += $(shell find $(RTE_ABS_DIR)$(BOARD_DIR) -type d)

# RTOS Files
RTOS_DIR=$(ARM_PACK_DIR)/ARM/CMSIS-FreeRTOS/9.1.0/CMSIS/RTOS2/FreeRTOS/Include
RTOS_SRC_INCL_DIR=$(ARM_PACK_DIR)/ARM/CMSIS-FreeRTOS/9.1.0/Source/include
RTOS_PORT_DIR=$(ARM_PACK_DIR)/ARM/CMSIS-FreeRTOS/9.1.0/Source/portable/RVDS/ARM_CM0

INCL_FILES += $(shell find $(RTOS_DIR) -type d)
INCL_FILES += $(shell find $(RTOS_SRC_INCL_DIR) -type d)
INCL_FILES += $(shell find $(RTOS_PORT_DIR) -type d)

RTOS_SRC_DIR=$(ARM_PACK_DIR)/ARM/CMSIS-FreeRTOS/9.1.0/Source

C_FILES+=$(RTOS_SRC_DIR)/portable/MemMang/heap_4.c
C_FILES+=$(RTOS_SRC_DIR)/croutine.c
C_FILES+=$(RTOS_SRC_DIR)/event_groups.c
C_FILES+=$(RTOS_SRC_DIR)/list.c
C_FILES+=$(RTOS_SRC_DIR)/queue.c
C_FILES+=$(RTOS_SRC_DIR)/tasks.c
C_FILES+=$(RTOS_SRC_DIR)/timers.c

# CMSIS Files
CMSIS_DIR=$(ARM_PACK_DIR)/ARM/CMSIS/5.1.1/CMSIS/Include

INCL_FILES += $(CMSIS_DIR)

# Board Files
INCL_FILES+=$(ARM_PACK_DIR)/Keil/Kinetis_KWxx_DFP/1.7.0/Device/Include

# Middleware Files
MID_FILES=$(ARM_PACK_DIR)/Keil/MDK-Middleware/7.4.1/Board

INCL_FILES += $(shell find $(MID_FILES) -type d)

# LED Files
C_FILES+=$(ARM_PACK_DIR)/Keil/Kinetis_KWxx_DFP/1.7.0/Boards/NXP/FRDM-KW41Z/Common/LED_FRDM-KW41Z.c

# Finalising the paths
C_PATHS := $(sort $(C_FILES))
INCL_PATHS := $(addprefix -I ,$(sort $(INCL_FILES)))

compile:
	$(CC) $(COMP_FLAGS) $(C_PATHS) $(INCL_PATHS)

print-%  : ; @echo $* = $($*)