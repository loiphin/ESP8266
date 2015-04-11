-- My crappy open garage door notifier.
-- init.lua sets up the wifi connection then runs the notify() function every 60 seconds.

print("Setting up WIFI...")
wifi.setmode(wifi.STATION)
--modify according your wireless router settings
wifi.sta.config("SSID","PASSWORD")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
if wifi.sta.getip()== nil then 
print("IP unavaiable, Waiting...") 
else 
tmr.stop(1)
print("Config done, IP is "..wifi.sta.getip())
dofile("hcsr04.lua")
device = hcsr04.init()
tmr.alarm(0, 60000, 1, function() notify() end)
end 
end)


