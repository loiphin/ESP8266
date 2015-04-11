
n=0

hcsr04 = {};

function hcsr04.init(pin_trig, pin_echo)
	local self = {}
	self.time_start = 0
	self.time_end = 0
-- Choose the correct GPIO pins for the trigger and echo of the HC-SR04 module
	self.trig = pin_trig or 3
	self.echo = pin_echo or 4
	gpio.mode(self.trig, gpio.OUTPUT)
	gpio.mode(self.echo, gpio.INT)

	function self.echo_cb(level)
		if level == 1 then
			self.time_start = tmr.now()
			gpio.trig(self.echo, "down")
		else
			self.time_end = tmr.now()
		end
	end

	function self.measure()
		gpio.trig(self.echo, "up", self.echo_cb)
		gpio.write(self.trig, gpio.HIGH)
		tmr.delay(100)
		gpio.write(self.trig, gpio.LOW)
		tmr.delay(100000)
		if (self.time_end - self.time_start) < 0 then
			return -1
		end
		return (self.time_end - self.time_start) / 58
	end
	return self
end

-- Check to see if the ultrasonic sensor measures less than 50cm. If there are two measurements in a row less than 50cm then send a notification.
-- This prevents false positives, as insects may set off the sensor every now and then.
function notify()
    if device.measure() < 50 then
        print("Door is Open")
        if n = 1 then
            conn=net.createConnection(net.TCP, 0)  
            conn:on("receive", function(conn, payload) print(payload)  end) 
            conn:connect(80,"50.116.34.97")  
            conn:send("GET /publicapi/notify?apikey=YOUR_API_KEY&application=ESP8266&event=G_DOOR_OPEN&description=Garage%20door%is%20open&priority=2\r\n HTTP/1.1\r\n") 
            conn:send("Host: notifymyandroid.com\r\n")  
            conn:send("Accept: */*\r\n") 
            conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n") 
            conn:send("\r\n")
            n = 0
        else n = 1
    else print("Door is closed")
    end
end
