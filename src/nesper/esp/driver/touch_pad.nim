##  Copyright 2015-2016 Espressif Systems (Shanghai) PTE LTD
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.

import ../../consts

type
  touch_pad_t* {.size: sizeof(cint).} = enum
    TOUCH_PAD_NUM0 = 0,         ## !< Touch pad channel 0 is GPIO4
    TOUCH_PAD_NUM1,           ## !< Touch pad channel 1 is GPIO0
    TOUCH_PAD_NUM2,           ## !< Touch pad channel 2 is GPIO2
    TOUCH_PAD_NUM3,           ## !< Touch pad channel 3 is GPIO15
    TOUCH_PAD_NUM4,           ## !< Touch pad channel 4 is GPIO13
    TOUCH_PAD_NUM5,           ## !< Touch pad channel 5 is GPIO12
    TOUCH_PAD_NUM6,           ## !< Touch pad channel 6 is GPIO14
    TOUCH_PAD_NUM7,           ## !< Touch pad channel 7 is GPIO27
    TOUCH_PAD_NUM8,           ## !< Touch pad channel 8 is GPIO33
    TOUCH_PAD_NUM9,           ## !< Touch pad channel 9 is GPIO32
    TOUCH_PAD_MAX
  touch_high_volt_t* {.size: sizeof(cint).} = enum
    TOUCH_HVOLT_KEEP = -1,      ## !<Touch sensor high reference voltage, no change
    TOUCH_HVOLT_2V4 = 0,        ## !<Touch sensor high reference voltage, 2.4V
    TOUCH_HVOLT_2V5,          ## !<Touch sensor high reference voltage, 2.5V
    TOUCH_HVOLT_2V6,          ## !<Touch sensor high reference voltage, 2.6V
    TOUCH_HVOLT_2V7,          ## !<Touch sensor high reference voltage, 2.7V
    TOUCH_HVOLT_MAX
  touch_low_volt_t* {.size: sizeof(cint).} = enum
    TOUCH_LVOLT_KEEP = -1,      ## !<Touch sensor low reference voltage, no change
    TOUCH_LVOLT_0V5 = 0,        ## !<Touch sensor low reference voltage, 0.5V
    TOUCH_LVOLT_0V6,          ## !<Touch sensor low reference voltage, 0.6V
    TOUCH_LVOLT_0V7,          ## !<Touch sensor low reference voltage, 0.7V
    TOUCH_LVOLT_0V8,          ## !<Touch sensor low reference voltage, 0.8V
    TOUCH_LVOLT_MAX
  touch_volt_atten_t* {.size: sizeof(cint).} = enum
    TOUCH_HVOLT_ATTEN_KEEP = -1, ## !<Touch sensor high reference voltage attenuation, no change
    TOUCH_HVOLT_ATTEN_1V5 = 0,  ## !<Touch sensor high reference voltage attenuation, 1.5V attenuation
    TOUCH_HVOLT_ATTEN_1V,     ## !<Touch sensor high reference voltage attenuation, 1.0V attenuation
    TOUCH_HVOLT_ATTEN_0V5,    ## !<Touch sensor high reference voltage attenuation, 0.5V attenuation
    TOUCH_HVOLT_ATTEN_0V,     ## !<Touch sensor high reference voltage attenuation,   0V attenuation
    TOUCH_HVOLT_ATTEN_MAX
  touch_cnt_slope_t* {.size: sizeof(cint).} = enum
    TOUCH_PAD_SLOPE_0 = 0,      ## !<Touch sensor charge / discharge speed, always zero
    TOUCH_PAD_SLOPE_1 = 1,      ## !<Touch sensor charge / discharge speed, slowest
    TOUCH_PAD_SLOPE_2 = 2,      ## !<Touch sensor charge / discharge speed
    TOUCH_PAD_SLOPE_3 = 3,      ## !<Touch sensor charge / discharge speed
    TOUCH_PAD_SLOPE_4 = 4,      ## !<Touch sensor charge / discharge speed
    TOUCH_PAD_SLOPE_5 = 5,      ## !<Touch sensor charge / discharge speed
    TOUCH_PAD_SLOPE_6 = 6,      ## !<Touch sensor charge / discharge speed
    TOUCH_PAD_SLOPE_7 = 7,      ## !<Touch sensor charge / discharge speed, fast
    TOUCH_PAD_SLOPE_MAX
  touch_trigger_mode_t* {.size: sizeof(cint).} = enum
    TOUCH_TRIGGER_BELOW = 0,    ## !<Touch interrupt will happen if counter value is less than threshold.
    TOUCH_TRIGGER_ABOVE = 1,    ## !<Touch interrupt will happen if counter value is larger than threshold.
    TOUCH_TRIGGER_MAX
  touch_trigger_src_t* {.size: sizeof(cint).} = enum
    TOUCH_TRIGGER_SOURCE_BOTH = 0, ## !< wakeup interrupt is generated if both SET1 and SET2 are "touched"
    TOUCH_TRIGGER_SOURCE_SET1 = 1, ## !< wakeup interrupt is generated if SET1 is "touched"
    TOUCH_TRIGGER_SOURCE_MAX
  touch_tie_opt_t* {.size: sizeof(cint).} = enum
    TOUCH_PAD_TIE_OPT_LOW = 0,  ## !<Initial level of charging voltage, low level
    TOUCH_PAD_TIE_OPT_HIGH = 1, ## !<Initial level of charging voltage, high level
    TOUCH_PAD_TIE_OPT_MAX
  touch_fsm_mode_t* {.size: sizeof(cint).} = enum
    TOUCH_FSM_MODE_TIMER = 0,   ## !<To start touch FSM by timer
    TOUCH_FSM_MODE_SW,        ## !<To start touch FSM by software trigger
    TOUCH_FSM_MODE_MAX
  touch_isr_handle_t* = intr_handle_t










const
  TOUCH_PAD_SLEEP_CYCLE_DEFAULT* = (0x00001000) ## !<The timer frequency is RTC_SLOW_CLK (can be 150k or 32k depending on the options), max value is 0xffff
  TOUCH_PAD_MEASURE_CYCLE_DEFAULT* = (0x00007FFF) ## !<The timer frequency is 8Mhz, the max value is 0x7fff
  TOUCH_PAD_MEASURE_WAIT_DEFAULT* = (0x000000FF) ## !<The timer frequency is 8Mhz, the max value is 0xff
  TOUCH_FSM_MODE_DEFAULT* = (TOUCH_FSM_MODE_SW) ## !<The touch FSM my be started by the software or timer
  TOUCH_TRIGGER_MODE_DEFAULT* = (TOUCH_TRIGGER_BELOW) ## !<Interrupts can be triggered if sensor value gets below or above threshold
  TOUCH_TRIGGER_SOURCE_DEFAULT* = (TOUCH_TRIGGER_SOURCE_SET1) ## !<The wakeup trigger source can be SET1 or both SET1 and SET2
  TOUCH_PAD_BIT_MASK_MAX* = (0x000003FF)

## *
##  @brief Initialize touch module.
##  @note  The default FSM mode is 'TOUCH_FSM_MODE_SW'. If you want to use interrupt trigger mode,
##         then set it using function 'touch_pad_set_fsm_mode' to 'TOUCH_FSM_MODE_TIMER' after calling 'touch_pad_init'.
##  @return
##      - ESP_OK Success
##      - ESP_FAIL Touch pad init error
##

proc touch_pad_init*(): esp_err_t {.importc: "touch_pad_init", header: "touch_pad.h".}
## *
##  @brief Un-install touch pad driver.
##  @note  After this function is called, other touch functions are prohibited from being called.
##  @return
##      - ESP_OK   Success
##      - ESP_FAIL Touch pad driver not initialized
##

proc touch_pad_deinit*(): esp_err_t {.importc: "touch_pad_deinit",
                                   header: "touch_pad.h".}
## *
##  @brief Configure touch pad interrupt threshold.
##
##  @note  If FSM mode is set to TOUCH_FSM_MODE_TIMER, this function will be blocked for one measurement cycle and wait for data to be valid.
##
##  @param touch_num touch pad index
##  @param threshold interrupt threshold,
##
##  @return
##      - ESP_OK Success
##      - ESP_ERR_INVALID_ARG if argument wrong
##      - ESP_FAIL if touch pad not initialized
##

proc touch_pad_config*(touch_num: touch_pad_t; threshold: uint16): esp_err_t {.
    importc: "touch_pad_config", header: "touch_pad.h".}
## *
##  @brief get touch sensor counter value.
##         Each touch sensor has a counter to count the number of charge/discharge cycles.
##         When the pad is not 'touched', we can get a number of the counter.
##         When the pad is 'touched', the value in counter will get smaller because of the larger equivalent capacitance.
##
##  @note This API requests hardware measurement once. If IIR filter mode is enabled,
##        please use 'touch_pad_read_raw_data' interface instead.
##
##  @param touch_num touch pad index
##  @param touch_value pointer to accept touch sensor value
##
##  @return
##      - ESP_OK Success
##      - ESP_ERR_INVALID_ARG Touch pad parameter error
##      - ESP_ERR_INVALID_STATE This touch pad hardware connection is error, the value of "touch_value" is 0.
##      - ESP_FAIL Touch pad not initialized
##

proc touch_pad_read*(touch_num: touch_pad_t; touch_value: ptr uint16): esp_err_t {.
    importc: "touch_pad_read", header: "touch_pad.h".}
## *
##  @brief get filtered touch sensor counter value by IIR filter.
##
##  @note touch_pad_filter_start has to be called before calling touch_pad_read_filtered.
##        This function can be called from ISR
##
##  @param touch_num touch pad index
##  @param touch_value pointer to accept touch sensor value
##
##  @return
##      - ESP_OK Success
##      - ESP_ERR_INVALID_ARG Touch pad parameter error
##      - ESP_ERR_INVALID_STATE This touch pad hardware connection is error, the value of "touch_value" is 0.
##      - ESP_FAIL Touch pad not initialized
##

proc touch_pad_read_filtered*(touch_num: touch_pad_t; touch_value: ptr uint16): esp_err_t {.
    importc: "touch_pad_read_filtered", header: "touch_pad.h".}
## *
##  @brief get raw data (touch sensor counter value) from IIR filter process.
##         Need not request hardware measurements.
##
##  @note touch_pad_filter_start has to be called before calling touch_pad_read_raw_data.
##        This function can be called from ISR
##
##  @param touch_num touch pad index
##  @param touch_value pointer to accept touch sensor value
##
##  @return
##      - ESP_OK Success
##      - ESP_ERR_INVALID_ARG Touch pad parameter error
##      - ESP_ERR_INVALID_STATE This touch pad hardware connection is error, the value of "touch_value" is 0.
##      - ESP_FAIL Touch pad not initialized
##

proc touch_pad_read_raw_data*(touch_num: touch_pad_t; touch_value: ptr uint16): esp_err_t {.
    importc: "touch_pad_read_raw_data", header: "touch_pad.h".}
## *
##  @brief Callback function that is called after each IIR filter calculation.
##  @note This callback is called in timer task in each filtering cycle.
##  @note This callback should not be blocked.
##  @param raw_value  The latest raw data(touch sensor counter value) that
##         points to all channels(raw_value[0..TOUCH_PAD_MAX-1]).
##  @param filtered_value  The latest IIR filtered data(calculated from raw data) that
##         points to all channels(filtered_value[0..TOUCH_PAD_MAX-1]).
##
##

type
  filter_cb_t* = proc (raw_value: ptr uint16; filtered_value: ptr uint16) {.cdecl.}

## *
##  @brief Register the callback function that is called after each IIR filter calculation.
##  @note The 'read_cb' callback is called in timer task in each filtering cycle.
##  @param read_cb  Pointer to filtered callback function.
##                  If the argument passed in is NULL, the callback will stop.
##  @return
##       - ESP_OK Success
##       - ESP_ERR_INVALID_ARG set error
##

proc touch_pad_set_filter_read_cb*(read_cb: filter_cb_t): esp_err_t {.
    importc: "touch_pad_set_filter_read_cb", header: "touch_pad.h".}
## *
##  @brief   Register touch-pad ISR.
##           The handler will be attached to the same CPU core that this function is running on.
##  @param fn  Pointer to ISR handler
##  @param arg  Parameter for ISR
##  @return
##      - ESP_OK Success ;
##      - ESP_ERR_INVALID_ARG GPIO error
##      - ESP_ERR_NO_MEM No memory
##

proc touch_pad_isr_register*(fn: intr_handler_t; arg: pointer): esp_err_t {.
    importc: "touch_pad_isr_register", header: "touch_pad.h".}
## *
##  @brief Deregister the handler previously registered using touch_pad_isr_handler_register
##  @param fn  handler function to call (as passed to touch_pad_isr_handler_register)
##  @param arg  argument of the handler (as passed to touch_pad_isr_handler_register)
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_STATE if a handler matching both fn and
##         arg isn't registered
##

proc touch_pad_isr_deregister*(fn: proc (a1: pointer); arg: pointer): esp_err_t {.
    importc: "touch_pad_isr_deregister", header: "touch_pad.h".}
## *
##  @brief Set touch sensor measurement and sleep time
##  @param sleep_cycle  The touch sensor will sleep after each measurement.
##                      sleep_cycle decide the interval between each measurement.
##                      t_sleep = sleep_cycle / (RTC_SLOW_CLK frequency).
##                      The approximate frequency value of RTC_SLOW_CLK can be obtained using rtc_clk_slow_freq_get_hz function.
##  @param meas_cycle The duration of the touch sensor measurement.
##                    t_meas = meas_cycle / 8M, the maximum measure time is 0xffff / 8M = 8.19 ms
##  @return
##       - ESP_OK on success
##

proc touch_pad_set_meas_time*(sleep_cycle: uint16; meas_cycle: uint16): esp_err_t {.
    importc: "touch_pad_set_meas_time", header: "touch_pad.h".}
## *
##  @brief Get touch sensor measurement and sleep time
##  @param sleep_cycle  Pointer to accept sleep cycle number
##  @param meas_cycle Pointer to accept measurement cycle count.
##  @return
##       - ESP_OK on success
##

proc touch_pad_get_meas_time*(sleep_cycle: ptr uint16; meas_cycle: ptr uint16): esp_err_t {.
    importc: "touch_pad_get_meas_time", header: "touch_pad.h".}
## *
##  @brief Set touch sensor reference voltage, if the voltage gap between high and low reference voltage get less,
##         the charging and discharging time would be faster, accordingly, the counter value would be larger.
##         In the case of detecting very slight change of capacitance, we can narrow down the gap so as to increase
##         the sensitivity. On the other hand, narrow voltage gap would also introduce more noise, but we can use a
##         software filter to pre-process the counter value.
##  @param refh the value of DREFH
##  @param refl the value of DREFL
##  @param atten the attenuation on DREFH
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_set_voltage*(refh: touch_high_volt_t; refl: touch_low_volt_t;
                           atten: touch_volt_atten_t): esp_err_t {.
    importc: "touch_pad_set_voltage", header: "touch_pad.h".}
## *
##  @brief Get touch sensor reference voltage,
##  @param refh pointer to accept DREFH value
##  @param refl pointer to accept DREFL value
##  @param atten pointer to accept the attenuation on DREFH
##  @return
##       - ESP_OK on success
##

proc touch_pad_get_voltage*(refh: ptr touch_high_volt_t; refl: ptr touch_low_volt_t;
                           atten: ptr touch_volt_atten_t): esp_err_t {.
    importc: "touch_pad_get_voltage", header: "touch_pad.h".}
## *
##  @brief Set touch sensor charge/discharge speed for each pad.
##         If the slope is 0, the counter would always be zero.
##         If the slope is 1, the charging and discharging would be slow, accordingly, the counter value would be small.
##         If the slope is set 7, which is the maximum value, the charging and discharging would be fast, accordingly, the
##         counter value would be larger.
##  @param touch_num touch pad index
##  @param slope touch pad charge/discharge speed
##  @param opt the initial voltage
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_set_cnt_mode*(touch_num: touch_pad_t; slope: touch_cnt_slope_t;
                            opt: touch_tie_opt_t): esp_err_t {.
    importc: "touch_pad_set_cnt_mode", header: "touch_pad.h".}
## *
##  @brief Get touch sensor charge/discharge speed for each pad
##  @param touch_num touch pad index
##  @param slope pointer to accept touch pad charge/discharge slope
##  @param opt pointer to accept the initial voltage
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_get_cnt_mode*(touch_num: touch_pad_t; slope: ptr touch_cnt_slope_t;
                            opt: ptr touch_tie_opt_t): esp_err_t {.
    importc: "touch_pad_get_cnt_mode", header: "touch_pad.h".}
## *
##  @brief Initialize touch pad GPIO
##  @param touch_num touch pad index
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_io_init*(touch_num: touch_pad_t): esp_err_t {.
    importc: "touch_pad_io_init", header: "touch_pad.h".}
## *
##  @brief Set touch sensor FSM mode, the test action can be triggered by the timer,
##         as well as by the software.
##  @param mode FSM mode
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_set_fsm_mode*(mode: touch_fsm_mode_t): esp_err_t {.
    importc: "touch_pad_set_fsm_mode", header: "touch_pad.h".}
## *
##  @brief Get touch sensor FSM mode
##  @param mode pointer to accept FSM mode
##  @return
##       - ESP_OK on success
##

proc touch_pad_get_fsm_mode*(mode: ptr touch_fsm_mode_t): esp_err_t {.
    importc: "touch_pad_get_fsm_mode", header: "touch_pad.h".}
## *
##  @brief Trigger a touch sensor measurement, only support in SW mode of FSM
##  @return
##       - ESP_OK on success
##

proc touch_pad_sw_start*(): esp_err_t {.importc: "touch_pad_sw_start",
                                     header: "touch_pad.h".}
## *
##  @brief Set touch sensor interrupt threshold
##  @param touch_num touch pad index
##  @param threshold threshold of touchpad count, refer to touch_pad_set_trigger_mode to see how to set trigger mode.
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_set_thresh*(touch_num: touch_pad_t; threshold: uint16): esp_err_t {.
    importc: "touch_pad_set_thresh", header: "touch_pad.h".}
## *
##  @brief Get touch sensor interrupt threshold
##  @param touch_num touch pad index
##  @param threshold pointer to accept threshold
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_get_thresh*(touch_num: touch_pad_t; threshold: ptr uint16): esp_err_t {.
    importc: "touch_pad_get_thresh", header: "touch_pad.h".}
## *
##  @brief Set touch sensor interrupt trigger mode.
##         Interrupt can be triggered either when counter result is less than
##         threshold or when counter result is more than threshold.
##  @param mode touch sensor interrupt trigger mode
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_set_trigger_mode*(mode: touch_trigger_mode_t): esp_err_t {.
    importc: "touch_pad_set_trigger_mode", header: "touch_pad.h".}
## *
##  @brief Get touch sensor interrupt trigger mode
##  @param mode pointer to accept touch sensor interrupt trigger mode
##  @return
##       - ESP_OK on success
##

proc touch_pad_get_trigger_mode*(mode: ptr touch_trigger_mode_t): esp_err_t {.
    importc: "touch_pad_get_trigger_mode", header: "touch_pad.h".}
## *
##  @brief Set touch sensor interrupt trigger source. There are two sets of touch signals.
##         Set1 and set2 can be mapped to several touch signals. Either set will be triggered
##         if at least one of its touch signal is 'touched'. The interrupt can be configured to be generated
##         if set1 is triggered, or only if both sets are triggered.
##  @param src touch sensor interrupt trigger source
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_set_trigger_source*(src: touch_trigger_src_t): esp_err_t {.
    importc: "touch_pad_set_trigger_source", header: "touch_pad.h".}
## *
##  @brief Get touch sensor interrupt trigger source
##  @param src pointer to accept touch sensor interrupt trigger source
##  @return
##       - ESP_OK on success
##

proc touch_pad_get_trigger_source*(src: ptr touch_trigger_src_t): esp_err_t {.
    importc: "touch_pad_get_trigger_source", header: "touch_pad.h".}
## *
##  @brief Set touch sensor group mask.
##         Touch pad module has two sets of signals, 'Touched' signal is triggered only if
##         at least one of touch pad in this group is "touched".
##         This function will set the register bits according to the given bitmask.
##  @param set1_mask bitmask of touch sensor signal group1, it's a 10-bit value
##  @param set2_mask bitmask of touch sensor signal group2, it's a 10-bit value
##  @param en_mask bitmask of touch sensor work enable, it's a 10-bit value
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_set_group_mask*(set1_mask: uint16; set2_mask: uint16;
                              en_mask: uint16): esp_err_t {.
    importc: "touch_pad_set_group_mask", header: "touch_pad.h".}
## *
##  @brief Get touch sensor group mask.
##  @param set1_mask pointer to accept bitmask of touch sensor signal group1, it's a 10-bit value
##  @param set2_mask pointer to accept bitmask of touch sensor signal group2, it's a 10-bit value
##  @param en_mask pointer to accept bitmask of touch sensor work enable, it's a 10-bit value
##  @return
##       - ESP_OK on success
##

proc touch_pad_get_group_mask*(set1_mask: ptr uint16; set2_mask: ptr uint16;
                              en_mask: ptr uint16): esp_err_t {.
    importc: "touch_pad_get_group_mask", header: "touch_pad.h".}
## *
##  @brief Clear touch sensor group mask.
##         Touch pad module has two sets of signals, Interrupt is triggered only if
##         at least one of touch pad in this group is "touched".
##         This function will clear the register bits according to the given bitmask.
##  @param set1_mask bitmask touch sensor signal group1, it's a 10-bit value
##  @param set2_mask bitmask touch sensor signal group2, it's a 10-bit value
##  @param en_mask bitmask of touch sensor work enable, it's a 10-bit value
##  @return
##       - ESP_OK on success
##       - ESP_ERR_INVALID_ARG if argument is wrong
##

proc touch_pad_clear_group_mask*(set1_mask: uint16; set2_mask: uint16;
                                en_mask: uint16): esp_err_t {.
    importc: "touch_pad_clear_group_mask", header: "touch_pad.h".}
## *
##  @brief To clear the touch status register, usually use this function in touch ISR to clear status.
##  @return
##       - ESP_OK on success
##

proc touch_pad_clear_status*(): esp_err_t {.importc: "touch_pad_clear_status",
    header: "touch_pad.h".}
## *
##  @brief Get the touch sensor status, usually used in ISR to decide which pads are 'touched'.
##  @return
##       - touch status
##

proc touch_pad_get_status*(): uint32 {.importc: "touch_pad_get_status",
                                      header: "touch_pad.h".}
## *
##  @brief To enable touch pad interrupt
##  @return
##       - ESP_OK on success
##

proc touch_pad_intr_enable*(): esp_err_t {.importc: "touch_pad_intr_enable",
                                        header: "touch_pad.h".}
## *
##  @brief To disable touch pad interrupt
##  @return
##       - ESP_OK on success
##

proc touch_pad_intr_disable*(): esp_err_t {.importc: "touch_pad_intr_disable",
    header: "touch_pad.h".}
## *
##  @brief set touch pad filter calibration period, in ms.
##         Need to call touch_pad_filter_start before all touch filter APIs
##  @param new_period_ms filter period, in ms
##  @return
##       - ESP_OK Success
##       - ESP_ERR_INVALID_STATE driver state error
##       - ESP_ERR_INVALID_ARG parameter error
##

proc touch_pad_set_filter_period*(new_period_ms: uint32): esp_err_t {.
    importc: "touch_pad_set_filter_period", header: "touch_pad.h".}
## *
##  @brief get touch pad filter calibration period, in ms
##         Need to call touch_pad_filter_start before all touch filter APIs
##  @param p_period_ms pointer to accept period
##  @return
##       - ESP_OK Success
##       - ESP_ERR_INVALID_STATE driver state error
##       - ESP_ERR_INVALID_ARG parameter error
##

proc touch_pad_get_filter_period*(p_period_ms: ptr uint32): esp_err_t {.
    importc: "touch_pad_get_filter_period", header: "touch_pad.h".}
## *
##  @brief start touch pad filter function
##       This API will start a filter to process the noise in order to prevent false triggering
##       when detecting slight change of capacitance.
##       Need to call touch_pad_filter_start before all touch filter APIs
##
##  @note This filter uses FreeRTOS timer, which is dispatched from a task with
##        priority 1 by default on CPU 0. So if some application task with higher priority
##        takes a lot of CPU0 time, then the quality of data obtained from this filter will be affected.
##        You can adjust FreeRTOS timer task priority in menuconfig.
##  @param filter_period_ms filter calibration period, in ms
##  @return
##       - ESP_OK Success
##       - ESP_ERR_INVALID_ARG parameter error
##       - ESP_ERR_NO_MEM No memory for driver
##       - ESP_ERR_INVALID_STATE driver state error
##

proc touch_pad_filter_start*(filter_period_ms: uint32): esp_err_t {.
    importc: "touch_pad_filter_start", header: "touch_pad.h".}
## *
##  @brief stop touch pad filter function
##         Need to call touch_pad_filter_start before all touch filter APIs
##  @return
##       - ESP_OK Success
##       - ESP_ERR_INVALID_STATE driver state error
##

proc touch_pad_filter_stop*(): esp_err_t {.importc: "touch_pad_filter_stop",
                                        header: "touch_pad.h".}
## *
##  @brief delete touch pad filter driver and release the memory
##         Need to call touch_pad_filter_start before all touch filter APIs
##  @return
##       - ESP_OK Success
##       - ESP_ERR_INVALID_STATE driver state error
##

proc touch_pad_filter_delete*(): esp_err_t {.importc: "touch_pad_filter_delete",
    header: "touch_pad.h".}
## *
##  @brief Get the touch pad which caused wakeup from sleep
##  @param pad_num pointer to touch pad which caused wakeup
##  @return
##       - ESP_OK Success
##       - ESP_FAIL get status err
##

proc touch_pad_get_wakeup_status*(pad_num: ptr touch_pad_t): esp_err_t {.
    importc: "touch_pad_get_wakeup_status", header: "touch_pad.h".}