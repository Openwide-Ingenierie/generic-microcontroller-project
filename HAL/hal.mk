HAL_WD::=$(dir $(lastword $(MAKEFILE_LIST)))
HAL_DIR=$(HAL_WD)$(HAL)

HAL_BUILD_DIR?=$(BUILD_DIR)

ifeq ($(HAL),)
$(error Undefined HAL)
else
include $(HAL_WD)rules/$(shell echo $(HAL) | tr '[:upper:]' '[:lower:]').mk
endif
