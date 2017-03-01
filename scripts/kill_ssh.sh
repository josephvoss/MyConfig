#!/bin/bash

# Kills first active ssh session found in ps aux
# Used to stop hung ssh quickly

kill $(ps aux | grep "ssh " | sed 2d | awk '{print $2}')
