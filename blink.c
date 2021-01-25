#include "libopencm3/stm32/rcc.h"
#include "libopencm3/stm32/gpio.h"
#include "libopencm3/cm3/systick.h"

#include "FreeRTOS.h"
#include "task.h"

#include "blink.h"


// needed by FreeRTOS
uint32_t SystemCoreClock;


static void led_blink_task(void * pvParameters) {
    // avoid warning about unused parameters
	(void)pvParameters;

	while(1) {
		gpio_toggle(LED_PORT, LED_PIN);
		vTaskDelay(pdMS_TO_TICKS(BLINK_DELAY));
	}
}

int main(void) {
    // give the used system clock frequency to FreeRTOS
    SystemCoreClock = rcc_ahb_frequency;

    // systick configuration
	systick_set_frequency(configTICK_RATE_HZ, SystemCoreClock);

    // led port peripheral clock enabling
    rcc_periph_clock_enable(LED_PORT_RCC);
    // led pin configuration (output mode, low speed, push/pull output)
	gpio_mode_setup(LED_PORT, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, LED_PIN);


    // blinky task creation
    TaskHandle_t led_bink_task_handle = NULL;
    BaseType_t ret_status;
	ret_status = xTaskCreate( led_blink_task,
                            ( const char * ) "led_blink",
                            configMINIMAL_STACK_SIZE + 200,
                            NULL,
                            tskIDLE_PRIORITY + 1,
                            &led_bink_task_handle );

	// start scheduler
	if(ret_status == pdPASS) {
	   vTaskStartScheduler();
	}

    // should never fall here
    while(1) {};

	return 0;
}
