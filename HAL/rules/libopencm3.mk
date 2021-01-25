HAL_LIB_PATH=$(HAL_DIR)/lib
HAL_LIB_NAME=opencm3_$(MCU_TYPE)$(MCU_FAMILLY)
HAL_INCLUDE_PATH=$(HAL_DIR)/include
HAL_DEFINES=$(shell echo $(MCU_TYPE)$(MCU_FAMILLY) | tr '[:lower:]' '[:upper:]')

OPENCM3_DIR=$(HAL_DIR)
Q=@

DEVICE=$(MCU_TYPE)$(MCU_FAMILLY)$(MCU_PRECISION)

LIBOPENCM3_AR=$(HAL_LIB_PATH)/lib$(HAL_LIB_NAME).a

include $(OPENCM3_DIR)/mk/genlink-config.mk
include $(OPENCM3_DIR)/mk/genlink-rules.mk

hal: $(LIBOPENCM3_AR) $(LDSCRIPT)

$(LIBOPENCM3_AR):
	@$(MAKE) -C $(HAL_DIR) V=0 TARGETS=$(MCU_TYPE)/$(MCU_FAMILLY)

clean_hal:
	@$(MAKE) -C $(HAL_DIR) V=0 clean

.PHONY: clean_hal
