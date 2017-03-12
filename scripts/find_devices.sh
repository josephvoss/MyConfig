#!/bin/bash

# Count number of Android and iOS devices on the network
# Finds devices from their open ports

CARBON_HOST="graphite.jvoss14.com"
CARBON_PORT="2003"

ANDROID_PORT="3580" # nati-srvloc
IOS_PORT="62078" # iphone-sync


ANDROID_NET0=$(nmap -p $ANDROID_PORT --open 192.168.0.* | grep open | wc -l)
ANDROID_NET1=$(nmap -p $ANDROID_PORT --open 192.168.1.* | grep open | wc -l)
ANDROID_COUNT=$(($ANDROID_NET0 + $ANDROID_NET1))

IOS_NET0=$(nmap -p $IOS_PORT --open 192.168.0.* | grep open | wc -l)
IOS_NET1=$(nmap -p $IOS_PORT --open 192.168.1.* | grep open | wc -l)
IOS_COUNT=$(($IOS_NET0 + $IOS_NET1))

TIME=$(date +%s)

echo "devices.ios" ${IOS_COUNT} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "devices.android" ${ANDROID_COUNT} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}

echo "Successful Devices upload: Android active: ${ANDROID_COUNT}. iOS Active: ${IOS_COUNT}."
