/* This file comes with libopencm3 */
INCLUDE HAL/libopencm3/lib/stm32/f1/stm32f103x8.ld

/* Definitions used by FreeRTOS for MPU capable microcontrollers. */
/*_Privileged_Functions_Region_Size = 32K;
_Privileged_Data_Region_Size = 512;

__FLASH_segment_start__ = ORIGIN( rom );
__FLASH_segment_end__ = __FLASH_segment_start__ + LENGTH( rom );

__privileged_functions_start__ = ORIGIN( rom );
__privileged_functions_end__ = __privileged_functions_start__ + _Privileged_Functions_Region_Size;

__SRAM_segment_start__ = ORIGIN( ram );
__SRAM_segment_end__ = __SRAM_segment_start__ + LENGTH( ram );

__privileged_data_start__ = ORIGIN( ram );
__privileged_data_end__ = ORIGIN( ram ) + _Privileged_Data_Region_Size;*/
