OS_WD::=$(dir $(lastword $(MAKEFILE_LIST)))
OS_DIR=$(OS_WD)$(OS)

OS_BUILD_DIR?=$(BUILD_DIR)

ifeq ($(OS),)
$(error Undefined OS)
else
include $(OS_WD)rules/$(shell echo $(OS) | tr '[:upper:]' '[:lower:]').mk
endif
