#!/bin/bash

# Logs important information about system usage

CARBON_HOST="graphite.jvoss14.com"
CARBON_PORT="2003"

RAM=$(free -m | sed -n 2p | awk '{print $3}')
UPTIME=$(awk '{print $1}' /proc/uptime)
CPU=$(top -bn2 | grep "Cpu" | sed 1d | awk '{print $2}')

TIME=$(date +%s)

echo "system.free_ram" ${RAM} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "system.cpu_usage" ${CPU} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}
echo "system.uptime" ${UPTIME} ${TIME} | nc ${CARBON_HOST} ${CARBON_PORT}

echo "Successful Usage upload: CPU active: ${CPU}. Free RAM: ${RAM} MB. Uptime ${UPTIME}"
