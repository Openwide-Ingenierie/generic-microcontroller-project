#pragma once

#include "libopencm3/stm32/rcc.h"
#include "libopencm3/stm32/gpio.h"

#define LED_PORT      (GPIOC)
#define LED_PIN       (GPIO13)
#define LED_PORT_RCC  (RCC_GPIOC)
#define BLINK_DELAY   (200)
