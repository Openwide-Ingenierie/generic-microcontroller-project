# MCU definitions
MCU_TYPE=stm32
MCU_FAMILLY=f4
MCU_CORE=cortex-m4
MCU_PRECISION=46re

# Flash/debug tool configuration
INTERFACE=stlink-v2-1
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
FREERTOS_MCU_PORT=GCC/ARM_CM4F
# config file
FREERTOS_CONFIG=config/FreeRTOSConfig.h

# linker script name
LINK_FILE=$(LDSCRIPT)

# openocd config file
OPENOCD_CFG_FILE=config/openocd.cfg

# cross compile prefix
CROSS_COMPILE=arm-none-eabi-

# compilation flags
CC_OPT=-Os
CFLAGS=-W -Wall -Wextra
CFLAGS_DEBUG=-g -gdwarf-4
CC_DEFINES=

# link flags
LD_OPT=-flto
LDFLAGS=-Wl,--print-memory-usage,--gc-sections \
  -nostartfiles -lc -lgcc -lnosys -Xlinker -Map=output.map

# arch specific flags
ARCH_FLAGS=-mcpu=$(MCU_CORE) -mthumb -mfloat-abi=hard -specs=nano.specs
