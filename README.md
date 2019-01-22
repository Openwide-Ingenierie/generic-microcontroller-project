# Generic microcontroller project
This repository targets Cortex-M and other type of microcontrollers projects either bare metal or OS based. It provide intuitive make targets to help quickly getting into developement stage.
By default the hardware abstraction library (HAL) is libopencm3 and the provided OS, if needed, is FreeRTOS. However this projet aim to allow easy OS or HAL changement.

## Quick start:
To start a new project edit the config/config.mk file.

In particular you have to :
 - Edit the MCU_TYPE, MCU_FAMILLY, MCU_CORE and ARCH_FLAGS variables to be consistant with your microcontroller
 - Edit the INTERFACE, TRANSPORT and TARGET variables to reflect the debug probe and protocol you are using
 - Edit the OS and HAL variables to select OS and HAL you want to use (see: Using an alternative OS or HAL)
 - Edit the LINK_FILE variable to give the .ld file you want to use (or edit config/link.ld file)

If you need to use libopencm3 and/or FreeRTOS you will have to init and uddate the submodules:
```sh
$> git submodules init
$> git submodules update
```

### Main make targets:
 - release: compilation in release mode
 - debug: compilation in debug mode
 - flash: program the binary (release) on the microcontroller target
 - gdb: program the binary (debug) on the target and launch a gdb instance

### Folder tree:
 - config/: all configuration related files
 - HAL/: contain the HAL used for the project
 - OS/: contain the OS used for the project
 - blink.* : Blue Pill led blink demo. Uses libopencm3 and a FreeRTOS task.

## Using an alternative HAL or OS:
 In order to use an alternative HAL you need to:
 - put the alternative HAL in HAL/<name of the HAL>
 - write a HAL/rules/<name of the HAL>.mk file using the HAL/rules/template.mk template
 - set the variable HAL in config/config.mk to <name of the HAL>
 - compile

The steps are the same if you want to add an alternative OS (exept the directory is OS/).
