#!/bin/bash

CARBON_HOST="graphite.jvoss14.com"
CARBON_PORT="2003"

TEST_BIN="/home/zahir/speedtest-cli/speedtest.py"

TEST_LOG=$($TEST_BIN)

PING=$(echo $TEST_LOG | tr -d "\n" | sed "s/:\ /\n/g" | awk '{print $1}' | sed -n '2p')
DOWNLOAD=$(echo $TEST_LOG | tr -d "\n" | sed "s/:\ /\n/g" | awk '{print $1}' | sed -n '3p')
UPLOAD=$(echo $TEST_LOG | tr -d "\n" | sed "s/:\ /\n/g" | awk '{print $1}' | sed -n '4p')

TIME=$(date +%s)

echo "speedtest.ping" ${PING} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "speedtest.download" ${DOWNLOAD} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "speedtest.upload" ${UPLOAD} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}

echo "Successful speedtest upload"
