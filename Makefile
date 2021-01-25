include config/config.mk
include HAL/hal.mk
include OS/os.mk

# compiler
CC=$(CROSS_COMPILE)gcc

# linker
LD=$(CC)

# archiver
AR=$(CROSS_COMPILE)gcc-ar
ARFLAGS=rcs

# debugger
GDB=gdb-multiarch
GDB_FLAGS=--tui

# flash utility
FLASH_TOOL=openocd
FLASH_TOOL_FLAGS=-f $(OPENOCD_CFG_FILE) -c "setup $(INTERFACE) $(TRANSPORT) $(TARGET)"

# Libraries
LIB_PATH=$(HAL_LIB_PATH) $(OS_LIB_PATH)
LIB_NAMES=$(HAL_LIB_NAME) $(OS_LIB_NAME)
INCLUDES=$(HAL_INCLUDE_PATH) $(OS_INCLUDE_PATH)
LIB_DEFINES=$(HAL_DEFINES) $(OS_DEFINES)

# compile flags
CFLAGS+=$(CC_OPT) $(ARCH_FLAGS)
INC_FLAGS=$(patsubst %,-I%, . $(INCLUDES))
DEF_FLAGS=$(patsubst %,-D%, $(CC_DEFINES) $(LIB_DEFINES))

# link flags
LDFLAGS+=$(ARCH_FLAGS) $(LD_OPT)
LDFLAGS+=$(patsubst %,-T%, $(LINK_FILE))
LDFLAGS+=$(patsubst %,-L%, $(LIB_PATH))
LDFLAGS+=$(patsubst %,-l%, $(LIB_NAMES))


SRC= $(wildcard *.c)
HDR= $(wildcard *.h)
OBJ= $(SRC:.c=.o)

DEBUG_OBJ=$(addprefix $(DEBUG_DIR)/, $(OBJ))
RELEASE_OBJ=$(addprefix $(RELEASE_DIR)/, $(OBJ))


all: release
.DEFAULT_GOAL := all
.PHONY: all flash gdb mrproper clean clean_release clean_debug clean_dep


# not so useful targets to call from command line

$(RELEASE_DIR)/$(FIRMWARE): dep $(RELEASE_OBJ)
	@$(LD) -o $@ $(RELEASE_OBJ) $(LDFLAGS)

$(DEBUG_DIR)/$(FIRMWARE): dep $(DEBUG_OBJ)
	@$(LD) -o $@ $(DEBUG_OBJ) $(LDFLAGS)

$(RELEASE_DIR)/%.o: %.c $(HDR)
	@mkdir -p $(@D)
	@$(CC) -o $@ -c $< $(CFLAGS) $(INC_FLAGS) $(DEF_FLAGS)

$(DEBUG_DIR)/%.o: %.c $(HDR)
	@mkdir -p $(@D)
	@$(CC) -o $@ -c $< $(CFLAGS) $(CFLAGS_DEBUG) $(INC_FLAGS) $(DEF_FLAGS)

dep: hal os

clean_dep: clean_hal clean_os

clean_release:
	@if [ -d $(RELEASE_DIR) ]; then find $(RELEASE_DIR) -type f -name "*.o" -delete; fi

clean_debug:
	@if [ -d $(DEBUG_DIR) ]; then find $(DEBUG_DIR) -type f -name "*.o" -delete; fi



# useful targets to call from command line

release: $(RELEASE_DIR)/$(FIRMWARE)

debug: $(DEBUG_DIR)/$(FIRMWARE)

flash: release
	@$(FLASH_TOOL) $(FLASH_TOOL_FLAGS) -c "program_release $(RELEASE_DIR)/$(FIRMWARE)"

gdb: debug
	@$(FLASH_TOOL) $(FLASH_TOOL_FLAGS) &
	#2 sec pause to give openocd time to start
	@sleep 2
	@$(GDB) $(GDB_FLAGS) --eval-command 'target remote :3333' --eval-command 'monitor reset halt' --eval-command 'load' $(DEBUG_DIR)/$(FIRMWARE)
	#kill (with ctrl+C) openocd
	@kill -9 `ps aux | grep openocd | awk '{print $$2}' | head -1`

clean: clean_release clean_debug

mrproper: clean_dep
	@rm -rf $(BUILD_DIR)
