
CC=gcc

# Target Architecture
ARCH=armv6-m
MCU=cortex-m0plus
F_CPU=12000000

# Tool Options
COMP_FLAGS=-march=$(ARCH) -mtune=$(MCU)

# Searches current dirs for written files
C_FILES := $(shell find -path "*" -type f -name "*.c")
INCL_FILES := $(shell find -path "*" -type f -name "*.h")

# Generic Paths
ARM_PACK_DIR=../../ARM/PACK

# RTE Components
RTE_ABS_DIR=../Flasher_Keil/RTE
DEVICE_DIR=/Device/MKW41Z512xxx4
RTOS_DIR=/RTOS
BOARD_DIR=/_NXPKW41Z

C_FILES += $(shell find $(RTE_ABS_DIR)$(DEVICE_DIR) -type f -name "*.c")
C_FILES += $(shell find $(RTE_ABS_DIR)$(RTOS_DIR) -type f -name "*.c")
C_FILES += $(shell find $(RTE_ABS_DIR)$(BOARD_DIR) -type f -name "*.c")
INCL_FILES += $(shell find $(RTE_ABS_DIR)$(DEVICE_DIR) -type f -name "*.h")
INCL_FILES += $(shell find $(RTE_ABS_DIR)$(RTOS_DIR) -type f -name "*.h")
INCL_FILES += $(shell find $(RTE_ABS_DIR)$(BOARD_DIR) -type f -name "*.h")

# RTOS Files
RTOS_DIR=$(ARM_PACK_DIR)/ARM/CMSIS-FreeRTOS/9.1.0/CMSIS/RTOS2/FreeRTOS/Include
RTOS_SRC_DIR=$(ARM_PACK_DIR)/ARM/CMSIS-FreeRTOS/9.1.0/Source/include
RTOS_PORT_DIR=$(ARM_PACK_DIR)/ARM/CMSIS-FreeRTOS/9.1.0/Source/portable/RVDS/ARM_CM0

C_FILES += $(shell find $(RTOS_DIR) -type f -name "*.c")
C_FILES += $(shell find $(RTOS_SRC_DIR) -type f -name "*.c")
C_FILES += $(shell find $(RTOS_PORT_DIR) -type f -name "*.c")
INCL_FILES += $(shell find $(RTOS_DIR) -type f -name "*.h")
INCL_FILES += $(shell find $(RTOS_SRC_DIR) -type f -name "*.h")
INCL_FILES += $(shell find $(RTOS_PORT_DIR) -type f -name "*.h")

# CMSIS Files
CMSIS_DIR=$(ARM_PACK_DIR)/ARM/CMSIS/5.1.1/CMSIS/Include
C_FILES += $(shell find $(CMSIS_DIR) -type f -name "*.c")
INCL_FILES += $(shell find $(CMSIS_DIR) -type f -name "*.h")

# Board Files
BOARD_DIR=$(ARM_PACK_DIR)/Keil/Kinetis_KWxx_DFP/1.7.0/Device/Include
C_FILES += $(shell find $(BOARD_DIR) -type f -name "*.c")
C_FILES += $(shell find $(BOARD_DIR) -type f -name "*.h")

# Middleware Files
MID_FILES=$(ARM_PACK_DIR)/Keil/MDK-Middleware/7.4.1/Board
C_FILES += $(shell find $(MID_FILES) -type f -name "*.c")
C_FILES += $(shell find $(MID_FILES) -type f -name "*.h")

# Finalising the paths
C_PATHS := $(sort $(C_FILES))
INCL_PATHS := $(sort $(INCL_FILES))
COMP_FLAGS+= $(addprefix -I ,$(INCL_FILES))

print-%  : ; @echo $* = $($*)