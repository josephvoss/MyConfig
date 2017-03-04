#!/usr/bin/python
import json
import urllib2
import datetime

curHour = datetime.datetime.now().hour

f = urllib2.urlopen('http://api.wunderground.com/api/key/hourly/q/TX/Austin.json')
json_string = f.read()
f.close()

parsed = json.loads(json_string)
hourly = parsed['hourly_forecast']

minTemp = 200
maxTemp = 0
curTemp = 0
curHumid = 0
for i in hourly:
    hour = int(i['FCTTIME']['hour'])
    temp = int(i['temp']['english'])
    humidity = int(i['humidity'])

    if temp > maxTemp:
        maxTemp = temp
    if temp < minTemp:
        minTemp = temp
    if hour == curHour:
        curTemp = temp
        curHumid = humidity

if maxTemp < 100:
    maxTemp = " " + str(maxTemp)
maxTemp = str(maxTemp)

if minTemp < 100:
    minTemp = " " + str(minTemp)
minTemp = str(minTemp)

if curTemp < 100:
    curTemp = " " + str(curTemp)
curTemp = str(curTemp)

if curHumid > 99:
    curHumid = 99
curHumid = str(curHumid)

print("Temp "+curTemp+" Hum "+curHumid+"%High "+maxTemp+" Low "+minTemp)
