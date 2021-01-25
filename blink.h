#pragma once

#include "libopencm3/stm32/rcc.h"
#include "libopencm3/stm32/gpio.h"

#define LED_PORT      (GPIOA)
#define LED_PIN       (GPIO5)
#define LED_PORT_RCC  (RCC_GPIOA)
#define BLINK_DELAY   (200)
