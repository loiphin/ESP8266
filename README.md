# ESP8266 + HC-SR04 + MB102 = Open Garage Door Notifier

My crappy cobbling together of code for my ESP8266 module which uses a HC-SR04 ultrasonic sensor. This is a dirty hack together of code. Use as you wish. Don't cry if you think the code is shitty. 

Picture of my Open Garage Door Notifier - http://i.imgur.com/XUx8l6T.jpg

Note that the HC-SR04 is being driven by the 5v rail and the ESP8266 is of course on 3.3v. The ECHO pin on the HC-SR04 has a 1K resistor in line to prevent the HC-SR04 from hurting the ESP8266. The HC-SR04 has no problem receiving a 3.3v signal on the TRIG pin, from the ESP8266.

My ESP-01 pins are assigned to:


- GPIO0 and GPIO2 are used for ECHO and TRIG on the HC-SR04.
- CH_PD is connected to Vcc (3.3v).
- GND is ground, duh.
- VCC is 3.3v.
- RST is not connected.
- UTXD and URXD connected to RX and TX of your USB UART (e.g. FTDI232L) for testing only.



Change the SSID and PASSWORD to the real values in init.lua.

Change the GPIO pin assignments and YOUR_API_KEY for Notify My Android in hcsr04.lua.

See my youtube video of an "Open Garage Door" notifier: https://www.youtube.com/watch?v=3zI72pZsJ4M


