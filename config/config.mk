# MCU definitions
MCU_TYPE=stm32
MCU_FAMILLY=f1
MCU_CORE=cortex-m3

# Flash/debug tool configuration
INTERFACE=stlink-v2
TRANSPORT=hla_swd
TARGET=$(MCU_TYPE)$(MCU_FAMILLY)x

# firmware name
FIRMWARE=firmware.elf

# build dir name
BUILD_DIR=build
RELEASE_DIR=$(BUILD_DIR)/release
DEBUG_DIR=$(BUILD_DIR)/debug

#  HAL (libopencm3)
HAL=libopencm3

# OS ("FreeRTOS" or "baremetal")
OS=FreeRTOS

# FreeRTOS config
# heap implementation
FREERTOS_HEAP_IMPLEM=4
# MCU port
FREERTOS_MCU_PORT=GCC/ARM_CM3
# config file
FREERTOS_CONFIG=config/FreeRTOSConfig.h

# linker script name
LINK_FILE=config/link.ld
#$(HAL_LIB_PATH)/$(MCU_TYPE)/$(MCU_FAMILLY)/stm32f103x8.ld

# openocd config file
OPENOCD_CFG_FILE=config/openocd.cfg

# cross compile prefix
CROSS_COMPILE=arm-none-eabi-

# compilation flags
CC_OPT=-Os
CFLAGS=-W -Wall
CFLAGS_DEBUG=-g -gdwarf-4
CC_DEFINES=

# link flags
LD_OPT=-flto
LDFLAGS=-Wl,--gc-sections -nostartfiles -lnosys

# arch specific flags
ARCH_FLAGS=-mcpu=$(MCU_CORE) -mthumb -msoft-float
