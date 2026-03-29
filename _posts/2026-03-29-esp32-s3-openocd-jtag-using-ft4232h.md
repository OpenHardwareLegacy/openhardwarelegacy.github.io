---
layout: post
title: "ESP32-S3 OpenOCD JTAG using FT4232H"
categories: [Blog]
tags: [Blog, Debugging, OpenSource]
---
![debugging](/files/ft4232h_esp32s3.jpg)

# Introduction
When debugging custom USB firmware it is inconvenient to use the inernal Serial/JTAG adapter of the ESP32-S3. I this case using 4-wire JTAG is preferred.

# ESP32-S3 JTAG using FT4232H via TCK, TDI, TDO, TMS

JTAG via hardware JTAG interface is disabled by default. Must burn efuse to enable it. The process is irreversible!

Tested using Aliexpress FT4232H breakout board and Unexprected Maker ProS3 devboard.

Connection diagram:

| FT4232H | ADBUS# | ESP32-S3 GPIO | Label      |
|---------|--------|---------------|------------|
| ADBUS0  | 0      | GPIO39        | MTCK (TCK) |
| ADBUS1  | 1      | GPIO41        | MTDI (TDI) |
| ADBUS2  | 2      | GPIO40        | MTDO (TDO) |
| ADBUS3  | 3      | GPIO42        | MTMS (TMS) |

1. Reset the target while holding BOOT0 pin
2. Run python -m espefuse -p /dev/ttyACM0 burn_efuse DIS_USB_JTAG
3. Verify that the efuse is burned by running python -m espefuse -p /dev/ttyACM0 summary | grep DIS_USB_JTAG
4. Reset the target again without BOOT0

## Using the Espressif OpenOCD fork from withing the docker container (using podman)

1. Make sure DIS_USB_JTAG efuse bit is already burned
2. Run openocd -f interface/ftdi/esp32_ftdi.cfg -c "ftdi vid_pid 0x0403 0x6011" -f target/esp32s3.cfg -c "adapter speed 5000"

```
root@suku-framework-12:/project# openocd -f interface/ftdi/esp_ftdi.cfg -c "ftdi vid_pid 0x0403 0x6011" -f target/esp32s3.cfg -c "adapter speed 5000"
Open On-Chip Debugger v0.12.0-esp32-20250422 (2025-04-22-13:02)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
adapter speed: 20000 kHz
adapter speed: 5000 kHz
Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Info : clock speed 5000 kHz
Info : JTAG tap: esp32s3.tap0 tap/device found: 0x120034e5 (mfg: 0x272 (Tensilica), part: 0x2003, ver: 0x1)
Info : JTAG tap: esp32s3.tap1 tap/device found: 0x120034e5 (mfg: 0x272 (Tensilica), part: 0x2003, ver: 0x1)
Info : [esp32s3.cpu0] Examination succeed
Info : [esp32s3.cpu1] Examination succeed
Info : [esp32s3.cpu0] starting gdb server on 3333
Info : Listening on port 3333 for gdb connections
Info : [esp32s3.cpu0] Debug controller was reset.
Info : [esp32s3.cpu0] Core was reset.
Info : [esp32s3.cpu1] Debug controller was reset.
Info : [esp32s3.cpu1] Core was reset.
Info : [esp32s3.cpu0] Target halted, PC=0x40378B82, debug_reason=00000000
Info : [esp32s3.cpu0] Reset cause (3) - (Software core reset)
Info : [esp32s3.cpu1] Target halted, PC=0x40378B82, debug_reason=00000000
Info : [esp32s3.cpu1] Reset cause (3) - (Software core reset)
```

## Using mainline OpenOCD

- interface/ftdi/esp32_ftdi.cfg is not available in mainline, use interface/ftdi/esp32_devkitj_v1.cfg instead

1. Make sure DIS_USB_JTAG efuse bit is already burned
2. Run openocd -f interface/ftdi/esp32_devkitj_v1.cfg -c "ftdi vid_pid 0x0403 0x6011" -f target/esp32s3.cfg -c "adapter speed 5000"

```
suku@suku-framework-12:~/Documents/grid-fw$ openocd -f interface/ftdi/esp32_devkitj_v1.cfg -c "ftdi vid_pid 0x0403 0x6011" -f target/esp32s3.cfg -c "adapter speed 5000"
Open On-Chip Debugger 0.12.0
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
force hard breakpoints
adapter speed: 5000 kHz

Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Info : clock speed 5000 kHz
Info : JTAG tap: esp32s3.cpu0 tap/device found: 0x120034e5 (mfg: 0x272 (Tensilica), part: 0x2003, ver: 0x1)
Info : JTAG tap: esp32s3.cpu1 tap/device found: 0x120034e5 (mfg: 0x272 (Tensilica), part: 0x2003, ver: 0x1)
Info : starting gdb server for esp32s3.cpu0 on 3333
Info : Listening on port 3333 for gdb connections
Info : [esp32s3.cpu0] Debug controller was reset.
Info : [esp32s3.cpu0] Core was reset.
Info : [esp32s3.cpu1] Debug controller was reset.
Info : [esp32s3.cpu1] Core was reset.
```
