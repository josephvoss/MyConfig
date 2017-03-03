#!/bin/bash

CARBON_HOST="graphite.jvoss14.com"
CARBON_PORT="2003"

TEST_BIN="/home/zahir/tespeed/tespeed.py -sw -dt 5 -ut 5 -cs 51200 http://austx-speedtest-01-a.texas.rr.com/speedtest/"

TEST_LOG=$($TEST_BIN)

PING=$(ping -c 5 8.8.8.8 | grep avg | awk '{print $4}')
PING_MAX=$(echo $PING | awk -F/ '{print $3}')
PING_MIN=$(echo $PING | awk -F/ '{print $1}')
PING_AVG=$(echo $PING | awk -F/ '{print $2}')

DOWNLOAD=$(echo $TEST_LOG | awk -F, '{print $1}')
UPLOAD=$(echo $TEST_LOG | awk -F, '{print $2}')

TIME=$(date +%s)

echo "speedtest.ping.avg" ${PING_AVG} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "speedtest.ping.min" ${PING_MIN} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "speedtest.ping.max" ${PING_MAX} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "speedtest.download" ${DOWNLOAD} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "speedtest.upload" ${UPLOAD} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}

echo "$PING_AVG $DOWNLOAD $UPLOAD"
echo "Successful speedtest upload"
