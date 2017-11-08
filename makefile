##### Target #####
TARGET_ARCH=armv6-m
TARGET_FREQ=12000000

##### Toolchain #####
CC=arm-linux-gnueabi-gcc
LINKER_SCRIPT:=linker_script.ld
C_FLAGS=-march=$(TARGET_ARCH) -mthumb

##### Useful Directories #####
DIR_PROJECT:=.
DIR_ARM_PACK:=../../ARM/PACK

##### Project #####

# Assembly
ASS_FILES=$(shell find -path "$(DIR_PROJECT)/*" -type f -name "*.s")

# Source
SRC_FILES=$(shell find -path "$(DIR_PROJECT)/*" -type f -name "*.c")

# Include
INCL_DIRS=$(DIR_PROJECT)/include

##### FreeRTOS #####
DIR_RTOS=$(DIR_ARM_PACK)/ARM/CMSIS-FreeRTOS/9.1.0

# Source
SRC_FILES+=$(DIR_RTOS)/Source/portable/MemMang/heap_4.c
SRC_FILES+=$(DIR_RTOS)/Source/croutine.c
SRC_FILES+=$(DIR_RTOS)/Source/event_groups.c
SRC_FILES+=$(DIR_RTOS)/Source/list.c
SRC_FILES+=$(DIR_RTOS)/Source/queue.c
SRC_FILES+=$(DIR_RTOS)/Source/tasks.c
SRC_FILES+=$(DIR_RTOS)/Source/timers.c
SRC_FILES+=$(DIR_RTOS)/Source/portable/GCC/ARM_CM0/port.c

# Include
INCL_DIRS+=$(DIR_RTOS)/CMSIS/RTOS2/FreeRTOS/Include
INCL_DIRS+=$(DIR_RTOS)/Source/include
INCL_DIRS+=$(DIR_RTOS)/Source/portable/GCC/ARM_CM0

##### DEVICE_SPECIFIC #####
DIR_RTE=../Flasher_Keil/RTE

# Assembly
ASS_FILES+=$(shell find -path "$(DIR_RTE)/Device/MKW41Z512xxx4" -type f -name "*.c")

# Source
SRC_FILES+=$(shell find "$(DIR_RTE)/Device/MKW41Z512xxx4" -type f -name "*.c")

# Include
INCL_DIRS+=$(DIR_RTE)/Device/MKW41Z512xxx4
INCL_DIRS+=$(DIR_RTE)/RTOS
INCL_DIRS+=$(DIR_RTE)/_NXPKW41Z

##### CMSIS #####

# Include
INCL_DIRS+=$(DIR_ARM_PACK)/ARM/CMSIS/5.1.1/CMSIS/Include

##### Keil #####

# Source
SRC_FILES+=$(DIR_ARM_PACK)/Keil/Kinetis_KWxx_DFP/1.7.0/Boards/NXP/FRDM-KW41Z/Common/LED_FRDM-KW41Z.c

# Include
INCL_DIRS+=$(DIR_ARM_PACK)/Keil/Kinetic_KWxx_DFP/7.4.1/Board
INCL_DIRS+=$(DIR_ARM_PACK)/Keil/MDK-Middleware/7.4.1/Board
INCL_DIRS+=$(DIR_ARM_PACK)/Keil/Kinetis_KWxx_DFP/1.7.0/Device/Include

##### Finalising #####
SRC_PATHS:=$(sort $(SRC_FILES))
INCL_PATHS:=$(addprefix -I, $(sort $(INCL_DIRS)))

##### Compilation #####
compile:
	$(CC) $(INCL_PATHS) $(C_FLAGS) $(SRC_PATHS)


