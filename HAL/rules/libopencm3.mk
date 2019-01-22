HAL_LIB_PATH=$(HAL_DIR)/lib
HAL_LIB_NAME=opencm3_$(MCU_TYPE)$(MCU_FAMILLY)
HAL_INCLUDE_PATH=$(HAL_DIR)/include
HAL_DEFINES=$(shell echo $(MCU_TYPE)$(MCU_FAMILLY) | tr '[:lower:]' '[:upper:]')

LIBOPENCM3_AR=$(HAL_LIB_PATH)/lib$(HAL_LIB_NAME).a

hal: $(LIBOPENCM3_AR)

$(LIBOPENCM3_AR):
	@$(MAKE) -C $(HAL_DIR) V=0 TARGETS=$(MCU_TYPE)/$(MCU_FAMILLY)

clean_hal:
	@$(MAKE) -C $(HAL_DIR) V=0 clean

.PHONY: clean_hal
